import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Transactions/model/transaction_model.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';


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
  GlobalKey global = GlobalKey();

  ScreenshotController screenshotController = ScreenshotController();

  


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
                  child: Container(
                    color: Colors.white,
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
                        Text(
                          widget.type == 'debit' ? '- ${widget.amount}' : '+ ${widget.amount}',
                          style: GoogleFonts.roboto(
                            color: widget.type == 'debit' ? const Color(0xffFF0000) : const Color(0xff11D100),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                                
                        MyText(
                          title: widget.title,
                          weight: FontWeight.w500,
                          size: 18,
                          color: plugBlack,
                          textOverflow: TextOverflow.ellipsis,
                          maxLines: 1
                        ),
                                
                        Gap(10.h),
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
                                
                        const Divider(color: AppColors.plugTextColor,),
                                
                        Gap(5.h),
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
                                
                        
                        const Divider(
                          color: AppColors.plugTextColor,
                        ),
                                
                        Gap(5.h),
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
                                
                        const Divider(
                          color: AppColors.plugTextColor,
                        ),
                                
                        Gap(5.h),
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
                                
                        const Divider(
                          color: AppColors.plugTextColor,
                        ),
                                
                        Gap(5.h),
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
                                
                        
                        const Divider(
                          color: AppColors.plugTextColor,
                        ),
                        
                        Gap(5.h),
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
                                
                        const Divider(
                          color: AppColors.plugTextColor,
                        ),
                        
                        Gap(5.h),
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
                                
                        const Divider(
                          color: AppColors.plugTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
                
                AppVerticalSpacing.verticalSpacingXS,
                CustomButtonWithIconRight(
                  onPressed: () {
                    _captureAndSave(context);
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

  Future<bool> storagePermission() async {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }


  Future<void> _captureAndSave(BuildContext context) async {
    try {
      // 1) capture logic
      RenderRepaintBoundary boundary = global.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 10.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

       // 2) save image logic
      final directory = (await getApplicationDocumentsDirectory()).path;
      final fileName = File('$directory/optionvtu-receipt-${DateTime.now().millisecondsSinceEpoch}.png');
      await fileName.writeAsBytes(pngBytes);
    
      
      // final dir = Directory("/storage/emulated/0/Downloads");
      // // final directory = (await getApplicationDocumentsDirectory()).path;
      // final fileName = File('/storage/emulated/0/Downloads/optionvtu-receipt-${DateTime.now().millisecondsSinceEpoch}.png');
      // await fileName.writeAsBytes(pngBytes);

      // bool status = await storagePermission(); // here  get storage permission  from another function

      // if (status) {
      //   if (await dir.exists()) {
      //     dir.path;
      //   } else {
      //     dir.create();
      //     dir.path;
      //   }
      //   File file = File('${dir.path}/$fileName');
      //   print('file : $file');
      //   print('dir : ${dir.path}');
      //   file.writeAsBytes(pngBytes);

      // }

      // show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image saved successfully'),
        ),
      );

    // open file   
    await OpenFile.open(fileName.path);
    } catch (e) {
      throw Exception(e);
    }
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
