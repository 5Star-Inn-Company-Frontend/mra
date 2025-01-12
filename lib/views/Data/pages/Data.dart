import 'dart:math';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Data/model/dataPlans.dart';
import 'package:mra/views/Data/model/dataProviders.dart';
import 'package:mra/views/Data/pages/dataPin.dart';
import 'package:mra/views/Data/service/dataProviders.dart';
import 'package:mra/views/Transfer/constants/textField.dart';
import '../../../res/import/import.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  TextEditingController controller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late Future<DataProviders?> futureDataProvider;

  DataPlans? _dataPlans;

  int? selectedRadioTile;

  int? selectedPlan;

  String? selectedPlanName;

  bool isVisible = false;

  bool isValid = true;

  String _country = 'Nigeria';
  String _countryCode = '234';
  String? formattedCode;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  Future<DataPlans> loadDataPlans(String service) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    // print(token);
    try {
      final response = await ApiService.dio.get('/internet-plans/$service',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(response.data);
        final plans = DataPlans.fromJson(response.data);

        if (response.data['success'] == true) {
          if (mounted) {
            setState(() {
              _dataPlans = plans;
            });
          }
        }

        print(_dataPlans?.data.runtimeType);

        print(_dataPlans);
      }
    } on DioException catch (e) {
      if (DioExceptionType.connectionError == e.type ||
          DioExceptionType.connectionTimeout == e.type ||
          DioExceptionType.receiveTimeout == e.type ||
          DioExceptionType.sendTimeout == e.type) {
        return DataPlans(
            success: false, message: 'Network Exception', data: []);
      }
    }
    return DataPlans(success: false, message: "", data: []);
  }

  int provider = 1;
  int currentIndex = 0;
  Future<DataPlans>? futureDataPlans;

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      return await FastContacts.getAllContacts();
    }
    if (mounted) {
      setState(() {});
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    getContacts();
    selectedRadioTile;
    futureDataProvider = loadDataProvider();
    futureDataPlans = loadDataPlans('AIRTEL');
  }

  String? dataPlan;
  String? dataPlan2;
  @override
  Widget build(BuildContext context) {
    final dataNotifier = Provider.of<DataProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(title: "Data"),
      body: ResponsiveScreen(
        mobile: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        MyText(
                          title: 'Select Network Provider',
                          size: 14,
                          color: plugSecondaryTextColor,
                        ),

                        AppVerticalSpacing.verticalSpacingS,
                        SizedBox(
                          height: 80,
                          width: double.maxFinite,
                          child: FutureBuilder(
                            future: futureDataProvider,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        print(snapshot.data?.data?[index].id);
                                        setState(() {
                                          currentIndex = index;
                                          provider = snapshot.data?.data?[index].id ?? 1;
                                        });
                                        futureDataPlans = loadDataPlans(snapshot.data!.data?[index].provider ?? '');
                                        print(snapshot.data?.data?[index].provider);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.5,
                                            color: currentIndex == index ? AppColors.plugPrimaryColor : AppColors.white),
                                          borderRadius: BorderRadius.circular(8),
                                          color: currentIndex == index ? AppColors.primaryBrown : AppColors.white,
                                          // color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff525151).withOpacity(0.3),
                                              offset: const Offset(4, 4),
                                              blurRadius: 15,
                                            ),
                                          ]
                                        ),
                                        child: Image.asset(
                                          snapshot.data?.data![index].providerLogoUrl.toString() ?? '',
                                          width: 50,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              return const Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: AppColors.plugPrimaryColor,
                                ),
                              );
                            },
                          ),
                        ),

                        AppVerticalSpacing.verticalSpacingXL,
                        MyText(
                          title: 'Mobile Number',
                          size: 14,
                          color: plugSecondaryTextColor,
                          weight: FontWeight.w400,
                        ),

                        AppVerticalSpacing.verticalSpacingS,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: IntlPhoneField(
                                        controller: phonecontroller,
                                        decoration:
                                          textInputDecoration.copyWith(
                                            hintText: '0000 0000 0000',
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            fillColor: Color(0xffF5F5F5),
                                            focusedErrorBorder:InputBorder.none
                                          ),
                                        initialCountryCode: 'NG',
                                        initialValue: '00000000000',
                                        autofocus: false,
                                        validator: (p0) {
                                          if (phonecontroller.text.length != 10 || phonecontroller.text.length != 11) {
                                            return ("Invalid phone number");
                                          }
                                          return null;
                                        },
                                        flagsButtonMargin: const EdgeInsets.only(left: 10),
                                        dropdownIconPosition: IconPosition.trailing,
                                        dropdownIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimaryColor,),
                                        disableLengthCheck: true,
                                        textInputAction: TextInputAction.next,
                                        onChanged: (phone) {
                                          setState(() {
                                            _countryCode = phone.countryCode;
                                          });
                                        },
                                        onCountryChanged: (country) {
                                          setState(() {
                                            _country = country.name;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            AppHorizontalSpacing.horizontalSpacingS,
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => customBbox(
                                    color: plugWhite,
                                    radius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                    widget: SizedBox(
                                      height: 400,
                                      width: MediaQuery.of(context).size.width,
                                      child: FutureBuilder(
                                          future: getContacts(),
                                          builder: (context, snapshot) {
                                            if (snapshot.data == null) {
                                              return const Text(
                                                "No contacts found"
                                              );
                                            }
                                            var contacts = snapshot.data;
                                            return snapshot.hasData
                                                ? ListView.builder(
                                                    itemCount: contacts!.length,
                                                    itemBuilder: (context, i) {
                                                      Contact contact = snapshot.data![i];
                                                      controller.text = contact.phones[0].number;
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {contact;});
                                                          Navigator.pop(context);
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Column(
                                                            children: [
                                                              AppVerticalSpacing.verticalSpacingD,
                                                              Container(
                                                                padding: const EdgeInsets.all(10),
                                                                height: 70,
                                                                width: MediaQuery.of(context).size.width,
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius: 20,
                                                                      child: Icon(Icons.person, color:plugTetTextColor,),
                                                                    ),

                                                                    AppHorizontalSpacing.horizontalSpacingS,
                                                                    Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        MyText(
                                                                          title: contact.displayName,
                                                                          size: 16,
                                                                          color: plugBlack,
                                                                          weight: FontWeight.w700,
                                                                        ),

                                                                        MyText(
                                                                          title: contact.phones[0].number,
                                                                          size: 16,
                                                                          color: plugBlack,
                                                                          weight: FontWeight.w700,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              const Divider(color: Color(0xffF5F5F5), thickness: 2,),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  )
                                                : snapshot.hasError
                                                ? Center(
                                                    child: MyText(
                                                      title:'No Contacts Available On this device',
                                                      size: 24,
                                                      weight: FontWeight.w700,
                                                      color: plugBlack,
                                                    ),
                                                  )
                                                : Center(
                                                    child: MyText(
                                                      title: 'LOADING.....',
                                                      size: 24,
                                                      weight:
                                                          FontWeight.w700,
                                                      color: plugBlack,
                                                    ),
                                                  );
                                          }),
                                    ),
                                  ),
                                );
                              },
                              child: Image.asset('assets/images/add_contacts.png'),
                            ),
                          ],
                        ),

                        AppVerticalSpacing.verticalSpacingN,
                        MyText(
                          title: 'Select Data Plan',
                          fonts: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: plugTextColor,
                          ),
                        ),

                        Visibility(
                          visible: _dataPlans?.data?.length != null ? true : false,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(parent: ScrollPhysics()),
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 4 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 1
                            ),
                            itemCount: _dataPlans?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                value: index,
                                groupValue: selectedRadioTile,
                                title: TextSemiBold(
                                  ' ${_dataPlans?.data?[index].name?.split('-').first} ${_dataPlans?.data?[index].name?.split('-').last}',
                                  textAlign: TextAlign.left,
                                ),
                                subtitle: TextSemiBold(
                                    'Price: N${_dataPlans?.data?[index].amount}'),
                                onChanged: (value) {
                                  setSelectedRadioTile(value!);
                                  setState(() {
                                    selectedPlan = _dataPlans?.data?[index].id;
                                    selectedPlanName =
                                        _dataPlans?.data?[index].name;
                                  });
                                  print(_dataPlans?.data?[index].amount);
                                  print(value);
                                },
                                activeColor: AppColors.plugPrimaryColor,
                              );
                            },
                          ),
                        ),
                        // const Spacer(),
                        Gap(screenHeight(context) * 0.1),
                        CustomButtonWithIconRight(
                          onPressed: () async {
                            if (selectedRadioTile != null &&
                                    phonecontroller.text.length != 10 ||
                                phonecontroller.text.length != 11 &&
                                    _formKey.currentState!.validate()) {
                              final random = Random();
                              final refId = 'ref${random.nextInt(999999999)}d';
                              dataNotifier.setDataPayment(
                                  phonecontroller.text,
                                  selectedPlan!.toInt(),
                                  provider,
                                  refId,
                                  selectedPlanName.toString());
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const DataPin(),
                                ),
                              );
                            } else if (selectedRadioTile == null) {
                              Flushbar(
                                message: 'Pls select a data plan, to continue',
                                duration: Duration(seconds: 3),
                                isDismissible: true,
                                backgroundColor: Colors.red,
                              ).show(context);
                            } else if (phonecontroller.text.length != 10 ||
                                phonecontroller.text.length != 11) {
                              Flushbar(
                                message: 'Input a valid phone number, to continue',
                                duration: Duration(seconds: 3),
                                isDismissible: true,
                                backgroundColor: Colors.red,
                              ).show(context);
                            }
                          },
                          title: 'SEND',
                          gradient: gradient2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
