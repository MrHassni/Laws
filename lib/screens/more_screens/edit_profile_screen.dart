import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laws/models/client_profile_model.dart';
import 'package:laws/providers/auth_provider.dart';
import 'package:laws/screens/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';

class EditProfileScreen extends StatefulWidget {
  final ClientModel user;

  const EditProfileScreen({super.key, required this.user});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  File? _pickedImage;
  bool loading = false;
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = File(pickedImage!.path);
    });
  }

  setData() {
    _fNameController.text = widget.user.firstName;
    _lNameController.text = widget.user.lastName;
    _phoneController.text = widget.user.phoneNo;
    _addressController.text = widget.user.address;
    setState(() {});
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 25,
                        color: Colors.brown.shade500,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Profile Edit',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade500),
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                        radius: 80,
                        backgroundImage: _pickedImage != null
                            ? FileImage(
                                _pickedImage!,
                              )
                            : widget.user.image == null
                                ? const AssetImage('images/user.jpg')
                                : NetworkImage(
                                        widget.user.path + widget.user.image!)
                                    as ImageProvider),
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              CustomTextField(
                hint: _fNameController.text.isEmpty
                    ? 'First Name'
                    : _fNameController.text,
                textEditingController: _fNameController,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hint: _lNameController.text.isEmpty
                    ? 'Last Name'
                    : _lNameController.text,
                textEditingController: _lNameController,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hint: _phoneController.text.isEmpty
                    ? 'Phone Number'
                    : _phoneController.text,
                textEditingController: _phoneController,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hint: _addressController.text.isEmpty
                    ? 'Address'
                    : _addressController.text,
                textEditingController: _addressController,
              ),
              const SizedBox(
                height: 25,
              ),
             loading ?
             Container(
               width: MediaQuery.of(context).size.width - 50,
               padding:
               const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
               decoration: BoxDecoration(
                   color: kAppBrown,
                   borderRadius: BorderRadius.circular(10)),
               child: const Center(child: CircularProgressIndicator(color: Colors.white,)),
             )
                 : InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  Provider.of<AuthProvider>(context, listen: false).editProfile(
                      id: widget.user.id.toString(),
                      fName: _fNameController.text,
                      lName: _lNameController.text,
                      phoneNo: _phoneController.text,
                      address: _addressController.text,
                      myImage: _pickedImage,
                      context: context).then((_){
                        loading = false;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                      color: kAppBrown,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('Apply Changes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16)),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
