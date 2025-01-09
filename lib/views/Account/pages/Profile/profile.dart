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
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 30,
                  // backgroundImage:
                  //     NetworkImage(userData?.profilePhotoUrl ?? ''),
                ),
              ),
              AppVerticalSpacing.verticalSpacingL,
              MyText(
                title: 'First Name',
                color: const Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                hintText: userData?.firstname,
                readonly: false,
                textInputAction: TextInputAction.next,
              ),
              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Last Name',
                color: const Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                hintText: userData?.lastname,
                readonly: false,
                textInputAction: TextInputAction.next,
              ),
              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Phone Number',
                color: const Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                readonly: false,
                hintText: userData?.phone ?? '',
                textInputAction: TextInputAction.done,
              ),
              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Email Address',
                color: const Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              HomeScreenCustomTextFormField(
                obscureText: false,
                hintText: userData?.email ?? '',
                readonly: false,
                textInputAction: TextInputAction.done,
              ),
              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Date of birth',
                color: const Color(0xff797878),
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
            ],
          ),
        ),
      ),
    );
  }
}
