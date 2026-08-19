import 'package:flutter/material.dart';
import 'package:meditrack_admin/src/features/auth/presentation/pages/login_page.dart';
import 'package:meditrack_admin/src/widgets/button_widget.dart';

import '../../../../core/themes/app_color.dart';
import '../../../../widgets/local_storage.dart';
import '../../../../widgets/static_text.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authToken =  box.read(StorageVariable.jwtToken);
    var pp =  box.read(StorageVariable.profileId);
    print('sss $pp');
  /*  Future.delayed(Duration(seconds: 0)).then((value)async{
      if(authToken!=null){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    CustomBottomNavigationBar()),
                (Route<dynamic> route) => false);
      }else{
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    RegisterScreen1()),
                (Route<dynamic> route) => false);
      }
    });*/
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              color: AppColor.buttonColor,
            ),
          ),
          // Doctor Image
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0,),
              child: Image.asset(
                'assets/images/doctor.png', // Replace with your image
                height: 440,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          // Bottom Sheet Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                       Text(
                        StaticText.mediTrack,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        StaticText.mediTrackSubTitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // Dots indicator
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                          ),
                          Container(
                            width: 24,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.green,
                            ),
                          ),
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                  // Button
                  DefaultButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                  }, text: 'Get Started')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
