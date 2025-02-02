import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'res/import/import.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()..checkAuthentication()),
          ChangeNotifierProvider(create: (_) => UserDataProvider()),
          ChangeNotifierProvider(create: (_) => TransactionsDataProvider()),
          ChangeNotifierProvider(create: (_) => TerminalProvider()),
          ChangeNotifierProvider(create: (_) => AirtimeProvider()),
          // ChangeNotifierProvider(create: (_) => CableProvider()),
          ChangeNotifierProvider(create: (_) => PowerProvider()),
          // ChangeNotifierProvider(create: (_) => TransferNotifier()),
          ChangeNotifierProvider(create: (_) => DataProvider()),
          // StreamProvider<InternetConnectionStatus>(
          //   create: (_) {return InternetConnectionChecker.createInstance().onStatusChange;},
          //   initialData: InternetConnectionStatus.connected,
          // )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mega Reseller App',
          theme: ThemeData(
            primaryColor: plugHeaderTextColor,
            primarySwatch: Colors.grey,
          ),
          // home: const DashBoard(),
          initialRoute: Routes.splash,
          onGenerateRoute: generateRoute,
        ),
      ),
    );
  }
}
