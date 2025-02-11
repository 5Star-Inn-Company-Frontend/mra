import 'package:mra/res/import/import.dart';
import 'package:mra/views/auth/authenticate.dart';
import 'package:mra/views/home.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context, listen: true);
    // final internet = Provider.of<InternetConnectionStatus>(context, listen: true);
    // if (internet == InternetConnectionStatus.disconnected) {
    //   return const NoInternet();
    // }
    if (user.isAuthenticated == false) {
      return Authenticate();
    } else {
      return const Home();
    }
  }
}
