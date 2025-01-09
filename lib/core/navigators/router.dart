import 'package:mra/core/navigators/router_names.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/views/wrapper.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.splash:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const Splash(),
      );
    case Routes.introduction:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const OnBoardingScreen(),
      );
    case Routes.wrapper:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const Wrapper(),
      );
    case Routes.loginScreen:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const LoginScreen(),
      );
    case Routes.airtime:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const Airtime(),
      );
    case Routes.transfer:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const Transfer(),
      );
    case Routes.electricity:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: Electricity(),
      );
    case Routes.data:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const Data(),
      );
    case Routes.cableTv:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CableTv(),
      );
    case Routes.posTerminal:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: POS_Terminal(),
      );
    case Routes.forgetPassword:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const ForgotPassword(),
      );
    case Routes.setFingerPrint:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: const SetFingerPrint(),
      );
    default:
      return MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

// ignore: strict_raw_type
PageRoute _getPageRoute({String? routeName, Widget? viewToShow}) {
  return MaterialPageRoute<void>(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow!,
  );
}
