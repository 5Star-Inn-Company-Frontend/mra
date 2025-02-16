import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../res/import/import.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionsDataProvider>().loadTransactionData(context);
    // context.read<UserDataProvider>().loadWallet(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserDataProvider>(context, listen: true);
    final transactionData = Provider.of<TransactionsDataProvider>(context, listen: true).transactionsData;

    return ResponsiveScreen(
      mobile: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: plugWhite,
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<TransactionsDataProvider>().loadTransactionData(context);
            context.read<UserDataProvider>().loadWallet(context);
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomAppBar(),
                
                AppVerticalSpacing.verticalSpacingM,
                Padding(
                  padding:const EdgeInsets.symmetric(vertical: 170, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        title: 'Quick actions', weight: FontWeight.w600, size: 20, color: plugBlack,
                      ),
          
                      Gap(10.h),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white
                        ),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: gridItems.length,
                          padding: EdgeInsets.zero,
                          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (ctx, i) {
                            var gridDetails = gridItems[i];
                            return InkWell(
                              onTap: () {
                                // Prevent multiple navigation attempts
                                if (Navigator.canPop(context)) {
                                  return;
                                }
                                Navigator.push(
                                  context, MaterialPageRoute(builder: (_) => gridDetails.route),
                                );
                              },
                              child: Container(
                                // height: 70,
                                // width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff525151).withOpacity(0.3),
                                      offset: const Offset(4, 4),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(gridDetails.image),
          
                                    AppVerticalSpacing.verticalSpacingS,
                                    MyText(
                                      title: gridDetails.title, size: 14, weight: FontWeight.w400, color: plugBlack,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          
                      Gap(screenHeight(context) * 0.035),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(
                            title: 'Transactions', size: 20, weight: FontWeight.w600, color: plugBlack,
                          ),
          
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(builder: (_) => const TransactionScreen())
                              );
                            },
                            child: Row(
                              children: [
                                MyText(title: 'See all', size: 14, weight: FontWeight.w400, color: plugBlack,),
          
                                Icon(Icons.arrow_forward_ios_outlined, color: plugBlack, size: 20,)
                              ],
                            ),
                          ),
                        ],
                      ),
          
                      Gap(screenHeight(context) * 0.025),
          
                      Visibility(
                        // visible: transactionData?.data == [] ? false : true,
                        visible: transactionData != null && transactionData.data.isNotEmpty,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // itemCount: transactionData!.data.length > 3 ? 3 : transactionData.data.length,
                          itemCount: transactionData != null && transactionData.data.length > 3 ? 3 : transactionData?.data.length ?? 0,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final data = transactionData!.data[index];
                            String dateString = data.createdAt.toString();
                            DateTime dateTime = DateTime.parse(dateString);
                            
                            String title = capitalize(data.title);
                            String time = formatDate(data.updatedAt.toString());
                            
                            final amount = double.parse(data.amount.toString());
                            String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
                            final formattedAmount = "\u{20A6}${amount.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}";
                            
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TransactionDetails(
                                          // image: data?.bills?.provider,
                                          description: data.remark,
                                          fee: data.charges,
                                          to: data.recipient,
                                          reference: data.reference,
                                          date: formattedDate,
                                          time: time,
                                          // from: data.provider,
                                          amount: formattedAmount,
                                          type: data.type,
                                          title: title,
                                        )
                                      )
                                    );
                                  },
          
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.red,
                                    child: TextBold(
                                      title[0],
                                      color: AppColors.white, fontSize: 14,
                                    ),
                                  ),
          
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        title: title,
                                        weight: FontWeight.w500, size: 18, color: plugBlack,
                                        textOverflow: TextOverflow.ellipsis,
                                        maxLines: 1
                                      ),
          
                                      const Gap(4), 
                                      MyText(
                                        title: time,
                                        weight: FontWeight.w400, size: 12, color: plugBlack,
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // MyText(
                                      //   title: data.type == 'debit'
                                      //   ? '- $formattedAmount'
                                      //   : '+ $formattedAmount',
                                      //   // data.amount,
                                      //   weight: FontWeight.w500,
                                      //   size: 18,
                                      //   color: data.type == 'debit'
                                      //   ? const Color(0xffFF0000)
                                      //   : const Color(0xff11D100),
                                      // ),
          
                                      Text(
                                        data.type == 'debit' ? '- $formattedAmount' : '+ $formattedAmount',
                                        style: GoogleFonts.roboto(
                                          color: data.type == 'debit' ? const Color(0xffFF0000) : const Color(0xff11D100),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
          
                                      const Gap(5),
                                      MyText(title: formattedDate, weight: FontWeight.w400, size: 14, color: plugBlack,),
                                    ],
                                  ),
                                ),
          
                                const Divider(thickness: 2, color: Color(0xffC4C4C4),)
                              ],
                            );
                          }
                        ),
                      ),
          
                      Visibility(
                        // visible: transactionData.data.isEmpty ? true : false,
                        visible: transactionData != null && transactionData.data.isEmpty,
                        child: Center(
                          child: TextBold(
                            "No Transaction history yet!",
                            textAlign: TextAlign.center, color: Colors.grey, fontSize: 17,
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
