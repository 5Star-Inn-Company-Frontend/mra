import 'package:mra/utils/widget/appbar_two.dart';

import '../../../../res/import/import.dart';

class Referrals extends StatelessWidget {
  const Referrals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PlugAppBarTwo(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                title: 'Referral Link',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              customBbox(
                borderColor: AppColors.plugPrimaryColor,
                radius: BorderRadius.circular(8),
                widget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: HomeScreenCustomTextFormField(
                          obscureText: false,
                          readonly: false,
                          textInputAction: TextInputAction.next,
                          color: Colors.transparent,
                        ),
                      ),
                      customBbox(
                        width: 52,
                        height: 24,
                        radius: BorderRadius.circular(24),
                        widget: Center(
                          child: MyText(
                            title: 'Share',
                            weight: FontWeight.w400,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                        gradient: gradient2,
                      )
                    ],
                  ),
                ),
              ),
              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Referral Code',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),
              AppVerticalSpacing.verticalSpacingD,
              customBbox(
                borderColor: AppColors.plugPrimaryColor,
                radius: BorderRadius.circular(8),
                widget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: HomeScreenCustomTextFormField(
                          obscureText: false,
                          readonly: false,
                          textInputAction: TextInputAction.next,
                          color: Colors.transparent,
                        ),
                      ),
                      customBbox(
                        width: 52,
                        height: 24,
                        radius: BorderRadius.circular(24),
                        widget: Center(
                          child: MyText(
                            title: 'Share',
                            weight: FontWeight.w400,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                        gradient: gradient2,
                      )
                    ],
                  ),
                ),
              ),
              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Referral List',
                color: plugTetTextColor,
                weight: FontWeight.w600,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
