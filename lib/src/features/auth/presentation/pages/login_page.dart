import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditrack_admin/src/core/themes/app_color.dart';
import 'package:meditrack_admin/src/core/utils/logger.dart';
import 'package:meditrack_admin/src/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:meditrack_admin/src/features/hospital_signup/presentation/screens/hospital_signup_screen.dart';
import 'package:meditrack_admin/src/features/records/add_record_screen.dart';
import 'package:meditrack_admin/src/widgets/common_appbar.dart';
import 'package:meditrack_admin/src/widgets/snack_bar.dart';
import 'package:meditrack_admin/src/widgets/static_text.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../relations/relation_details_screen.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';

class LoginPage extends StatefulWidget {
   LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isRememberCheck=true;
  bool isRead = false;
  int userId =-1;
  String? timeStamp ='';
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: StaticText.loginText,),
      body: BlocConsumer<LoginBloc,LoginState>(
        listener:(context,state){
           if (state is OtpSent) {
            userId = state.userId?.toInt() ?? 0;
            timeStamp = state.timeStamp;
            CustomSnackBar.toast( StaticText.otpSentSuccessfully, );
          } else if (state is LoginSuccess) {
             CustomSnackBar.toast(StaticText.loginSuccess, );
             Navigator.pushAndRemoveUntil(
                 context,
                 MaterialPageRoute(
                     builder: (BuildContext context) =>
                     RelationDetailsScreen()),
                     (Route<dynamic> route) => false);
          } else if (state is OtpInvalid) {
            CustomSnackBar.toast(StaticText.invalidOtp,);
          }
        } ,
        builder: (context,state){
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0,left: 20,top: 70,bottom: 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StaticText.signIn,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            fontFamily: GoogleFonts.inter().fontFamily
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        StaticText.hiWelcomeBack,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      SizedBox(height: 40),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(StaticText.emailId,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                          SizedBox(height: 15),
                          CustomTextField(
                            readOnly: isRead,
                            hintText: StaticText.enterEmail,
                            validator: (value) {
                              if (value == null || value.isEmpty) return StaticText.emailRequired;
                              //if (!RegExp(r'^\d{10}$').hasMatch(value)) return StaticText.enterTenDigitNumber;
                              return null;
                            },
                            controller: emailController,
                            onChanged: (val){
                              // if(val.length==10){
                              //   context.read<LoginBloc>().add(CheckMobileEvent(emailController.text));
                              // }
                            },
                          ),
                          SizedBox(height: 10),
                          Text(StaticText.passwordText,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                          SizedBox(height: 15),
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) return StaticText.passwordRequired;
                              //if (!RegExp(r'^\d{6}$').hasMatch(value)) return StaticText.enterSixDigitNumber;
                              return null;
                            },
                            hintText: StaticText.passwordText,
                            controller: passwordController
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                fillColor: WidgetStateProperty.all(Colors.green),
                                value: isRememberCheck,
                                shape: CircleBorder(),
                                onChanged: (bool? value) {
                                  setState(() {
                                    isRememberCheck = value!;
                                  });
                                },
                              ),
                              // ),
                              Text(StaticText.rememberMeText)
                            ],
                          ),
                          TextButton(onPressed: (){

                          }, child: Text('Forgot Password ?',style: TextStyle(color: Colors.blue),)),
                        ],
                      ),
                      SizedBox(height: 10),
                      state is LoginLoading ? CircularProgressIndicator(color: AppColor.buttonColor,) : DefaultButton(onPressed: (){
                      logger.d("Naresh email ${emailController.text} password ${passwordController.text}");
                        context.read<LoginBloc>().add(SubmitLogin(email: emailController.text,password:passwordController.text ));
                      }, text: StaticText.loginText),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(StaticText.dontHaveAccount),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HospitalSignupScreen()));
                            },
                            child: Text(
                              StaticText.signUpText,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
