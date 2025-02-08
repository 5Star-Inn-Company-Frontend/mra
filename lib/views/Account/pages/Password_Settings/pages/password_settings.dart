import 'package:flutter/cupertino.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Account/pages/Password_Settings/service/update_password.dart';
import 'package:mra/views/Account/pages/Password_Settings/widgets/password_success.dart';

import '../../../../../res/import/import.dart';

class PasswordSettings extends StatefulWidget {
  const PasswordSettings({super.key});

  @override
  State<PasswordSettings> createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  late String _regErrorMsg;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  Future<void> updatePassword(BuildContext context, String current, String newPassword) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLoading == true) {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return const Loading();
            });
      }
      var response = await UpdatePasswordService().updatePin(current, newPassword);

      if (response.statusCode == 200) {
        print(response.data);
        setState(() {
          _isLoading = false;
        });
        if (_isLoading == false) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
        if (response.data['status'] == true) {
          await showCupertinoDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: const PasswordSuccess());
            },
          );
        } else if (response.data['status'] == false) {
          setState(() {
            _regErrorMsg = response.data['message'];
          });
          await Flushbar(
            message: _regErrorMsg,
            messageColor: Colors.white,
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: true,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
          ).show(context);
        }
      }
      // Do something after successful registration, like navigating to the home page
    } on DioException catch (error) {
      if (DioExceptionType.connectionTimeout == error.type ||
          DioExceptionType.receiveTimeout == error.type ||
          DioExceptionType.connectionError == error.type) {
        setState(() {
          _isLoading = false;
        });
        if (_isLoading == false) {
          Navigator.pop(context);
        }
        _regErrorMsg = "No internet connection, try again";
        Flushbar(
          message: _regErrorMsg,
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 4),
          backgroundColor: AppColors.primaryBrown,
        ).show(context);
      }
      if (error.response!.data != null) {
        print(error.response!.data);
        _regErrorMsg = error.response!.data.toString();
        setState(() {
          _isLoading = false;
        });
        if (_isLoading == false) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
        await Flushbar(
          message: _regErrorMsg,
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 6),
          backgroundColor: AppColors.primaryBrown,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PlugAppBarTwo(title: 'Change Password'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: 'Old Password',
                          color: const Color(0xff797878),
                          weight: FontWeight.w400,
                          size: 14,
                        ),
                        AppVerticalSpacing.verticalSpacingD,
                        HomeScreenCustomTextFormField(
                          obscureText: false,
                          controller: oldPasswordController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return ("Input your present password");
                            }
                            return null;
                          },
                          readonly: false,
                          textInputAction: TextInputAction.next,
                        ),
                        AppVerticalSpacing.verticalSpacingN,
                        MyText(
                          title: 'New Password',
                          color: const Color(0xff797878),
                          weight: FontWeight.w400,
                          size: 14,
                        ),
                        AppVerticalSpacing.verticalSpacingD,
                        HomeScreenCustomTextFormField(
                          obscureText: false,
                          controller: newPasswordController,
                          readonly: false,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return ("Input your new password");
                            } else if (val.length < 5) {
                              return ("Password characters must be greater than 5");
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        AppVerticalSpacing.verticalSpacingN,
                        MyText(
                          title: 'Confirm Password',
                          color: const Color(0xff797878),
                          weight: FontWeight.w400,
                          size: 14,
                        ),
                        AppVerticalSpacing.verticalSpacingD,
                        HomeScreenCustomTextFormField(
                          obscureText: false,
                          controller: confirmPasswordController,
                          validator: (val) {
                            if (newPasswordController.text !=
                                confirmPasswordController.text) {
                              return ("Password does not match");
                            }
                            return null;
                          },
                          readonly: false,
                          textInputAction: TextInputAction.done,
                        ),
                        Spacer(),
                        CustomButtonWithIconRight(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              updatePassword(
                                context,
                                oldPasswordController.text,
                                newPasswordController.text
                              );
                            }
                          },
                          title: 'Save',
                          gradient: gradient2,
                        )
                      ],
                    ),
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
