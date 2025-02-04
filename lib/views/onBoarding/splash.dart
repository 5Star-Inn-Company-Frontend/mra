// import 'package:another_flushbar/flushbar.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mra/constant/logo.dart';
import 'package:mra/views/wrapper.dart';
// import 'package:mra/views/wrapper.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import '../../res/import/import.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Wrapper()
          // MaterialPageRoute(builder: (context) => OnBoardingScreen()
        )
      )
    );
  }

  // Future<void> timer() async {
  //   bool isConnected = await InternetConnectionChecker.createInstance().hasConnection;
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final int? isviewed = prefs.getInt('onBoard');
  //   if (isConnected) {
  //     Timer.periodic(const Duration(milliseconds: 500), (timer) {
  //       setState(() {
  //         _progressValue = _progressValue + 0.1;
  //         if (_progressValue >= 1) {
  //           _progressValue = 1;
  //           timer.cancel();
  //           isviewed != 0
  //               ? Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => const OnBoardingScreen()))
  //               : Navigator.pushReplacement(context,
  //                   MaterialPageRoute(builder: (context) => const Wrapper()));
  //         }
  //       });
  //     });
  //   } else {
  //     Flushbar(
  //       title: "Error!",
  //       message: "No network connection",
  //       isDismissible: true,
  //       flushbarPosition: FlushbarPosition.TOP,
  //     ).show(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      mobile: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LogoWidget(),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: MyText(
                    title: "We offer you the most affordable and most cheapest data, airtime, Dstv, Gotv and Startimes subscription in\nseconds anywhere and anytime",
                    size: 18,
                    color: AppColors.plugPrimaryColor,
                    align: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                // Stack(
                //   clipBehavior: Clip.none,
                //   children: [
                //     LinearProgressIndicator(
                //       minHeight: 10,
                //       backgroundColor: const Color(0xffE5E5E5),
                //       valueColor: const AlwaysStoppedAnimation<Color>(
                //         plugAppBarLightColor,
                //       ),
                //       value: _progressValue,
                //     ),
                //     Positioned(
                //       left: _progressValue * 370,
                //       bottom: -5,
                //       child: Container(
                //         height: 24,
                //         width: 24,
                //         decoration: const BoxDecoration(
                //           shape: BoxShape.circle,
                //           gradient: LinearGradient(
                //             colors: [
                //               plugPrimaryColor,
                //               plugAppBarLightColor,
                //             ],
                //           ),
                //         ),
                //         child: Center(
                //           child: Text(
                //             "${(_progressValue * 100).round()}%",
                //             style: const TextStyle(
                //               color: Colors.white,
                //               fontSize: 8,
                //             ),
                //             textAlign: TextAlign.center,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
