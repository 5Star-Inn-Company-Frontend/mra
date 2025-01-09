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
                  )),
              AppVerticalSpacing.verticalSpacingL,
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
              AppVerticalSpacing.verticalSpacingXXXL,
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
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 215,
                                    left: 267,
                                    child: Image.asset(
                                      'assets/images/Group2.png',
                                    ),
                                  ),
                                  Positioned(
                                    top: 108,
                                    child: Image.asset(
                                      'assets/images/Group1.png',
                                    ),
                                  ),
                                  Positioned(
                                    top: 200,
                                    left: 40,
                                    child: MyText(
                                      title:
                                          'Congratulations your profile\n has been updated Successfully ',
                                      weight: FontWeight.w500,
                                      color: plugTextColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
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
