import 'package:mra/res/import/import.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Transfer/constants/textField.dart';

class TransactionStateMent extends StatelessWidget {
  const TransactionStateMent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PlugAppBarTwo(title: "Trasaction Statement"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.red,
                    child: Image.asset("assets/images/notebook.png"),
                  ),
                ),
                const Gap(10),
                TextBold(
                  "Transaction statement",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                const Gap(5),
                TextSemiBold(
                  "This would be sent to your email for personal use",
                  textAlign: TextAlign.center,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                const Gap(12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H1(
                      "Duration",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      width: 70,
                      height: 28,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            hintText: 'From',
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.plugTextColor))),
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 28,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'To',
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.plugTextColor))),
                      ),
                    )
                  ],
                ),
                Gap(screenHeight(context) * 0.008),
                const Divider(
                  color: AppColors.plugTextColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H1(
                      "From",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    TextSemiBold(
                      "05-09-2022",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
                Gap(screenHeight(context) * 0.008),
                const Divider(
                  color: AppColors.plugTextColor,
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H1(
                      "To",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    TextSemiBold(
                      "05-09-2022",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
                Gap(screenHeight(context) * 0.008),
                const Divider(
                  color: AppColors.plugTextColor,
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    H1(
                      "email Address",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    TextSemiBold(
                      "odeji@gmail.com",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )
                  ],
                ),
                Gap(screenHeight(context) * 0.008),
                const Divider(
                  color: AppColors.plugTextColor,
                ),
                const Gap(8)
              ],
            ),
            AppVerticalSpacing.verticalSpacingXS,
            CustomButtonWithIconRight(
              onPressed: () async {},
              title: 'Download',
              gradient: gradient2,
            )
          ],
        ),
      ),
    );
  }
}
