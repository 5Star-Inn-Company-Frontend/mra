import 'package:flutter/rendering.dart';

import 'package:mra/constant/app_colors.dart';
import 'package:mra/constant/text.dart';
import 'package:mra/utils/ui_helpers.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Transactions/model/transactions.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../../../../res/import/import.dart';

class TransactionDetails extends StatefulWidget {
  TransactionDetails(
      {Key? key,
      this.transactions,
      this.image,
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
      this.transactionStatus})
      : super(key: key);
  final Transactions? transactions;
  final String? image;
  final String? from;
  final String? to;
  final String? date;
  final String? amount;
  final String? time;
  final String? type;
  final String? reference;
  final String? transactionStatus;
  final String? fee;
  final String? description;
  final String? title;

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final ScreenshotController screenshotController = ScreenshotController();

  GlobalKey global = GlobalKey();

  Future<ByteData?> capture(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData;
    } catch (e) {
      print(e);
    }
    return null;
  }

  void _shareScreenshot() async {
    final imageBytes = await capture(global);
    if (imageBytes != null) {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/screenshot.png');
      await file.writeAsBytes(imageBytes.buffer.asUint8List());

      // ignore: deprecated_member_use
      await Share.shareXFiles([XFile(file.path)],
          subject: 'Transaction receipt',
          text: 'Check out Transaction receipt');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        backgroundColor: AppColors.plugPrimaryColor,
                        child: TextBold(
                          widget.title![0],
                          color: AppColors.white,
                          fontSize: 14,
                        ),
                      ),
                      Gap(10),
                      MyText(
                          title: widget.type == 'debit'
                              ? '- ${widget.amount}'
                              : '+ ${widget.amount}',
                          weight: FontWeight.w500,
                          size: 18,
                          color: widget.type == 'debit'
                              ? const Color(0xffFF0000)
                              : const Color(0xff11D100)),
                      MyText(
                        title: widget.title,
                        weight: FontWeight.w500,
                        size: 18,
                        color: plugBlack,
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
                            "${widget.from}",
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
                              widget.transactionStatus ==
                                      'TRANSACTION SUCCESSFUL'
                                  ? "Successful"
                                  : "Unsucessful",
                              textAlign: TextAlign.end,
                              color: widget.transactionStatus ==
                                      'TRANSACTION SUCCESSFUL'
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
                  onPressed: () async {
                    _shareScreenshot();
                  },
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

class transactionsDetailsInfo extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? color;
  const transactionsDetailsInfo({
    Key? key,
    required this.title,
    required this.subtitle,
    this.color,
  }) : super(key: key);

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
