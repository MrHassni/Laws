import 'package:flutter/material.dart';
import 'package:laws/screens/more_screens/edit_profile_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/constants.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Consumer<AuthProvider>(
          builder: (ctx, provider, child) => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 25,),
                Row(
                  children:  [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new, size: 25,color: Colors.brown.shade500,)),
                    const SizedBox(width: 10,),
                    Text('Profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.brown.shade500),)
                  ],
                ),
                const SizedBox(height: 25,),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: provider.currentUser ==
                      null || provider.currentUser!.image == null
                      ? const AssetImage('images/user.jpg') : NetworkImage(provider.currentUser!.path + provider.currentUser!.image!) as ImageProvider,
                ),
                const SizedBox(height: 20),
                Text(
                  '${provider.currentUser!.firstName} ${provider.currentUser!.lastName}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  provider.currentUser!.email,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  provider.currentUser!.phoneNo,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  provider.currentUser!.address,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 25,),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if(provider.currentUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  EditProfileScreen(user: provider.currentUser!)));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                        color: kAppBrown,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text('Edit Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}