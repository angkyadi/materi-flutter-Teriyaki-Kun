import 'package:cepu_app/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> signOut() async{
  await FirebaseAuth.instance.signOut();
  if(!mounted) return;
  Navigator.pushAndRemoveUntil(
    context , 
  MaterialPageRoute(builder: (context) => SignInScreen()), 
  (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(onPressed: (){
            signOut();
          }, icon: Icon(Icons.logout),
          tooltip : "Sign Out"),
        ],),
      body: Column(
        children: [
          Center(child : Text("Hallo ${FirebaseAuth.instance.currentUser?.displayName}")),
          const Center(child:  Text("You Have Been Signed In")),
        ],
      )
    );
  }
}

// void textSetUser() async{
//   User? user = FirebaseAuth.instance.currentUser;

//   if(user!= null){
//     await user.updateDisplayName("New Name");
//     await user.updateProfile(
//       displayName: "Michael Hermanto",
//       photoURL: "https://id.pinterest.com/pin/699817229634711693/"
//     );
//     await user.reload();
//   }
// }







