import 'dart:async';
import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laws/providers/lawyer_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  List<Marker> markers = []; // CLASS MEMBER, MAP OF MARKS
  bool searched = false;
  bool showFilters = false;
  dynamic ethnicityId = '';
  dynamic typeId = '';
  dynamic fieldId = '';
  int? theIndexEthnicity;
  int? theIndexType;
  int? theIndexField;

  TextEditingController searchController = TextEditingController();
  String? searchedString ;

  void _add(id, lat, long) {
    var markerIdVal = id;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      infoWindow: InfoWindow(title: markerIdVal, snippet: ''),
      // onTap: () {
      //   _onMarkerTapped(markerId);
      // },
    );

    setState(() {
      // adding a new marker to map
      markers.add(marker);
    });
  }

  addMarkers() {
    markers.clear();
    if (!searched) {
      Provider.of<LawyerProvider>(context, listen: false)
          .getAllLawyer()
          .then((_) {
        for (int i = 0;
            i <
                Provider.of<LawyerProvider>(context, listen: false)
                    .allLawyers
                    .length;
            i++) {
          _add(
              Provider.of<LawyerProvider>(context, listen: false)
                      .allLawyers[i]
                      .location +
                  i.toString(),
              double.parse(Provider.of<LawyerProvider>(context, listen: false)
                  .allLawyers[i]
                  .lat),
              double.parse(Provider.of<LawyerProvider>(context, listen: false)
                  .allLawyers[i]
                  .lng));
        }
      });
    } else {
      for (int i = 0;
          i <
              Provider.of<LawyerProvider>(context, listen: false)
                  .lawyersByField
                  .length;
          i++) {
        _add(
            Provider.of<LawyerProvider>(context, listen: false)
                    .lawyersByField[i]
                    .location +
                i.toString(),
            double.parse(Provider.of<LawyerProvider>(context, listen: false)
                .lawyersByField[i]
                .lat),
            double.parse(Provider.of<LawyerProvider>(context, listen: false)
                .lawyersByField[i]
                .lng));
      }
    }
  }

  static CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(51.529514, 0.173923),
    zoom: 10.5,
  );

  s() {
    log(Provider.of<LawyerProvider>(context, listen: false)
        .allCities
        .length
        .toString());
    searchedString =
        Provider.of<LawyerProvider>(context, listen: false).allCities.first;
  }

  @override
  void initState() {
    // s();
    setMyLocation();
    addMarkers();
    super.initState();
  }

  Future <PermissionStatus> permissionServices() async {

    PermissionStatus? statuses;

    if(await Permission.location.isGranted || await Permission.location.isLimited)
    {
      statuses =  await Permission.location.status;
    }else{
       statuses =  await Permission.location.request();
    }


    if (await Permission.location.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.location.status.isPermanentlyDenied == true &&
                await Permission.location.status.isGranted == false) {
              // openAppSettings();
              permissionServices(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else {
      if (await Permission.location.isDenied) {
        permissionServices();
      }
    }

    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  }

  setMyLocation() async {
    await permissionServices().then((value) async {
      _kGooglePlex = searched
          ? CameraPosition(
              target: LatLng(
                  double.parse(
                      Provider.of<LawyerProvider>(context, listen: false)
                          .lawyersByField
                          .last
                          .lat),
                  double.parse(
                      Provider.of<LawyerProvider>(context, listen: false)
                          .lawyersByField
                          .last
                          .lng)),
              zoom: 10.5,
            )
          : const CameraPosition(
              target: LatLng(51.529514, 0.173923),
              zoom: 10.5,
            );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Consumer<LawyerProvider>(
          builder: (ctx, provider, child) => Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  myLocationEnabled: true,
                  markers: markers.toSet(),
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  mapToolbarEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                margin: const EdgeInsets.only(top: 25),
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: kAppBrown,
                                      size: 20,
                                    )))),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 25, left: 10, right: 10),
                          width: MediaQuery.of(context).size.width * 0.9 - 100,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Search By Town/City',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: provider.allCities
                                  .map((item) => DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: searchedString,
                              onChanged: (value) {
                                setState(() {
                                  searchedString = value!;
                                });
                                provider
                                    .getLawyersByField(
                                    fieldId: '',
                                    typeId: '',
                                    ethnicity: '',
                                    location: searchedString == null ? '' : searchedString!)
                                    .then((_) {
                                  addMarkers();
                                  setMyLocation();
                                  setState(() {
                                    searched = true;
                                  });
                                });
                                FocusScope.of(context).unfocus();
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 200,
                              ),
                              dropdownStyleData: const DropdownStyleData(
                                maxHeight: 200,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                              dropdownSearchData: DropdownSearchData(
                                searchController: searchController,
                                searchInnerWidgetHeight: 50,
                                searchInnerWidget: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 4,
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: TextFormField(
                                    expands: true,
                                    maxLines: null,
                                    controller: searchController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 8,
                                      ),
                                      hintText: 'Search By Town/City',
                                      hintStyle: const TextStyle(fontSize: 12),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                                searchMatchFn: (item, searchValue) {
                                  return item.value
                                      .toString()
                                      .contains(searchValue.toCapitalized());
                                },
                              ),
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  searchController.clear();
                                }
                              },
                            ),
                          ),
                        ),
                        // Container(
                        //   margin:
                        //       const EdgeInsets.only(top: 25, left: 10, right: 10),
                        //   width: MediaQuery.of(context).size.width * 0.9 - 100,
                        //   height: 35,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(20),
                        //   ),
                        //   child: TextField(
                        //     controller: searchController,
                        //     maxLines: 1,
                        //     // scrollPadding: EdgeInsets.all(0),
                        //     // controller: controller,
                        //     // onSubmitted: (search) {
                        //     //   log(search);
                        //     //   provider
                        //     //       .getLawyersByField(
                        //     //           fieldId: '',
                        //     //           typeId: '',
                        //     //           ethnicity: '',
                        //     //           location: search)
                        //     //       .then((_) {
                        //     //     addMarkers();
                        //     //     setMyLocation();
                        //     //     setState(() {
                        //     //       searched = true;
                        //     //     });
                        //     //   });
                        //     // },
                        //     decoration: InputDecoration(
                        //       hintText: 'Search By Town/City',
                        //       hintStyle: TextStyle(color: kAppBrown),
                        //       // suffixIcon: Icon(
                        //       //   Icons.search,
                        //       //   color: kAppBrown,
                        //       // ),
                        //       border: InputBorder.none,
                        //       contentPadding: const EdgeInsets.symmetric(
                        //           horizontal: 20, vertical: 12),
                        //     ),
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            log(searchController.text);
                            provider
                                .getLawyersByField(
                                    fieldId: '',
                                    typeId: '',
                                    ethnicity: '',
                                    location: searchedString == null ? '' : searchedString!)
                                .then((_) {
                              addMarkers();
                              setMyLocation();
                              setState(() {
                                searched = true;
                              });
                            });
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 25),
                              child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Icon(
                                    CupertinoIcons.search,
                                    color: kAppBrown,
                                    size: 20,
                                  ))),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              showFilters = !showFilters;
                            });
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 25),
                              child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Icon(
                                    CupertinoIcons.color_filter,
                                    color: kAppBrown,
                                    size: 20,
                                  ))),
                        ),
                      ],
                    ),
                    !showFilters
                        ? const SizedBox()
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: kAppBrown.withOpacity(0.25)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Filter By Id Type

                                  const Text(
                                    'Filter By Type',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 20,
                                    child: ListView.separated(
                                      itemCount: provider.lawyersTypes.length,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const Divider(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            if (theIndexType != index) {
                                              setState(() {
                                                theIndexType = index;
                                                searched = true;
                                                typeId = provider
                                                    .lawyersTypes[index]['id'];
                                              });
                                            } else {
                                              setState(() {
                                                theIndexType = null;
                                                typeId = '';
                                              });
                                            }
                                            provider.getLawyersByField(
                                                fieldId: fieldId,
                                                typeId: typeId,
                                                ethnicity: ethnicityId,
                                                location:
                                                searchedString == null ? '' : searchedString!);
                                          },
                                          child: FittedBox(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7.5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                  color: theIndexType == index
                                                      ? kAppBrown
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text(
                                                  '${provider.lawyersTypes[index]['name']}'),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // Filter By Id Type
                                  const SizedBox(height: 15),
                                  const Text(
                                    'Filter By Ethnicity',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 20,
                                    child: ListView.separated(
                                      itemCount:
                                          provider.lawyersEthnicities.length,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const Divider(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            if (theIndexEthnicity != index) {
                                              setState(() {
                                                theIndexEthnicity = index;
                                                searched = true;
                                                ethnicityId =
                                                    provider.lawyersEthnicities[
                                                        index]['id'];
                                              });
                                            } else {
                                              setState(() {
                                                theIndexEthnicity = null;
                                                ethnicityId = '';
                                              });
                                            }
                                            provider.getLawyersByField(
                                                fieldId: fieldId,
                                                typeId: typeId,
                                                ethnicity: ethnicityId,
                                                location:
                                                searchedString == null ? '' : searchedString!);
                                          },
                                          child: FittedBox(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7.5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                  color:
                                                      theIndexEthnicity == index
                                                          ? kAppBrown
                                                          : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text(
                                                  '${provider.lawyersEthnicities[index]['name']}'),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // Filter By Id Type
                                  const SizedBox(height: 15),
                                  const Text(
                                    'Filter By Field',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 20,
                                    child: ListView.separated(
                                      itemCount:
                                          provider.lawyersCategories.length,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const Divider(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            if (theIndexField != index) {
                                              setState(() {
                                                theIndexField = index;
                                                searched = true;
                                                fieldId =
                                                    provider.lawyersCategories[
                                                        index]['id'];
                                              });
                                            } else {
                                              setState(() {
                                                theIndexField = null;
                                                fieldId = '';
                                              });
                                            }
                                            provider.getLawyersByField(
                                                fieldId: fieldId,
                                                typeId: typeId,
                                                ethnicity: ethnicityId,
                                                location:
                                                searchedString == null ? '' : searchedString!);
                                          },
                                          child: FittedBox(
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7.5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                  color: theIndexField == index
                                                      ? kAppBrown
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Text(
                                                  '${provider.lawyersCategories[index]['name']}'),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.5,
                minChildSize: 0.15,
                maxChildSize: 0.8,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    child: searched
                        ? provider.lawyersByField.isEmpty
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'No lawyers available in your searched area.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kAppBrown,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                            : ListView.builder(
                                padding: const EdgeInsets.only(
                                    top: 25, left: 10, right: 10, bottom: 55),
                                controller: scrollController,
                                itemCount: provider.lawyersByField.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            insetPadding:
                                                const EdgeInsets.all(25),
                                            backgroundColor: kAppBrown,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                        margin: const EdgeInsets
                                                                .only(
                                                            top: 10, left: 10),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: const Icon(
                                                          Icons
                                                              .arrow_back_ios_new,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ),
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.cyan.shade100,
                                                  radius: 30,
                                                  child: Text(
                                                    '${provider.lawyersByField[index].firstName[0]}${provider.lawyersByField[index].lastName[0]}',
                                                    style: TextStyle(
                                                        color: kAppBrown,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  '${provider.lawyersByField[index].firstName} ${provider.lawyersByField[index].lastName}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  provider.lawyersByField[index]
                                                      .location,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    provider
                                                                .lawyersByField[
                                                                    index]
                                                                .phoneNo ==
                                                            null
                                                        ? const SizedBox()
                                                        : InkWell(
                                                            onTap: () async {
                                                              final Uri
                                                                  launchUri =
                                                                  Uri(
                                                                scheme: 'tel',
                                                                path: provider
                                                                    .lawyersByField[
                                                                        index]
                                                                    .phoneNo,
                                                              );
                                                              await launchUrl(
                                                                  launchUri);
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .cyan
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Icon(
                                                                Icons.phone,
                                                                color:
                                                                    kAppBrown,
                                                              ),
                                                            ),
                                                          ),
                                                    InkWell(
                                                      onTap: () {
                                                        final Uri
                                                            emailLaunchUri =
                                                            Uri(
                                                          scheme: 'mailto',
                                                          path: provider
                                                              .lawyersByField[
                                                                  index]
                                                              .email,
                                                          query:
                                                              encodeQueryParameters(<String,
                                                                  String>{
                                                            'subject':
                                                                'Hello!\n\nI need help with',
                                                          }),
                                                        );

                                                        launchUrl(
                                                            emailLaunchUri);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .cyan.shade100,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Icon(
                                                          Icons.mail,
                                                          color: kAppBrown,
                                                        ),
                                                      ),
                                                    ),
                                                    provider
                                                                .lawyersByField[
                                                                    index]
                                                                .website ==
                                                            null
                                                        ? const SizedBox()
                                                        : InkWell(
                                                            onTap: () async {
                                                              if (!await launchUrl(
                                                                  Uri.parse(provider
                                                                      .lawyersByField[
                                                                          index]
                                                                      .website))) {
                                                                throw Exception(
                                                                    'Could not launch ${provider.lawyersByField[index].website}');
                                                              }
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .cyan
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Icon(
                                                                Icons.web,
                                                                color:
                                                                    kAppBrown,
                                                              ),
                                                            ),
                                                          ),
                                                    provider
                                                                .lawyersByField[
                                                                    index]
                                                                .startTime ==
                                                            null
                                                        ? const SizedBox()
                                                        : InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        //set border radius more than 50% of height and width to make circle
                                                                      ),
                                                                      title: Text(
                                                                          'Availability time of ${provider.lawyersByField[index].firstName} ${provider.lawyersByField[index].lastName}.'),
                                                                      // To display the title it is optional
                                                                      content:
                                                                          Container(
                                                                        padding:
                                                                            const EdgeInsets.all(15),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.green.shade100,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            Text(
                                                                          '${provider.lawyersByField[index].startTime}  to  ${provider.lawyersByField[index].endTime}',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 18),
                                                                        ),
                                                                      ),
                                                                      // Message which will be pop up on the screen
                                                                      // Action widget which will provide the user to acknowledge the choice
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            'Ok',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  });
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .cyan
                                                                      .shade100,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Icon(
                                                                Icons
                                                                    .calendar_month,
                                                                color:
                                                                    kAppBrown,
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                provider.lawyersByField[index]
                                                                .qualification ==
                                                            null &&
                                                        provider
                                                                .lawyersByField[
                                                                    index]
                                                                .sraNumber ==
                                                            null &&
                                                        provider
                                                                .lawyersByField[
                                                                    index]
                                                                .sraAuthorized ==
                                                            null
                                                    ? const SizedBox()
                                                    : const SizedBox(
                                                        height: 20,
                                                      ),
                                                provider.lawyersByField[index]
                                                                .qualification ==
                                                            null &&
                                                        provider
                                                                .lawyersByField[
                                                                    index]
                                                                .sraNumber ==
                                                            null &&
                                                        provider
                                                                .lawyersByField[
                                                                    index]
                                                                .sraAuthorized ==
                                                            null
                                                    ? const SizedBox()
                                                    : const Text(
                                                        'Lawyer Info',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                provider.lawyersByField[index]
                                                                .qualification ==
                                                            null &&
                                                        provider
                                                                .lawyersByField[
                                                                    index]
                                                                .sraNumber ==
                                                            null &&
                                                        provider
                                                                .lawyersByField[
                                                                    index]
                                                                .sraAuthorized ==
                                                            null
                                                    ? const SizedBox()
                                                    : const SizedBox(
                                                        height: 10,
                                                      ),
                                                provider.lawyersByField[index]
                                                                .qualification ==
                                                            null &&
                                                        provider
                                                                .lawyersByField[
                                                                    index]
                                                                .sraNumber ==
                                                            null &&
                                                        provider
                                                                .lawyersByField[
                                                                    index]
                                                                .sraAuthorized ==
                                                            null
                                                    ? const SizedBox()
                                                    : SizedBox(
                                                        height: 50,
                                                        child: ListView(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          children: [
                                                            provider
                                                                        .lawyersByField[
                                                                            index]
                                                                        .qualification ==
                                                                    null
                                                                ? const SizedBox()
                                                                : Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .settings_input_svideo,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              'Qualification',
                                                                              style: TextStyle(color: Colors.white, fontSize: 13),
                                                                            ),
                                                                            Text(
                                                                              provider.lawyersByField[index].qualification.toString(),
                                                                              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    )),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            provider
                                                                        .lawyersByField[
                                                                            index]
                                                                        .sraNumber ==
                                                                    null
                                                                ? const SizedBox()
                                                                : Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .settings,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              'SRA Number',
                                                                              style: TextStyle(color: Colors.white, fontSize: 13),
                                                                            ),
                                                                            Text(
                                                                              provider.lawyersByField[index].sraNumber.toString(),
                                                                              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    )),
                                                            const SizedBox(
                                                              width: 15,
                                                            ),
                                                            provider
                                                                        .lawyersByField[
                                                                            index]
                                                                        .sraAuthorized ==
                                                                    null
                                                                ? const SizedBox()
                                                                : Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .settings,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              'SRA Authorized',
                                                                              style: TextStyle(color: Colors.white, fontSize: 13),
                                                                            ),
                                                                            Text(
                                                                              provider.lawyersByField[index].sraAuthorized.toString(),
                                                                              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    )),
                                                          ],
                                                        ),
                                                      ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                provider.lawyersByField[index]
                                                            .area ==
                                                        null
                                                    ? const SizedBox()
                                                    : const Text(
                                                        'Operating Areas',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                provider.lawyersByField[index]
                                                            .area ==
                                                        null
                                                    ? const SizedBox()
                                                    : const SizedBox(
                                                        height: 10,
                                                      ),
                                                provider.lawyersByField[index]
                                                            .area ==
                                                        null
                                                    ? const SizedBox()
                                                    : Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Text(
                                                          provider
                                                              .lawyersByField[
                                                                  index]
                                                              .area
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                const Text(
                                                  'About',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Text(
                                          provider
                                              .lawyersByField[index]
                                              .description == null ? 'N/A' : provider
                                                        .lawyersByField[index]
                                                        .description
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Card(
                                        color: Colors.green.shade200,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Container(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.blue.shade100,
                                                  child: Text(
                                                      '${provider.lawyersByField[index].firstName[0]}${provider.lawyersByField[index].lastName[0]}'),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  '${provider.lawyersByField[index].firstName} ${provider.lawyersByField[index].lastName}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ))),
                                  );
                                },
                              )
                        : ListView.builder(
                            padding: const EdgeInsets.only(
                                top: 25, left: 10, right: 10, bottom: 55),
                            controller: scrollController,
                            itemCount: provider.allLawyers.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        insetPadding: const EdgeInsets.all(25),
                                        backgroundColor: kAppBrown,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10, left: 10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Icon(
                                                      Icons.arrow_back_ios_new,
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.cyan.shade100,
                                              radius: 30,
                                              child: Text(
                                                '${provider.allLawyers[index].firstName[0]}${provider.allLawyers[index].lastName[0]}',
                                                style: TextStyle(
                                                    color: kAppBrown,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              '${provider.allLawyers[index].firstName} ${provider.allLawyers[index].lastName}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              provider
                                                  .allLawyers[index].location,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                provider.allLawyers[index]
                                                            .phoneNo ==
                                                        null
                                                    ? const SizedBox()
                                                    : InkWell(
                                                        onTap: () async {
                                                          final Uri launchUri =
                                                              Uri(
                                                            scheme: 'tel',
                                                            path: '+44 794 608 9604',
                                                          );
                                                          await launchUrl(
                                                              launchUri);
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.cyan
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Icon(
                                                            Icons.phone,
                                                            color: kAppBrown,
                                                          ),
                                                        ),
                                                      ),
                                                InkWell(
                                                  onTap: () {
                                                    final Uri emailLaunchUri =
                                                        Uri(
                                                      scheme: 'mailto',
                                                      path: 'admin@immig-assist@co.uk',
                                                      // path: provider
                                                      //     .allLawyers[index]
                                                      //     .email,
                                                      query:
                                                          encodeQueryParameters(<String,
                                                              String>{
                                                        'subject':
                                                            'Hello!\n\nI need help with',
                                                      }),
                                                    );

                                                    launchUrl(emailLaunchUri);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .cyan.shade100,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Icon(
                                                      Icons.mail,
                                                      color: kAppBrown,
                                                    ),
                                                  ),
                                                ),
                                                provider.allLawyers[index]
                                                            .website ==
                                                        null
                                                    ? const SizedBox()
                                                    : InkWell(
                                                        onTap: () async {
                                                          if (!await launchUrl(
                                                              Uri.parse('https://immig-assist.co.uk/'))) {
                                                            throw Exception(
                                                                'Could not launch https://immig-assist.co.uk/');
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.cyan
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Icon(
                                                            Icons.web,
                                                            color: kAppBrown,
                                                          ),
                                                        ),
                                                      ),
                                                provider.allLawyers[index]
                                                            .startTime ==
                                                        null
                                                    ? const SizedBox()
                                                    : InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    //set border radius more than 50% of height and width to make circle
                                                                  ),
                                                                  title: Text(
                                                                      'Availability time of ${provider.allLawyers[index].firstName} ${provider.allLawyers[index].lastName}.'),
                                                                  // To display the title it is optional
                                                                  content:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            15),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green
                                                                            .shade100,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Text(
                                                                      '${provider.allLawyers[index].startTime}  to  ${provider.allLawyers[index].endTime}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                  ),
                                                                  // Message which will be pop up on the screen
                                                                  // Action widget which will provide the user to acknowledge the choice
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Ok',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 17),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.cyan
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50)),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Icon(
                                                            Icons
                                                                .calendar_month,
                                                            color: kAppBrown,
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            provider.allLawyers[index]
                                                            .qualification ==
                                                        null &&
                                                    provider.allLawyers[index]
                                                            .sraNumber ==
                                                        null &&
                                                    provider.allLawyers[index]
                                                            .sraAuthorized ==
                                                        null
                                                ? const SizedBox()
                                                : const SizedBox(
                                                    height: 20,
                                                  ),
                                            provider.allLawyers[index]
                                                            .qualification ==
                                                        null &&
                                                    provider.allLawyers[index]
                                                            .sraNumber ==
                                                        null &&
                                                    provider.allLawyers[index]
                                                            .sraAuthorized ==
                                                        null
                                                ? const SizedBox()
                                                : const Text(
                                                    'Lawyer Info',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                            provider.allLawyers[index]
                                                            .qualification ==
                                                        null &&
                                                    provider.allLawyers[index]
                                                            .sraNumber ==
                                                        null &&
                                                    provider.allLawyers[index]
                                                            .sraAuthorized ==
                                                        null
                                                ? const SizedBox()
                                                : const SizedBox(
                                                    height: 10,
                                                  ),
                                            provider.allLawyers[index]
                                                            .qualification ==
                                                        null &&
                                                    provider.allLawyers[index]
                                                            .sraNumber ==
                                                        null &&
                                                    provider.allLawyers[index]
                                                            .sraAuthorized ==
                                                        null
                                                ? const SizedBox()
                                                : SizedBox(
                                                    height: 50,
                                                    child: ListView(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      children: [
                                                        provider
                                                                    .allLawyers[
                                                                        index]
                                                                    .qualification ==
                                                                null
                                                            ? const SizedBox()
                                                            : Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .settings_input_svideo,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Text(
                                                                          'Qualification',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 13),
                                                                        ),
                                                                        Text(
                                                                          provider
                                                                              .allLawyers[index]
                                                                              .qualification
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        provider
                                                                    .allLawyers[
                                                                        index]
                                                                    .sraNumber ==
                                                                null
                                                            ? const SizedBox()
                                                            : Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .settings,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Text(
                                                                          'SRA Number',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 13),
                                                                        ),
                                                                        Text(
                                                                          provider
                                                                              .allLawyers[index]
                                                                              .sraNumber
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        provider
                                                                    .allLawyers[
                                                                        index]
                                                                    .sraAuthorized ==
                                                                null
                                                            ? const SizedBox()
                                                            : Container(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        5),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                child: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .settings,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        const Text(
                                                                          'SRA Authorized',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 13),
                                                                        ),
                                                                        Text(
                                                                          provider
                                                                              .allLawyers[index]
                                                                              .sraAuthorized
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                )),
                                                      ],
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            provider.allLawyers[index].area ==
                                                    null
                                                ? const SizedBox()
                                                : const Text(
                                                    'Operating Areas',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                            provider.allLawyers[index].area ==
                                                    null
                                                ? const SizedBox()
                                                : const SizedBox(
                                                    height: 10,
                                                  ),
                                            provider.allLawyers[index].area ==
                                                    null
                                                ? const SizedBox()
                                                : Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      provider.allLawyers[index]
                                                          .area
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text(
                                              'About',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Text(
                                                provider.allLawyers[index]
                                                    .description == null ? 'N/A' :provider.allLawyers[index]
                                                    .description
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                    color: Colors.green.shade200,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Colors.blue.shade100,
                                              child: Text(
                                                  '${provider.allLawyers[index].firstName[0]}${provider.allLawyers[index].lastName[0]}'),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context).width - 150,
                                              child: Text(
                                                '${provider.allLawyers[index].firstName} ${provider.allLawyers[index].lastName}',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ))),
                              );
                            },
                          ),
                  );
                },
              ),
            ],
          ),
        )
        // floatingActionButton: FloatingActionButton(
        //   foregroundColor: Colors.white,
        //   backgroundColor: Colors.blue,
        //   onPressed: () async {
        //     getUserCurrentLocation().then((value) async {
        //       log("${value.latitude} ${value.longitude}");
        //
        //       // specified current users location
        //       CameraPosition cameraPosition = CameraPosition(
        //         target: LatLng(value.latitude, value.longitude),
        //         zoom: 12.5,
        //       );
        //
        //       final GoogleMapController controller = await _controller.future;
        //       controller
        //           .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        //       setState(() {});
        //     });
        //   },
        //   child: const Icon(Icons.my_location),
        // ),
        );
  }
}
