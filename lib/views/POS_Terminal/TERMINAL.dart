import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:intl/intl.dart';
import 'package:mra/constant/app_colors.dart';
import 'package:mra/constant/text.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/utils/formatter.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/utils/widget/touchableOpacity.dart';
import 'package:mra/views/POS_Terminal/model/singleTerminal.dart';
import 'package:mra/views/POS_Terminal/service/terminalService.dart';

class TERMINAL extends StatefulWidget {
  final String barTitle;
  final int? id;
  TERMINAL({Key? key, required this.barTitle, required this.id})
      : super(key: key);

  @override
  State<TERMINAL> createState() => _TERMINALState();
}

class _TERMINALState extends State<TERMINAL> {
  int currentIndex = 0;

  late PageController _pageController;

  bool _isLoading = false;

  late Future<TerminalTransactions?> futureTerminal;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
    futureTerminal = loadTerminalTransactions(widget.id!.toInt());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
        mobile: Scaffold(
            appBar: PlugAppBarTwo(title: widget.barTitle),
            body: SafeArea(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: FutureBuilder(
                    future: futureTerminal,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final formattedBalance =
                            "\u{20A6}${snapshot.data!.datas!.transactions!.list!.first.balance!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}";
                        return Column(
                          children: [
                            TextBold(
                              formattedBalance,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              decoration: BoxDecoration(
                                  // color: AppColors.white,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TouchableOpacity(
                                      onTap: () {
                                        _pageController.animateToPage(0,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves
                                                .easeInOutCubicEmphasized);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 3.0,
                                                  color: currentIndex == 0
                                                      ? AppColors
                                                          .plugPrimaryColor
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Center(
                                              child: TextSemiBold("Inward"))),
                                    ),
                                  ),
                                  Expanded(
                                    child: TouchableOpacity(
                                      onTap: () {
                                        _pageController.animateToPage(1,
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves
                                                .easeInOutCubicEmphasized);
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  width: 3.0,
                                                  color: currentIndex == 1
                                                      ? AppColors
                                                          .plugPrimaryColor
                                                      : Colors.transparent),
                                            ),
                                          ),
                                          child: Center(
                                              child: TextSemiBold("Outward"))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: PageView(
                                controller: _pageController,
                                onPageChanged: ((int index) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                }),
                                children: [
                                  //first tab page
                                  Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: snapshot.data!.datas!
                                            .transactions!.list!.length,
                                        itemBuilder: (context, index) {
                                          final data = snapshot.data!.datas!
                                              .transactions!.list![index];
                                          String time = formatDate(
                                              data.timeCreated.toString());
                                          final formattedAmount =
                                              "\u{20A6}${data.amount!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}";
                                          String dateString =
                                              data.timeCreated.toString();
                                          DateTime dateTime =
                                              DateTime.parse(dateString);
                                          String formattedDate =
                                              DateFormat('dd MMM yyyy')
                                                  .format(dateTime);
                                          return Visibility(
                                            visible:
                                                data.transactionType == 'DEBIT',
                                            child: Column(
                                              children: [
                                                ListTile(
                                                    title: TextSemiBold(
                                                      data.transactionType
                                                          .toString(),
                                                    ),
                                                    subtitle:
                                                        TextSemiBold(time),
                                                    trailing: Column(
                                                      children: [
                                                        TextSemiBold(
                                                          '- $formattedAmount',
                                                          color: data.transactionType ==
                                                                  'DEBIT'
                                                              ? Colors.red
                                                              : AppColors
                                                                  .plugTextColor,
                                                        ),
                                                        const Gap(3),
                                                        TextSemiBold(
                                                            formattedDate)
                                                      ],
                                                    )),
                                                const Divider(
                                                  color: Color(0xffC4C4C4),
                                                  thickness: 0.6,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                                  //second tab page
                                  Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: snapshot.data!.datas!
                                            .transactions!.list!.length,
                                        itemBuilder: (context, index) {
                                          final data = snapshot.data!.datas!
                                              .transactions!.list![index];
                                          String time = formatDate(
                                              data.timeCreated.toString());
                                          final formattedAmount =
                                              "\u{20A6}${data.amount!.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}";
                                          String dateString =
                                              data.timeCreated.toString();
                                          DateTime dateTime =
                                              DateTime.parse(dateString);
                                          String formattedDate =
                                              DateFormat('dd MMM yyyy')
                                                  .format(dateTime);
                                          return Visibility(
                                            visible: data.transactionType ==
                                                'CREDIT',
                                            child: Column(
                                              children: [
                                                ListTile(
                                                    title: TextSemiBold(
                                                      data.transactionType
                                                          .toString(),
                                                    ),
                                                    subtitle:
                                                        TextSemiBold(time),
                                                    trailing: Column(
                                                      children: [
                                                        TextSemiBold(
                                                          '- $formattedAmount',
                                                          color: data.transactionType ==
                                                                  'CREDIT'
                                                              ? Colors
                                                                  .greenAccent
                                                              : AppColors
                                                                  .plugTextColor,
                                                        ),
                                                        const Gap(3),
                                                        TextSemiBold(
                                                            formattedDate)
                                                      ],
                                                    )),
                                                const Divider(
                                                  color: Color(0xffC4C4C4),
                                                  thickness: 0.6,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return TextBold(
                            "Unable to get Transaction data, try again later");
                      }
                      return const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: AppColors.plugPrimaryColor,
                        ),
                      );
                    },
                  )),
            )));
  }
}
