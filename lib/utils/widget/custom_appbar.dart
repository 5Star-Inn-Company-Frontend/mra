import 'package:clipboard/clipboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/import/import.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  
  @override
  Widget build(BuildContext context) {
    //check time of day
    String daytime = 'Morning';
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour < 12) {
      setState(() {
        daytime = 'morning';
      });
    } else if (hour < 18) {
      setState(() {
        daytime = "afternoon";
      });
    } else {
      setState(() {
        daytime = "evening";
      });
    }

    // final String terminalData;

    //user provider
    // final userProvider = Provider.of<UserDataProvider>(context, listen: true);
    // final userData = userProvider.userData?.data;
    // final accts = userData?.accountDetails?.split('|');
    // final wallet = userProvider.walletData?.data?.map((e) => e.balance);
    // String balance = wallet?.first.toString() ?? '';
    // final amount = double.parse(balance);
    // final formattedAmount =
    //     "\u{20A6}${amount.toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}";
    // // final terminal = Provider.of<TerminalProvider>(context, listen: true);
    // // if (terminal.terminalData!.datas!.isEmpty) {
    // //   terminalData = '';
    // // } else {
    // //   terminalData =
    // //       terminal.terminalData?.datas?[0].terminalId.toString() ?? '';
    // // }

    final userProvider = Provider.of<UserDataProvider>(context, listen: true);
    final userData = userProvider.userData;

    final vacctsData = Provider.of<UserDataProvider>(context).userVacctData;

    final wallet = userProvider.walletData?.data?.map((e) => e.balance);
    String balance = wallet?.first.toString() ?? 0.00.toString();
    final amount = double.parse(balance);

    // Format the balance
    final formattedAmount = "\u{20A6}${amount.toStringAsFixed(2).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},"
    )}";


    return Stack(
      clipBehavior: Clip.none,
      children: [
        customBbox(
          height: 200,
          color: AppColors.plugPrimaryColor,
          width: MediaQuery.of(context).size.width,
          radius: const BorderRadius.only(bottomLeft: Radius.circular(71), bottomRight: Radius.circular(71),),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0, left: 30),
                child: IconButton(
                  icon: const Icon(Icons.menu, size: 40, color: plugWhite,),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                )
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 80.0, right: 30),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const Notifications())
                    );
                  },
                  icon: const Icon(Icons.notifications, color: plugWhite, size: 40,),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          left: 55,
          top: 120,
          child: MyText(
            title: 'Good $daytime ${userData?.firstname}',
            weight: FontWeight.w600, align: TextAlign.center, size: 22.5, color: plugWhite, textOverflow: TextOverflow.visible,
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          top: 160,
          // bottom: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(20)
            ),
          )
        ),

        Positioned(
          left: 30,
          top: 170,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(title: 'Balance', size: 16, color: plugWhite, weight: FontWeight.w400,),

              const SizedBox(height: 4),
              MyText(title: formattedAmount, size: 22.sp, color: plugWhite, weight: FontWeight.w700,),
              
              Gap(10.h),
              Container(
                color: Colors.white,
                width: 200,
                height: 2,
              ),
              
              Gap(15.h),
              Row(
                children: [
                  MyText(
                    title: vacctsData != null && vacctsData.data.isNotEmpty
                    ? vacctsData.data[0].accountNumber
                    : 'No Account Number',
                    size: 15.sp, color: plugWhite, weight: FontWeight.w700,
                  ),

                  Gap(12.w),
                  TouchableOpacity(
                    onTap: () async {
                      if (vacctsData != null && vacctsData.data.isNotEmpty) {
                        await FlutterClipboard.copy('Account Number: ${vacctsData.data.first.accountNumber}')
                          .then((value) => Flushbar(
                            message: 'Account number copied to clipboard',
                            flushbarStyle: FlushbarStyle.GROUNDED,
                            isDismissible: true,
                            flushbarPosition: FlushbarPosition.TOP,
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ).show(context));
                      } else {
                        Flushbar(
                          message: 'No account number to copy',
                          flushbarStyle: FlushbarStyle.GROUNDED,
                          isDismissible: true,
                          flushbarPosition: FlushbarPosition.TOP,
                          duration: const Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ).show(context);
                      }
                    },
                    child: const Icon(Icons.copy_sharp, color: AppColors.white,),
                  )
                ],
              ),

              AppVerticalSpacing.verticalSpacingS,
              MyText(
                title: vacctsData != null && vacctsData.data.isNotEmpty
                ? 'Bank Name: ${vacctsData.data[0].provider}'
                : 'No Bank Name',
                size: 12.sp,
                color: AppColors.white,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis
              ),

              Gap(5.h),
              MyText(
                title: vacctsData != null && vacctsData.data.isNotEmpty
                ? 'Account Name: ${vacctsData.data[0].accountName}'
                : 'No Account Name',
                size: 12.sp,
                color: AppColors.white,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis
              ), 

              // AppVerticalSpacing.verticalSpacingS,
              // MyText(
              //   title: terminalData.toString(),
              //   size: 16,
              //   color: plugWhite,
              //   weight: FontWeight.w400,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: true);
    final userProvider = Provider.of<UserDataProvider>(context, listen: true);
    final userData = userProvider.userData;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              customBbox(
                width: double.maxFinite,
                height: 133,
                color: AppColors.plugPrimaryColor,
              ),
              // Positioned(
              //   left: 30,
              //   top: 60,
              //   child: CircleAvatar(
              //     radius: 20,
              //     backgroundColor: Colors.white,
              //     // backgroundImage:
              //         // NetworkImage(userData?.profilePhotoUrl ?? ''),
              //   ),
              // ),
              Positioned(
                left: 20,
                top: 65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: 'Hello, ${userData?.firstname ?? ''}',
                      weight: FontWeight.w600,
                      size: 18,
                      color: plugWhite,
                    ),
                    MyText(
                      title: 'Mega Reseller App is made for you',
                      weight: FontWeight.w600,
                      size: 13,
                      color: plugWhite,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                child: Image.asset(
                  'assets/images/Mask_Group2.png',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 480,
            width: double.maxFinite,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: drawerList.length,
                itemBuilder: (ctx, i) {
                  var drawerItems = drawerList[i];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => drawerItems.route));
                        },
                        leading: Image.asset(
                          drawerItems.image,
                          width: screenWidth(context) * 0.05,
                          height: screenHeight(context) * 0.05,
                        ),
                        title: MyText(
                          title: drawerItems.title,
                          weight: FontWeight.w500,
                          size: 18,
                          color: plugBlack,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: plugBlack,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Color(0xffC4C4C4),
                      )
                    ],
                  );
                }),
          ),
          ListTile(
            onTap: () async {
              await user.logout();
              // ignore: use_build_context_synchronously
              Navigator.popAndPushNamed(context, Routes.wrapper);
            },
            leading: Image.asset(
              'assets/images/dash_icon7.png',
              width: 23.75,
              height: 25,
            ),
            title: MyText(
              title: 'Logout',
              weight: FontWeight.w500,
              size: 18,
              color: plugBlack,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppColors.plugPrimaryColor,
            ),
          ),
          const Divider(
            thickness: 2,
            color: Color(0xffC4C4C4),
          )
        ],
      ),
    );
  }
}

// PreferredSize buildAppBar(String title, onPressed) {
//   return PreferredSize(
//     preferredSize: const Size.fromHeight(60),
//     child: AppBar(
//       backgroundColor: AppColors.plugPrimaryColor,
//       iconTheme: IconThemeData(color: Colors.white, size: 30),
//       automaticallyImplyLeading: false,
//       title: Row(
//         // mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: onPressed,
//             child: Icon(
//               Icons.arrow_back_ios_sharp,
//               color: plugWhite,
//             ),
//           ),
//           // AppHorizontalSpacing.horizontalSpacingXL,
//           Align(
//             alignment: Alignment.topCenter,
//             child: MyText(
//               title: title,
//               size: 24,
//               weight: FontWeight.w700,
//               color: plugWhite,
//             ),
//           ),
//         ],
//       ),
//       flexibleSpace: Image.asset(
//         'assets/images/appBarMask.png',
//         fit: BoxFit.fill,
//         height: double.infinity,
//       ),
//     ),
//   );
// }
