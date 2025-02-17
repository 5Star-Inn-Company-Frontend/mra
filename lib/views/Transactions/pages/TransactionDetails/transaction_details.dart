import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Transactions/model/transaction_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:saf/saf.dart';
import 'dart:io';
// import 'dart:ui' as ui;
// import 'package:path_provider/path_provider.dart';
import '../../../../res/import/import.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails(
    {
      super.key,
      this.transactions,
      this.from,
      this.description,
      this.date,
      this.time,
      this.fee,
      this.reference,
      this.amount,
      this.to,
      this.type,
      this.title,
      this.transactionStatus
    }
  );
  
  final TransactionModel? transactions;
  final String? from;
  final String? to;
  final String? date;
  final String? amount;
  final String? time;
  final String? type;
  final String? reference;
  final String? transactionStatus;
  final int? fee;
  final String? description;
  final String? title;

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final ScreenshotController screenshotController = ScreenshotController();

  GlobalKey global = GlobalKey();




  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context, listen: true);
    final userData = userProvider.userData;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(title: 'Transaction Details'),
      body: Screenshot(
        controller: screenshotController,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: Column(
              children: [
                RepaintBoundary(
                  key: global,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.red,
                        child: TextBold(
                          widget.title![0],
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                      ),

                      Gap(10.h),
                      MyText(
                        title: widget.type == 'debit'
                            ? '- ${widget.amount}'
                            : '+ ${widget.amount}',
                        weight: FontWeight.w500,
                        size: 18,
                        color: widget.type == 'debit'
                            ? const Color(0xffFF0000)
                            : const Color(0xff11D100)
                      ),

                      MyText(
                        title: widget.title,
                        weight: FontWeight.w500,
                        size: 18,
                        color: plugBlack,
                        textOverflow: TextOverflow.ellipsis,
                        maxLines: 1
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
                            "${userData?.firstname} ${userData?.lastname}",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),

                      Gap(screenHeight(context) * 0.008),
                      const Divider(
                        color: AppColors.plugTextColor,
                      ),

                      Gap(screenHeight(context) * 0.017),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          H1(
                            "To",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          TextSemiBold(
                            "${widget.to}",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),

                      Gap(screenHeight(context) * 0.008),
                      const Divider(
                        color: AppColors.plugTextColor,
                      ),

                      Gap(screenHeight(context) * 0.017),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          H1(
                            "Date",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          Row(
                            children: [
                              TextSemiBold(
                                "${widget.date},",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              Gap(4),
                              TextSemiBold(
                                "${widget.time}",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
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
                            "Transaction Reference",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          Gap(screenHeight(context) * 0.05),
                          Flexible(
                            child: TextSemiBold(
                              "${widget.reference}",
                              textAlign: TextAlign.end,
                              maxLines: 3,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
                            "Transaction Status",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          Gap(screenHeight(context) * 0.05),
                          Flexible(
                            child: TextSemiBold(
                              widget.transactionStatus == 'TRANSACTION SUCCESSFUL' ? "Successful" : "Unsuccessful",
                              textAlign: TextAlign.end,
                              color: widget.transactionStatus == 'TRANSACTION SUCCESSFUL'
                              ? const Color(0xff11D100)
                              : const Color(0xffFF0000),
                              maxLines: 3,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
                            "Transaction Fee",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          Gap(screenHeight(context) * 0.05),
                          Flexible(
                            child: TextSemiBold(
                              "${widget.fee}",
                              textAlign: TextAlign.end,
                              maxLines: 3,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
                            "Description",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          Gap(screenHeight(context) * 0.05),
                          Flexible(
                            child: TextSemiBold(
                              "${widget.description}",
                              textAlign: TextAlign.end,
                              maxLines: 3,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),

                      Gap(screenHeight(context) * 0.008),
                      const Divider(
                        color: AppColors.plugTextColor,
                      ),
                    ],
                  ),
                ),
                
                AppVerticalSpacing.verticalSpacingXS,
                CustomButtonWithIconRight(
                  onPressed: () {},
                  title: 'Download',
                  gradient: gradient2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class TransactionsDetailsInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? color;
  const TransactionsDetailsInfo({
    super.key,
    required this.title,
    required this.subtitle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: MyText(
            title: title,
            weight: FontWeight.w500,
            size: 18,
            color: plugBlack,
          ),
          trailing: MyText(
            title: subtitle,
            weight: FontWeight.w400,
            size: 14,
            color: color ?? plugBlack,
          ),
        ),
        const Divider(
          thickness: 2,
          color: Color(0xffC4C4C4),
        )
      ],
    );
  }
}
