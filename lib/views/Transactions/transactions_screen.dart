import 'package:intl/intl.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Transactions/pages/transaction_statement.dart';
import '../../res/import/import.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String capitalize(String value) {
      var result = value[0].toUpperCase();
      bool cap = true;
      for (int i = 1; i < value.length; i++) {
        if (value[i - 1] == " " && cap == true) {
          result = result + value[i].toUpperCase();
        } else {
          result = result + value[i];
          cap = false;
        }
      }
      return result;
    }

    String formatDate(String dateString) {
      final dateTime = DateTime.parse(dateString);
      final formattedTime = DateFormat('h:mm a').format(dateTime.toLocal());
      return formattedTime;
    }

    final transactionData = Provider.of<TransactionsDataProvider>(context, listen: false).transactionsData;
    if (transactionData!.data.isEmpty) {
      return Scaffold(
        appBar: const PlugAppBarTwo(title: 'Transaction History'),
        body: Center(
          child: TextSemiBold("No Transactions yet"),
        ),
      );
    }
    return ResponsiveScreen(
      mobile: Scaffold(
        appBar: PlugAppBarTwo(
          title: 'Transaction History',
          actions: [
            TouchableOpacity(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TransactionStateMent()
                  ),
                );
              },
              child: const Icon(Icons.more_vert, size: 28,color: AppColors.white,),
            )
          ],
        ),
        backgroundColor: plugWhite,
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                color: Colors.white70,
                height: MediaQuery.of(context).size.height,
                width: double.maxFinite,
                child: ListView.builder(
                    itemCount: transactionData.data.length,
                    itemBuilder: (context, index) {
                      final data = transactionData.data[index];
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
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  title: title,
                                  weight: FontWeight.w500,
                                  size: 18,
                                  color: plugBlack,
                                  textOverflow: TextOverflow.ellipsis,
                                  maxLines: 1
                                ),
                                const Gap(4),
                                MyText(
                                  title: time,
                                  weight: FontWeight.w400,
                                  size: 12,
                                  color: plugBlack,
                                ),
                              ],
                            ),
                            // subtitle:
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  data.type == 'debit' ? '- $formattedAmount' : '+ $formattedAmount',
                                  style: GoogleFonts.roboto(
                                    color: data.type == 'debit' ? const Color(0xffFF0000) : const Color(0xff11D100),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Gap(5),
                                MyText(
                                  title: formattedDate,
                                  weight: FontWeight.w400,
                                  size: 14,
                                  color: plugBlack,
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                            color: Color(0xffC4C4C4),
                          )
                        ],
                      );
                    }),
              )
            ],
          ),
        )),
      ),
    );
  }
}
