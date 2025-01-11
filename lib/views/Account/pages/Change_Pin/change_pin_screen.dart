import 'package:flutter/cupertino.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Account/pages/Change_Pin/service/update_pin.dart';
import 'package:mra/views/Account/pages/Change_Pin/widgets/pin_success.dart';
import '../../../../res/import/import.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({super.key});

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  late String _regErrorMsg;
  bool _isLoading = false;

  final TextEditingController _currentPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(title: 'Change Pin'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: 'Default Pin',
                          color: const Color(0xff797878),
                          weight: FontWeight.w400,
                          size: 14,
                        ),

                        AppVerticalSpacing.verticalSpacingD,
                        HomeScreenCustomTextFormField(
                          obscureText: false,
                          controller: _currentPinController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return ("Input your current pin");
                            }
                            return null;
                          },
                          readonly: false,
                          textInputAction: TextInputAction.next,
                        ),

                        AppVerticalSpacing.verticalSpacingN,
                        MyText(
                          title: 'New Pin',
                          color: const Color(0xff797878),
                          weight: FontWeight.w400,
                          size: 14,
                        ),

                        AppVerticalSpacing.verticalSpacingD,
                        HomeScreenCustomTextFormField(
                          obscureText: false,
                          controller: _newPinController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return ("Input your new pin");
                            }
                            if (val.length != 4) {
                              return ("Pin Characters must be 4");
                            }
                            return null;
                          },
                          readonly: false,
                          textInputAction: TextInputAction.next,
                        ),

                        AppVerticalSpacing.verticalSpacingN,
                        MyText(
                          title: 'Confirm Pin',
                          color: const Color(0xff797878),
                          weight: FontWeight.w400,
                          size: 14,
                        ),
                        
                        AppVerticalSpacing.verticalSpacingD,
                        HomeScreenCustomTextFormField(
                          obscureText: false,
                          controller: _confirmPasswordController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return ("Input to confirm pin");
                            }
                            if (_confirmPasswordController.text !=
                                _newPinController.text) {
                              return ("Pin does not match");
                            }
                            return null;
                          },
                          readonly: false,
                          textInputAction: TextInputAction.done,
                        ),
                        
                        Spacer(),
                        CustomButtonWithIconRight(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await updateAcccountPin(
                                context,
                                _currentPinController.text,
                                _newPinController.text
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

  Future<void> updateAcccountPin(BuildContext context, String current, String newPassword) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLoading == true) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const Loading();
          }
        );
      }
      var response = await UpdateAccountPinService().updatePin(current, newPassword);

      if (response.statusCode == 200) {
        print(response.data);
        setState(() {
          _isLoading = false;
        });
        if (_isLoading == false) {
          Navigator.pop(context);
        }
        if (response.data['status'] == true) {
          await showCupertinoDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                child: const ChangePinSuccess()
              );
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
}
