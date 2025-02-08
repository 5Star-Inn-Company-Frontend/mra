import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/views/wrapper.dart';

import '../../res/import/import.dart';

class CreateNewPassWordDialog extends StatelessWidget {
  const CreateNewPassWordDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      content: SizedBox(
        height: 450,
        width: double.maxFinite,
        child: Column(
          children: [
            Image.asset('assets/images/insurance.png', width: 200.w,),

            AppVerticalSpacing.verticalSpacingL,
            MyText(
              title: 'Congratulations!',
              weight: FontWeight.w700,
              size: 24,
              color: AppColors.plugPrimaryColor,
            ),

            AppVerticalSpacing.verticalSpacingN,
            MyText(
              title: 'You have successfully created a new password,\n click continue to go to the home page',
              weight: FontWeight.w400,
              size: 14,
              color: plugTextColor,
              align: TextAlign.center,
            ),

            AppVerticalSpacing.verticalSpacingN,
            CustomButtonWithIconRight(
              title: 'Continue',
              buttonColor: AppColors.plugPrimaryColor,
              radius: BorderRadius.circular(5),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const Wrapper()));
              },
            )
          ],
        ),
      ),
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
//
// //  Customloading(){
// //    Get.dialog(
// //        Dialog(
// //          backgroundColor: Colors.transparent,
// // shape: ShapeBorder(),
// //         child: CircularProgressIndicator(
// //           color: Zinarihelper.zeenahlightPrimary,
// //
// //         ),
// //        )
// //    );
// // }
// final spinkit = SpinKitCubeGrid(
//   color: Zinarihelper.zeenahlightPrimary,
//   size: 40.0,
// );
// showLoaderDialog(BuildContext context){
//   showDialog(barrierDismissible: true,
//     context:context,
//     builder:(BuildContext context){
//       return BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: SimpleDialog(
//             // key: key,
//
//             backgroundColor: Colors.transparent,
//             children: <Widget>[
//               Center(
//                 child: Column(children: [
//                   // CircularProgressIndicator(
//                   //   color: Zinarihelper.zeenahlightPrimary,
//                   // ),
//                   spinkit,
//                   SizedBox(height: 10,),
//                 ]),
//               )
//             ]),
//       );
//     },
//   );
// }
//
// class Dialogs {
//   static Future<SnackBar> showLoadingDialog(
//       BuildContext context, GlobalKey key) async {
//     return  SnackBar(
//
//       content: Text('data'),
//       duration: new Duration(seconds: 5000000),
//       backgroundColor: Zinarihelper.zeenahlightSecondary,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(26.0), topRight: Radius.circular(26.0)),
//       ),
//       //backgroundColor: Colors.redAccent,
//     );
//   }
// }
