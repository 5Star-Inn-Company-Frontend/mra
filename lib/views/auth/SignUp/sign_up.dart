import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/constant/logo.dart';
import 'package:mra/views/auth/SignUp/Model/model.dart';
import 'package:mra/views/auth/widget/auth_tfield.dart';
import '../../../res/import/import.dart';

// ignore_for_file: use_build_context_synchronously
class SignUp extends StatefulWidget {
  final Function? toggleView;
  const SignUp({super.key, this.toggleView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _termsandconditions = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = true;

  bool isLoading = false;

  String? _errorMsg;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<UserModel> signup(UserModel user) async {
    // UserModel user = UserModel(
    //   firstName: firstNameController.text.trim(),
    //   lastName: lastNameController.text.trim(),
    //   gender: genderController.text.trim(),
    //   dob: dobController.text.trim(),
    //   email: emailController.text.trim(),
    //   password: passwordController.text,
    //   phone: phoneController.text.trim(),
    //   address: addressController.text.trim(),
    // );

    try {
      setLoading(true);
      if (isLoading == true) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const Loading();
          },
        );
      }

      final response = await ApiService.dio.post(
        '/register',
        data: json.encode(
          {
            'firstname': firstNameController.text.trim(),
            'lastname': lastNameController.text.trim(),
            'gender': genderController.text.trim(),
            'dob': dobController.text.trim(),
            'email': emailController.text.trim(),
            'password': passwordController.text,
            'phone': phoneController.text.trim(),
            'address': addressController.text.trim(),
          }
        )
      );

      // debugging  
      // print("debugging: ${json.encode(user.toJson())}");

      final Map<String, dynamic> payload = user.toJson();
      print("Payload being sent to server: $payload");

      print("message: ${response.data}");
      
      if (response.statusCode == 200) {
        setLoading(false);
        if (isLoading == false) {
          Navigator.pop(context);
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  height: screenHeight(context) * 0.38,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/images/tick-card.png",
                        width: screenWidth(context) * 0.2,
                        height: screenHeight(context) * 0.1,
                      ),
                      AppVerticalSpacing.verticalSpacingN,
                      Text(
                        // "Welcome! ${response.data['firstname'].toString().toUpperCase()}",
                        "Welcome! ${firstNameController.text.trim().toUpperCase()}",
                        style: TextStyle(color: AppColors.plugPrimaryColor, fontSize: 16.sp, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "You have successfully Registered!",
                        style: TextStyle(
                          color: AppColors.plugTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      ),
                      AppVerticalSpacing.verticalSpacingN,
                      const SizedBox(
                        height: 10,
                      ),
                      BusyButton(
                        title: "Continue to Login",
                        color: AppColors.plugPrimaryColor,
                        onTap: () async {
                          Navigator.pop(context);
                          await widget.toggleView!(true);
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (response.data['success'] == true) {
          print(response.data);
          // showCupertinoDialog(
          //   context: context,
          //   builder: (context) {
          //     return Dialog(
          //       child: Container(
          //         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //         height: screenHeight(context) * 0.38,
          //         decoration: BoxDecoration(
          //             color: AppColors.white,
          //             borderRadius: BorderRadius.circular(10)
          //         ),
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             Image.asset(
          //               "assets/images/tick-card.png",
          //               width: screenWidth(context) * 0.2,
          //               height: screenHeight(context) * 0.1,
          //             ),
          //             AppVerticalSpacing.verticalSpacingN,
          //             Text(
          //               "Welcome! ${response.data['data']['firstname'].toString().toUpperCase()}",
          //               style: const TextStyle(
          //                   color: AppColors.plugPrimaryColor,
          //                   fontSize: 20,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //             const SizedBox(
          //               height: 15,
          //             ),
          //             const Text(
          //               "You have successfully Registered!",
          //               style: TextStyle(
          //                   color: AppColors.plugTextColor,
          //                   fontSize: 14,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //             AppVerticalSpacing.verticalSpacingN,
          //             const SizedBox(
          //               height: 10,
          //             ),
          //             BusyButton(
          //               title: "Continue to Login",
          //               color: AppColors.plugPrimaryColor,
          //               onTap: () async {
          //                 Navigator.pop(context);
          //                 await widget.toggleView!(true);
          //               },
          //             )
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );
        } else if (response.data['success'] == false) {
          print(response.data);

          Flushbar(
            message: response.data['message'],
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: true,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.plugPrimaryColor,
          ).show(context);
        }
      }
    } on DioException catch (error) {
      if (DioExceptionType.connectionTimeout == error.type || DioExceptionType.receiveTimeout == error.type || DioExceptionType.connectionError == error.type) {
        setLoading(false);
        if (isLoading == false) {
          Navigator.pop(context);
        }
        
        _errorMsg = "No internet connection, try again";
        Flushbar(
          message: _errorMsg,
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red
        ).show(context);
      }
      if (error.response != null) {
        print("Error response data: ${error.response!.data}");
        print("Error response status: ${error.response!.statusCode}");
        setLoading(false);
        if (isLoading == false) {
          Navigator.pop(context);
        }

        Flushbar(
          message: "Unable to complete registration, ${error.response!.data}",
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red
        ).show(context);
      }
    }
    return UserModel(
      firstName: "",
      lastName: "",
      phone: "",
      email: "",
      password: "",
      address: '',
      gender: '',
      dob: ''
    );
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      mobile: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customBbox(
                          width: 32,
                          height: 32,
                          shapes: BoxShape.circle,
                          color: plugWhite,
                          onPressed: () {
                            widget.toggleView!(true);
                          },
                          shadowcolor: plugLightColor.withOpacity(0.7),
                          widget: Center(
                            child: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: AppColors.plugPrimaryColor,
                            ),
                          ),
                        ),
                        AppHorizontalSpacing.horizontalSpacingXXL,
                        LogoWidget()
                      ],
                    ),
                    
                    MyText(
                      title: 'Hello!',
                      color: plugHeaderTextColor,
                      size: 20.sp,
                      weight: FontWeight.w700,
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    MyText(
                      title: 'Create Your Account',
                      size: 16.sp,
                      weight: FontWeight.w500,
                      color: plugHeaderTextColor,
                    ),
                    
                    AppVerticalSpacing.verticalSpacingE,
                    AuthTfield(
                      obscureText: false,
                      controller: firstNameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ("Input your first name");
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        Icons.person,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
                      suffixIcon: SizedBox.shrink(),
                      hintText: 'First Name',
                    ),
                    
                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      obscureText: false,
                      controller: lastNameController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ("Input your Last name");
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        Icons.person,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
                      suffixIcon: SizedBox.shrink(),
                      hintText: 'Last Name',
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      obscureText: false,
                      controller: phoneController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ("Input your Phone number");
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        Icons.phone,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
                      suffixIcon: SizedBox.shrink(),
                      hintText: 'Phone Number',
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      obscureText: false,
                      controller: addressController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ("Input your Address");
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        Icons.contact_mail,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
                      suffixIcon: SizedBox.shrink(),
                      hintText: 'Address',
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      controller: emailController,
                      obscureText: false,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ("Please Enter your email");
                        }

                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(val)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        Icons.mail_rounded,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
                      hintText: 'Email',
                      suffixIcon: SizedBox.shrink(),
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      obscureText: false,
                      controller: genderController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your gender";
                        }
                        return null;
                      },
                      hintText: 'Gender',
                      prefixIcon: Icon(
                        Icons.person,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
                      suffixIcon: SizedBox.shrink(),
                    ),
                    
                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      obscureText: false,
                      controller: dobController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your date of birth";
                        }
                        return null;
                      },
                      hintText: 'DOB, YYYY-MM-DD',
                      prefixIcon: Icon(
                        Icons.calendar_today,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
                      suffixIcon: SizedBox.shrink(),
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      obscureText: _passwordVisible,
                      controller: passwordController,
                      validator: (val) {
                        if (val!.isEmpty || val.length < 4) {
                          return ("Password must be more than 6 characters");
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        Icons.lock,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
                      hintText: 'Password',
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        child: Icon(
                          _passwordVisible ? Icons.visibility_off_sharp : Icons.visibility_sharp,
                          color: plugHeaderTextColor.withOpacity(0.6),
                        ),
                      ),
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      obscureText: _passwordVisible,
                      controller: confirmPasswordController,
                      validator: (val) {
                        if (val!.isEmpty ||
                            confirmPasswordController.text !=
                                passwordController.text) {
                          return ("Password does'nt match");
                        }
                        return null;
                      },
                      prefixIcon: Icon(
                        Icons.lock,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
                      hintText: 'Confirm Password',
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        child: Icon(
                          _passwordVisible ? Icons.visibility_off_sharp : Icons.visibility_sharp,
                          color: plugHeaderTextColor.withOpacity(0.6),
                        ),
                      ),
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        StatefulBuilder(builder: (context, setState) {
                          return Theme(
                            data: ThemeData(
                              unselectedWidgetColor: plugTextColor,
                            ),
                            child: Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              value: _termsandconditions,
                              checkColor: AppColors.white,
                              activeColor: AppColors.plugPrimaryColor,
                              onChanged: (val) {
                                setState(() {
                                  _termsandconditions = val!;
                                });
                                print(_termsandconditions);
                              }
                            ),
                          );
                        }),

                        MyText(
                          title: 'Accept  Terms of Use & Privacy Policy',
                          color: plugTextColor,
                          weight: FontWeight.w400,
                          size: 14,
                        ),
                      ],
                    ),

                    AppVerticalSpacing.verticalSpacingB,
                    MyText(
                      title:
                          'By registering, you accept our Terms & Conditions\n and Privacy Policy. Your data will be security\n encrypted with Option VTU',
                      size: 14,
                      weight: FontWeight.w400,
                      color: plugTextColor,
                      align: TextAlign.center,
                    ),

                    AppVerticalSpacing.verticalSpacingE,
                    CustomButtonWithIconRight(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_termsandconditions == false) {
                            Flushbar(
                              message: "Accept Terms and condition to proceed",
                              duration: const Duration(seconds: 2),
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.GROUNDED,
                            ).show(context);
                          } 
                          else {
                            UserModel user = UserModel(
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              gender: genderController.text.trim(),
                              dob: dobController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text,
                              phone: phoneController.text.trim(),
                              address: addressController.text.trim(),
                            );

                            await signup(user);
                          }
                        }
                      },
                      title: 'Sign Up',
                      buttonColor: AppColors.plugPrimaryColor,
                      radius: BorderRadius.circular(5),
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(title: 'Do you have an account? ', weight: FontWeight.w400, size: 14,color: plugTextColor,),
                        
                        MyText(
                          onTap: () async {
                            await widget.toggleView!(true);
                          },
                          title: 'Sign In now',
                          weight: FontWeight.w600,
                          size: 14,
                          color: const Color(0xff3258A6),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
