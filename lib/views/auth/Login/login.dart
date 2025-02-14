import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:mra/constant/logo.dart';
import 'package:mra/views/auth/widget/auth_tfield.dart';

import '../../../res/import/import.dart';

class LoginScreen extends StatefulWidget {
  final Function? toggleView;
  const LoginScreen({super.key, this.toggleView});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LocalAuthentication auth;
  bool _supportState = false;


  final _storage = FlutterSecureStorage();

  bool rememberMe = false;
  bool _passwordVisible = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordContoller = TextEditingController();

  void saveUserDetails() async {
    if (rememberMe == true) {
      await _storage.write(key: 'email', value: emailController.text);
      await _storage.write(key: 'password', value: passwordContoller.text);
    }
  }

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    }); 

    _passwordVisible = true;
    _storage.read(key: 'email').then((value) {
      if (value != null) {
        setState(() {
          emailController.text = value;
        });
      }
    });

    _storage.read(key: 'password').then((value) {
      if (value != null) {
        setState(() {
          passwordContoller.text = value;
        });
      }
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();
    print(availableBiometrics);
  }

  Future<bool> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Authenticate with biometrics',
         options: const AuthenticationOptions(
          biometricOnly: true, useErrorDialogs: true, stickyAuth: true
        ));
      return authenticated;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        Flushbar(
          title: "Error!!",
          message: "Fingerprint is not available",
        ).show(context);
      }
      if (e.code == auth_error.notEnrolled) {
        Flushbar(
          title: "Error!!",
          message: "Fingerprint is not enrolled",
        ).show(context);
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return ResponsiveScreen(
      mobile: Scaffold(
        backgroundColor: AppColors.secondaryBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context, MaterialPageRoute(builder: (_) => const SignUp())
                    //       );
                    //     },
                    //     child: customBbox(
                    //       width: 32,
                    //       height: 32,
                    //       shapes: BoxShape.circle,
                    //       color: plugWhite,
                    //       shadowcolor: plugLightColor.withOpacity(0.7),
                    //       widget: Center(
                    //         child: Icon(
                    //           Icons.arrow_back_ios_sharp,
                    //           color: AppColors.plugPrimaryColor,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    
                    AppHorizontalSpacing.horizontalSpacingXXL,
                    LogoWidget(),

                    Gap(10.h),
                    
                    MyText(title: 'Welcome Back', color: plugHeaderTextColor, size: 20.sp, weight: FontWeight.w700,),
                    
                    Gap(5.h),
                    MyText(title: 'Login to your Account', size: 16.sp,weight: FontWeight.w500, color: plugHeaderTextColor,),
                    
                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      hintText: 'Email',
                      obscureText:  false,
                      prefixIcon: Icon(Icons.mail_rounded, color: plugHeaderTextColor.withOpacity(0.6),),
                      suffixIcon: SizedBox.shrink(),
                      controller: emailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ("Please Enter your email");
                        }

                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)) {
                          return ("Please Enter a valid email");
                        }
                        return null;
                      },
                    ),
                    
                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      controller: passwordContoller,
                      hintText: 'Password',
                      obscureText: _passwordVisible,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: plugHeaderTextColor.withOpacity(0.6),
                      ),
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
                      validator: (val) {
                        if (val!.isEmpty || val.length < 4) {
                          return ("Password must be more than 4 characters");
                        }
                        return null;
                      },
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                value: rememberMe,
                                checkColor: AppColors.white,
                                activeColor: AppColors.plugPrimaryColor,
                                onChanged: (val) {
                                  setState(() {
                                    rememberMe = val!;
                                  });
                                }),
                          );
                        }),
                        
                        // Gap(5),

                        MyText(title: 'Remember Me', color: plugTextColor, weight: FontWeight.w400, size: 14,),
                      ],
                    ),

                    AppVerticalSpacing.verticalSpacingL,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (_supportState) {
                              bool authenticated = await _authenticate();
                              if (authenticated) {
                                if (_formKey.currentState!.validate()) {
                                  await authProvider.login(
                                    LoginRequest(email: emailController.text, password: passwordContoller.text),
                                    context
                                  );
                                  saveUserDetails();
                                }
                              }
                            } else {
                              Flushbar(
                                title: 'Error',
                                message: 'Fingerprint is not supported on this device',
                                duration: const Duration(seconds: 3),
                                icon: Icon(Icons.error, color: Colors.red,),
                                flushbarPosition: FlushbarPosition.TOP,
                              ).show(context);
                            }
                            // Navigator.pushNamed(context, Routes.setFingerPrint);
                          },
                          child: Icon(Icons.fingerprint, color: AppColors.plugPrimaryColor, size: 40.sp,),
                        ),

                        BusyButton(
                          title: "Login",
                          width: 280.w,
                          onTap: (() async {
                            if (_formKey.currentState!.validate()) {
                              await authProvider.login(
                                LoginRequest(email: emailController.text, password: passwordContoller.text),
                                context
                              );
                              saveUserDetails();
                            }
                          })
                        )
                      ],
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    MyText(
                      onTap: () async {
                        Navigator.pushNamed(context, Routes.forgetPassword);
                      },
                      title: 'Forgot Password',
                      weight: FontWeight.w600,
                      size: 14,
                      color: const Color(0xff3258A6),
                    ),
                    
                    AppVerticalSpacing.verticalSpacingS,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          title: 'Do you have an account? ',
                          weight: FontWeight.w400,
                          size: 14,
                          color: plugTextColor,
                        ),
                        MyText(
                          onTap: () => widget.toggleView!(false),
                          title: 'Sign Up now',
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
