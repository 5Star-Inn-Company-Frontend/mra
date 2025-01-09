import 'package:flutter/cupertino.dart';
import 'package:mra/views/auth/widget/auth_tfield.dart';
import '../../../res/import/import.dart';

class CreateNewPassword extends StatefulWidget {
  final String? code;
  final String? email;
  const CreateNewPassword({super.key, this.code, this.email});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool _rememberMe = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  // final bool _isDisabled = true;

  bool isLoading = false;

  String? _errorMsg;

  bool _passwordVisible = true;

  String otpCode = '';

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> _createNewPassword(String email, String otp, String password) async {
    try {
      setLoading(true);
      if (isLoading == true) {
        showCupertinoDialog(
          context: context,
          builder: (context) {return const Loading();},
        );
      }

      final response = await ApiService.dio.post(
        '/forget-password-submit',
        data: {'email': email, 'code': otp, 'password': password}
      );

      if (response.statusCode == 200) {
        setLoading(false);
        if (isLoading == false) {
          Navigator.pop(context);
        }

        if (response.data['success'] == true) {
          print(response.data);
          showDialog(
            context: context,
            builder: (context) => const CreateNewPassWordDialog(),
          );
        } 
        else if (response.data['success'] == false) {
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
      if (DioExceptionType.connectionTimeout == error.type ||
          DioExceptionType.receiveTimeout == error.type ||
          DioExceptionType.connectionError == error.type) {
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
        setLoading(false);
        if (isLoading == false) {
          Navigator.pop(context);
        }

        Flushbar(
          message: "Unable to complete request, try again",
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red
        ).show(context);
      }
    }
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: customBbox(
                        width: 32,
                        height: 32,
                        shapes: BoxShape.circle,
                        color: plugWhite,
                        shadowcolor: plugLightColor.withOpacity(0.7),
                        widget: Center(
                          child: TouchableOpacity(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back_ios_sharp,
                              color: AppColors.plugPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    const Gap(30),
                    MyText(
                      title: 'Create New Password', color: plugHeaderTextColor, size: 24, weight: FontWeight.w700,
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    MyText(
                      title: 'Please enter your register  email address to reset your password',
                      size: 16, weight: FontWeight.w500, color: plugTextColor,
                    ),
                    
                    AppVerticalSpacing.verticalSpacingN,
                    AuthTfield(
                      obscureText: _passwordVisible,
                      controller: _passwordController,
                      validator: (val) {
                        if (val!.isEmpty || val.length < 4) {
                          return ("Password must be more than 6 characters");
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.lock, color: plugHeaderTextColor.withOpacity(0.6),),
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
                      controller: _confirmPasswordController,
                      validator: (val) {
                        if (val!.isEmpty ||
                            _confirmPasswordController.text !=
                                _passwordController.text) {
                          return ("Password does not match");
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.lock, color: plugHeaderTextColor.withOpacity(0.6),),
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
                              value: _rememberMe,
                              checkColor: plugWhite,
                              activeColor: AppColors.plugPrimaryColor,
                              onChanged: (val) {
                                setState(() {
                                  _rememberMe = val!;
                                });
                              }
                            ),
                          );
                        }),

                        const SizedBox(width: 5,),
                        MyText(
                          title: 'Remember Me',
                          color: plugTextColor, weight: FontWeight.w400, size: 14,
                        ),
                      ],
                    ),

                    AppVerticalSpacing.verticalSpacingL,
                    CustomButtonWithIconRight(
                      title: 'Continue',
                      radius: BorderRadius.circular(5),
                      buttonColor: plugPrimaryColor,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _createNewPassword(
                            widget.email.toString(),
                            widget.code.toString(), 
                            _passwordController.text
                          );
                        }
                      },
                    )
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
