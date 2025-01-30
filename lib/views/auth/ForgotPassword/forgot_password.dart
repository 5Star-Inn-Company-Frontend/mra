import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../res/import/import.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isDisabled = true;

  bool isLoading = false;

  String? _errorMsg;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> resetPassword(String email) async {
    try {
      setLoading(true);
      if (isLoading == true) {
        showCupertinoDialog(
          context: context,
          builder: (context) {return const Loading();},
        );
      }

      final response = await ApiService.dio.post(
        '/reset-password-request-app',
        data: {'email': email}
      );

      if (response.statusCode == 200) {
        setLoading(false);
        if (isLoading == false) {
          Navigator.pop(context);
        }

        if (response.data['status'] == true) {
          print(response.data);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => VerifyOtp(email: _emailController.text, ))
          );
        } else if (response.data['status'] == false) {
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
                backgroundColor: Colors.red)
            .show(context);
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
                backgroundColor: Colors.red)
            .show(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _isDisabled = true;
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: customBbox(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      width: 32,
                      height: 32,
                      shapes: BoxShape.circle,
                      color: plugWhite,
                      shadowcolor: plugLightColor.withOpacity(0.7),
                      widget: Center(
                        child: Icon(Icons.arrow_back_ios_sharp, color: AppColors.plugPrimaryColor,),
                      ),
                    ),
                  ),

                  AppHorizontalSpacing.horizontalSpacingXXL,
                  MyText(
                    title: 'Forgot Password',
                    color: plugHeaderTextColor, size: 24, weight: FontWeight.w700,
                  ),

                  AppVerticalSpacing.verticalSpacingN,
                  MyText(
                    title: 'Please enter your registered email address to reset your password',
                    size: 16, weight: FontWeight.w500, color: plugHeaderTextColor, align: TextAlign.center,
                  ),

                  AppVerticalSpacing.verticalSpacingXL,
                  // email text field
                  Form(
                    key: _formKey,
                    child: TextFormField(
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
                      onChanged: (val) {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isDisabled = false;
                          });
                        } else {
                          setState(() {
                            _isDisabled = true;
                          });
                        }
                      },
                      controller: _emailController,
                      cursorColor: plugHeaderTextColor.withOpacity(0.6),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14.sp, color: plugHeaderTextColor.withOpacity(0.6),),
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail_rounded, color: plugHeaderTextColor.withOpacity(0.6),),
                        hintText: 'Email Address',
                        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14.sp,color: plugHeaderTextColor.withOpacity(0.6),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: AppColors.plugPrimaryColor.withOpacity(0.4), width: 2,),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: plugHeaderTextColor.withOpacity(0.6), width: 2,),
                        ),
                      ),
                    )
                  ),

                  AppVerticalSpacing.verticalSpacingXXL,
                  BusyButton(
                    title: "Continue",
                    disabled: _isDisabled,
                    onTap: () {
                      resetPassword(_emailController.text.trim());
                    },
                  ),
                  
                  AppVerticalSpacing.verticalSpacingN,
                  MyText(
                    onTap: () {},
                    title: 'Otp will be sent to your email address ', weight: FontWeight.w400, size: 14, color: plugTextColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
