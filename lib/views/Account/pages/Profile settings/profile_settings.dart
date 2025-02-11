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
                title: 'Email Address',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                readonly: false,
                hintText: userData?.email,
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
              
              Gap(100.h),
              CustomButtonWithIconRight(
                onPressed: () {
                  showDialog(
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
                  ));
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
}
