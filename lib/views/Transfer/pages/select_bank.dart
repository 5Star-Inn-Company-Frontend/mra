import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Transfer/bank_list_data.dart';
import 'package:mra/views/Transfer/model/bankList.dart';

class SelectBank extends StatefulWidget {
  const SelectBank({super.key});

  @override
  State<SelectBank> createState() => _SelectBankState();
}

class _SelectBankState extends State<SelectBank> {
  // Datum? _bankList;

  List<Datum> filteredBanks = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredBanks = banks;
  }

  void filterSearchResults(String query) {
    List<Datum> dummySearchList = [];
    dummySearchList.addAll(banks);
    if (query.isNotEmpty) {
      List<Datum> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredBanks = [];
        filteredBanks.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredBanks = [];
        filteredBanks = banks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final parsedResponse = json.decode(bankListresponse);
    final data = parsedResponse['data'];
    final transferData = Provider.of<TransferNotifier>(context);

    return Scaffold(
      appBar: const PlugAppBarTwo(title: 'Select Bank'),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            height: 40,
            child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    color: plugAshColor,
                  ),
                ),
                hintText: 'Search',
                hintStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: plugAshColor,
                ),
                prefixIcon: const Icon(
                  Icons.search_sharp,
                  color: plugAshColor,
                  size: 30,
                ),
              ),
            ),
          ),

          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: 6,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, 
              crossAxisSpacing: 1, 
              childAspectRatio: 2
            ),
            itemBuilder: (ctx, index) {
              final bank = data[index];

              return TouchableOpacity(
                onTap: () async {
                  print(bank['code']);
                  transferData.setBankDetails(
                    bank['name'],
                    bank['code'],
                    bank['url'],
                  );
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(bank['url']),
                      radius: 20,
                    ),
                    
                    Gap(5.h),
                    TextBold(
                      bank['name'],
                      fontSize: 11,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                    AppVerticalSpacing.verticalSpacingS,
                  ],
                ),
              );
            }
          ),

          Gap(10.h),

          Expanded(
            child: ListView.builder(
              itemCount: filteredBanks.length,
              itemBuilder: (BuildContext context, int index) {
                return TouchableOpacity(
                  onTap: () async {
                    print(filteredBanks[index].code);
                    transferData.setBankDetails(
                      filteredBanks[index].name.toString(),
                      filteredBanks[index].code.toString(),
                      filteredBanks[index].url.toString(),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.plugPrimaryColor.withOpacity(0.03),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/bank.png",
                                width: 24,
                                height: 24,
                              ),

                              const Gap(14),

                              TextSemiBold(
                                filteredBanks[index].name.toString(),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.grey[300],
                          )
                        ],
                      )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
