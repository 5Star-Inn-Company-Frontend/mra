import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import '../../../../res/import/import.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context, listen: true);
    final userData = userProvider.userData;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(title: "Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.center,
              //   child: CircleAvatar(
              //     radius: 30,
              //     backgroundImage:
              //         NetworkImage(userData?.profilePhotoUrl ?? ''),
              //   ),
              // ),

              AppVerticalSpacing.verticalSpacingL,
              MyText(
                title: 'First Name',
                color: const Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              _buildProfileItem(userData?.firstname ?? ''),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Last Name',
                color: const Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              _buildProfileItem(userData?.lastname ?? ''),
              
              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Phone Number',
                color: const Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              _buildProfileItem(userData?.phone ?? ''),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Email Address',
                color: const Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              _buildProfileItem(userData?.email ?? ''),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Date of birth',
                color: const Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              _buildProfileItem(userData?.dob ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.plugPrimaryColor, width: 1),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(color: Colors.black54, fontSize: 11.sp),
      ),
    );
  }
}
