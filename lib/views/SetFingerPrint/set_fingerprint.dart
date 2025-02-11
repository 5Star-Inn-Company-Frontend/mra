import '../../res/import/import.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class SetFingerPrint extends StatefulWidget {
  const SetFingerPrint({super.key});

  @override
  State<SetFingerPrint> createState() => _SetFingerPrintState();
}

class _SetFingerPrintState extends State<SetFingerPrint> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  bool _isBiometricAvailable = false;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  Future<void> _checkBiometricAvailability() async {
    try {
      _isBiometricAvailable = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _authenticate() async {
    try {
      _isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Authenticate with biometrics',
        options: const AuthenticationOptions(
          biometricOnly: true, useErrorDialogs: true, stickyAuth: true
        )
      );
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
    }
    setState(() {
      _isAuthenticated = true;
    });
  }

  // final LocalAuthentication auth = LocalAuthentication();
  // bool _isAuthenticated = false;

  // Future<void> _authenticate() async {
  //   try {
  //     bool isAuthenticated = await auth.authenticate(
  //       localizedReason: 'Scan your fingerprint to login',
  //       options: const AuthenticationOptions(
  //         biometricOnly: true,
  //         useErrorDialogs: true,
  //         stickyAuth: true,
  //       ),
  //     );

  //     if (isAuthenticated) {
  //       setState(() {
  //         _isAuthenticated = true;
  //       });
  //     }
  //   } catch (e) {
  //     print("Authentication Error: $e");
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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

                  AppVerticalSpacing.verticalSpacingL,
                  MyText(
                    title: _isAuthenticated ? "Fingerprint has been set!" : 'Set Your Finger Print',
                    color: plugHeaderTextColor, size: 24, weight: FontWeight.w700,
                  ),

                  AppVerticalSpacing.verticalSpacingN,
                  MyText(
                    title: 'Add a fingerprint to make your account more secure.',
                    size: 16, weight: FontWeight.w500, color: plugTextColor, align: TextAlign.center,
                  ),

                  AppVerticalSpacing.verticalSpacingXS,
                  _isAuthenticated 
                  ? Icon(Icons.check_circle,
                    size: screenHeight(context) * 0.3,
                    color: Colors.green
                  )
                  : IconButton(
                    icon: const Icon(Icons.fingerprint),
                    iconSize: screenHeight(context) * 0.3,
                    color: AppColors.plugPrimaryColor,
                    onPressed: _authenticate,
                  ),

                  AppVerticalSpacing.verticalSpacingXL,
                  MyText(
                    title: _isAuthenticated
                      ? "Authenticated!"
                      : 'Please place your hand on the fingerprint scanner to get started',
                    size: 16,
                    weight: FontWeight.w500,
                    color: plugTextColor,
                    align: TextAlign.center,
                  ),

                  AppVerticalSpacing.verticalSpacingXXS,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomButtonWithIconRight(
                          title: 'Skip',
                          textColor: AppColors.plugPrimaryColor,
                          radius: BorderRadius.circular(5),
                          borderColor: AppColors.plugPrimaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),

                      AppHorizontalSpacing.horizontalSpacingB,
                      Expanded(
                        child: CustomButtonWithIconRight(
                          title: 'Continue',
                          radius: BorderRadius.circular(5),
                          buttonColor: AppColors.plugPrimaryColor,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.wrapper);
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  AppVerticalSpacing.verticalSpacingL,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
