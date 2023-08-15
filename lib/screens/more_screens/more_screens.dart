import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laws/screens/more_screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../auth_screens/main_auth_screen.dart';
import '../more_screens/widgets/more_screen_button.dart';

class MoreScreen extends StatefulWidget {
   const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              'MORE',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade500),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Divider(
                thickness: 1.5,
                color: Colors.brown.shade500,
              ),
            ),
            const MoreScreenButton(
              text: "SUBSCRIPTION",
              iconData: CupertinoIcons.creditcard_fill,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
              child: const MoreScreenButton(
                text: "PROFILE",
                iconData: CupertinoIcons.profile_circled,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                Uri url =
                    Uri.parse('http://test.immig-assist.co.uk/privacy-policy');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const MoreScreenButton(
                text: "PRIVACY POLICY",
                iconData: Icons.privacy_tip,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                Uri url =
                    Uri.parse('http://test.immig-assist.co.uk/what-we-do');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const MoreScreenButton(
                text: "DISCLAIMERS",
                iconData: Icons.info,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                Uri url =
                    Uri.parse('http://test.immig-assist.co.uk/contact-us');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const MoreScreenButton(
                text: "HELP",
                iconData: Icons.help_center,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                Uri url = Uri.parse(
                    'http://test.immig-assist.co.uk/terms-and-conditions');
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              child: const MoreScreenButton(
                text: "TERMS AND CONDITIONS",
                iconData: Icons.assignment,
              ),
            ),
            InkWell(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    title: const Text('Are you sure?'),
                    content: const Text('You want to logout?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No', style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                      TextButton(
                        onPressed: () async {
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          await preferences.clear();
                          if(context.mounted) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainAuthScreen()));
                          }
                        },
                        child: const Text('Yes',style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red
                        )),
                      ),
                    ],
                  ),
                );

              },
              child: Card(
                color: Colors.red.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.help_center,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'LOGOUT',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.red.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'DELETE ACCOUNT',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
