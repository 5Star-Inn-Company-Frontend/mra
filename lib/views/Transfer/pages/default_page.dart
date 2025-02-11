import 'package:mra/utils/widget/appbar_two.dart';
import '../../../res/import/import.dart';

class DefaultPage extends StatefulWidget {
  final String? bankCode;
  final String? bankname;
  const DefaultPage({super.key, this.bankCode, this.bankname});

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      mobile: Scaffold(
        appBar: const PlugAppBarTwo(title: "Transfer to bank"),
        body: Center(child: Text('Work in Progress'),)
      ),
    );
  }

  
}
