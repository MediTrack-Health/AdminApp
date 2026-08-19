import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../data/models/hospital_signup_request.dart';
import '../bloc/hospital_signup_bloc.dart';
import '../bloc/hospital_signup_event.dart';
import '../bloc/hospital_signup_state.dart';

class HospitalSignupScreen extends StatefulWidget {
  const HospitalSignupScreen({super.key});

  @override
  _HospitalSignupScreenState createState() => _HospitalSignupScreenState();
}

class _HospitalSignupScreenState extends State<HospitalSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _hospitalNameController = TextEditingController();
  final _hospitalTypeIdController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _contactPersonNameController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _yearEstablishedController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hospital Signup')),
      body: BlocConsumer<HospitalSignupBloc, HospitalSignupState>(
        listener: (context, state) {
          if (state is HospitalSignupSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
          } else if (state is HospitalSignupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is HospitalSignupLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextField(
                    hintText: 'Hospital Name',
                    controller: _hospitalNameController
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    hintText: 'Address',
                    controller: _addressController,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _mobileNumberController,
                    hintText: 'Mobile Number',
                    maxLength: 10,
                    isNumber: true,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _contactPersonNameController,
                    hintText: 'Contact Person Name',
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    isOptional: true,
                    controller: _registrationNumberController,
                    hintText: 'Registration Number',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _yearEstablishedController,
                    isNumber: true,
                    hintText: 'Year Established',
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    isObscureText: true,
                    maxLines: 1,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final request = HospitalSignupRequest(
                          hospitalName: _hospitalNameController.text,
                          hospitalTypeId: 1,
                          address: _addressController.text,
                          email: _emailController.text,
                          mobileNumber: _mobileNumberController.text,
                          contactPersonName: _contactPersonNameController.text,
                          registrationNumber: _registrationNumberController.text,
                          yearEstablished: _yearEstablishedController.text,
                          password: _passwordController.text,
                        );

                        context.read<HospitalSignupBloc>().add(SubmitHospitalSignup(request));
                      }
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}