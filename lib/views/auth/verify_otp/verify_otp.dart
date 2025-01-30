// import 'package:flutter/cupertino.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import '../../../res/import/import.dart';

class VerifyOtp extends StatefulWidget {
  final String? email;
  const VerifyOtp({super.key, this.email});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  // final _formKey = GlobalKey<FormState>();
  // final TextEditingController _emailController = TextEditingController();
  // bool _isDisabled = true;

  bool isLoading = false;

  // String? _errorMsg;

  String otpCode = '';

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  // Future<void> _verifyOtp(String email, String otp) async {
  //   try {
  //     setLoading(true);
  //     if (isLoading == true) {
  //       showCupertinoDialog(
  //         context: context,
  //         builder: (context) {
  //           return const Loading();
  //         },
  //       );
  //     }
  //     final response = await ApiService.dio.post(
  //       '/reset-password-otp',
  //       data: {'email': email, 'code': otp}
  //     );

  //     if (response.statusCode == 200) {
  //       setLoading(false);
  //       if (isLoading == false) {
  //         Navigator.pop(context);
  //       }

  //       if (response.data['success'] == true) {
  //         print(response.data);
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => CreateNewPassword(email: widget.email, code: otpCode)
  //           )
  //         );
  //       } 
  //       else if (response.data['success'] == false) {
  //         print(response.data);

  //         Flushbar(
  //           message: response.data['message'],
  //           flushbarStyle: FlushbarStyle.GROUNDED,
  //           isDismissible: true,
  //           flushbarPosition: FlushbarPosition.TOP,
  //           duration: const Duration(seconds: 2),
  //           backgroundColor: AppColors.plugPrimaryColor,
  //         ).show(context);
  //       }
  //     }
  //   } on DioException catch (error) {
  //     if (DioExceptionType.connectionTimeout == error.type ||
  //         DioExceptionType.receiveTimeout == error.type ||
  //         DioExceptionType.connectionError == error.type) {
  //       setLoading(false);
  //       if (isLoading == false) {
  //         Navigator.pop(context);
  //       }
  //       _errorMsg = "No internet connection, try again";
  //       Flushbar(
  //         message: _errorMsg,
  //         flushbarStyle: FlushbarStyle.GROUNDED,
  //         isDismissible: true,
  //         flushbarPosition: FlushbarPosition.TOP,
  //         duration: const Duration(seconds: 4),
  //         backgroundColor: Colors.red
  //       ).show(context);
  //     }

  //     if (error.response != null) {
  //       setLoading(false);
  //       if (isLoading == false) {
  //         Navigator.pop(context);
  //       }

  //       Flushbar(
  //         message: "Unable to complete request, try again",
  //         flushbarStyle: FlushbarStyle.GROUNDED,
  //         isDismissible: true,
  //         flushbarPosition: FlushbarPosition.TOP,
  //         duration: const Duration(seconds: 4),
  //         backgroundColor: Colors.red
  //       ).show(context);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      mobile: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
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
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_sharp, color: AppColors.plugPrimaryColor,),
                        ),
                      ),
                    ),
                  ),
                  
                  AppHorizontalSpacing.horizontalSpacingXXL,
                  MyText(
                    title: 'Verify Otp',
                    color: plugHeaderTextColor, size: 24, weight: FontWeight.w700,
                  ),

                  AppVerticalSpacing.verticalSpacingN,
                  MyText(
                    title: 'Provide the Otp as been sent to your email ${widget.email}',
                    size: 16, weight: FontWeight.w500, color: plugTextColor, align: TextAlign.center,
                  ),

                  AppVerticalSpacing.verticalSpacingXL,
                  PinCodeFields(
                    length: 5,
                    fieldBorderStyle: FieldBorderStyle.square,
                    // responsive: false,
                    fieldHeight: 50.0,
                    fieldWidth: 40.0,
                    borderWidth: 1.0,
                    activeBorderColor: AppColors.plugPrimaryColor,
                    activeBackgroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    keyboardType: TextInputType.number,
                    autoHideKeyboard: false,
                    fieldBackgroundColor: const Color(0xffF6F4F4),
                    borderColor: const Color(0xff0B1426).withOpacity(0.1),
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    onComplete: (value) {
                      print(value);
                      setState(() {
                        otpCode = value;
                      });
                    },
                  ),

                  AppVerticalSpacing.verticalSpacingXXL,
                  BusyButton(
                    title: "Continue",
                    disabled: otpCode.length < 5 ? true : false,
                    onTap: () async {
                      // await _verifyOtp(
                      //   widget.email.toString(), otpCode.toString()
                      // );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CreateNewPassword(email: widget.email, code: otpCode)
                        )
                      );
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
