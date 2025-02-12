import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import '../../../../res/import/import.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context, listen: true);
    final userData = userProvider.userData;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(title: "Profile Settings"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //     alignment: Alignment.center,
              //     child: CircleAvatar(
              //       radius: 30,
              //       // backgroundImage:
              //       //     NetworkImage(userData?.profilePhotoUrl ?? ''),
              //     )),
              // Gap(40.h),
              MyText(
                title: 'First Name',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                readonly: false,
                hintText: userData?.firstname,
                textInputAction: TextInputAction.next,
              ),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Last Name',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                readonly: false,
                hintText: userData?.lastname,
                textInputAction: TextInputAction.next,
              ),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Address',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                hintText: userData?.address,
                readonly: false,
                textInputAction: TextInputAction.done,
              ),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Phone Number',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                readonly: false,
                hintText: userData?.phone,
                textInputAction: TextInputAction.done,
              ),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Date of birth',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                hintText: userData?.dob,
                readonly: false,
                textInputAction: TextInputAction.done,
              ),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'BVN',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                readonly: false,
                hintText: userData?.bvn,
                textInputAction: TextInputAction.done,
              ),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Date of birth',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                hintText: userData?.dob,
                readonly: false,
                textInputAction: TextInputAction.done,
              ),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Gender',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                hintText: userData?.gender,
                readonly: false,
                textInputAction: TextInputAction.done,
              ),
              
              Gap(70.h),
              CustomButtonWithIconRight(
                onPressed: () async {
                  final updatedFirstname = userData?.firstname ?? '';
                  final updatedLastname = userData?.lastname ?? '';
                  final updatedAddress = userData?.address ?? '';
                  final updatedPhone = userData?.phone ?? '';
                  final updatedBvn = userData?.bvn ?? '';
                  final updatedDob = userData?.dob ?? '';
                  final updatedGender = userData?.gender ?? '';

                  await updateProfileSettings(
                    context,
                    updatedFirstname,
                    updatedLastname,
                    updatedAddress,
                    updatedPhone,
                    updatedBvn,
                    updatedDob,
                    updatedGender,
                  );
                },
                title: 'Save',
                gradient: gradient2,
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> updateProfileSettings(BuildContext context, String firstname, String lastname, String address, String phone, String bvn, String dob, String gender) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    final data = {
      "firstname": firstname,
      "lastname": lastname,
      "address": address,
      "phone": phone,
      "bvn": bvn,
      "dob": dob,
      "gender": gender
    };

    try {
      final response = await Dio().post(
        '/profile-update',
        data: json.encode(data),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == true) {
          // Handle success
          successDialog(context);

          Flushbar(
            message: responseData['message'],
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: true,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
          ).show(context);
        } else {
          // Handle failure
          Flushbar(
            message: responseData['message'],
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: true,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
          ).show(context);
        }
      }
    } on DioException catch (e) {
      // Handle Dio errors
      String errorMessage = "An error occurred. Please try again.";
      if (e.type == DioExceptionType.badResponse) {
        errorMessage = "Unable to update profile, try again.";
      } 
      else if (e.type == DioExceptionType.connectionError ||
                e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.receiveTimeout ||
                e.type == DioExceptionType.sendTimeout) {
        errorMessage = "Poor Internet connection, try again.";
      }
      Flushbar(
        message: errorMessage,
        flushbarStyle: FlushbarStyle.GROUNDED,
        isDismissible: true,
        flushbarPosition: FlushbarPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ).show(context);
    }
  }


  Future<dynamic> successDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        insetPadding: EdgeInsets.zero,
        content: Container(
          clipBehavior: Clip.hardEdge,
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/Group2.png',),
                ],
              ),
              
              Gap(30.h),
              MyText(
                title: 'Congratulations, your profile\n has been updated Successfully ',
                weight: FontWeight.w500,
                color: plugTextColor,
                size: 17.sp,
                align: TextAlign.center,
              ),

              Gap(20.h),
              BusyButton(
                onTap: () {
                  Navigator.pop(context);
                },
                title: 'OK',
                color: AppColors.plugPrimaryColor,
                textColor: Colors.white,
                width: 100.w,
                height: 35.h,
                borderRadius: BorderRadius.circular(20),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Image.asset('assets/images/Group1.png',),
              //   ],
              // )
            ]
          ),
          // child: Stack(
          //   children: [
          //     Positioned(
          //       top: 0,
          //       right: 0,
          //       child: Image.asset('assets/images/Group2.png',),
          //     ),
          //     Positioned(
          //       bottom: 0,
          //       left: 0,
          //       child: Image.asset('assets/images/Group1.png',),
          //     ),
          //     Positioned(
          //       bottom: 40,
          //       left: 40,
          //       child: Image.asset('assets/images/insurance.png', width: 100.w),
          //     ),
          //     Positioned(
          //       bottom: 20,
          //       left: 40,
          //       child: MyText(
          //         title: 'Congratulations, your profile\n has been updated Successfully ',
          //         weight: FontWeight.w500,
          //         color: plugTextColor,
          //         size: 17.sp,
          //         align: TextAlign.center,
          //       ),
          //     ),
          //   ],
          // ),
        ),
      )
    );
  }
}
