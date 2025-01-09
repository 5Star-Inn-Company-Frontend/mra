import 'package:mra/utils/widget/appbar_two.dart';
import '../../res/import/import.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  
  final List title = <String>[
    '',
    ' ',
    '',
    '',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PlugAppBarTwo(title: 'Settings'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Column(
          children: [
            const SettingsWidget(title: 'Profile', widget: Profile()),
            const Divider(color: Color(0xffC4C4C4), thickness: 2),

            const SettingsWidget(title: 'Profile settings', widget: ProfileSettings()),
            const Divider(color: Color(0xffC4C4C4), thickness: 2),
            
            const SettingsWidget(title: 'Change Pin', widget: ChangePin()),
            const Divider(color: Color(0xffC4C4C4), thickness: 2),
            
            const SettingsWidget(title: 'Password Settings', widget: PasswordSettings()),
            const Divider(color: Color(0xffC4C4C4), thickness: 2),
            
            const SettingsWidget(title: 'Referrals', widget: Referrals()),
          ],
        ),
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  final String title;
  final Widget? widget;

  const SettingsWidget({
    super.key,
    required this.title,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => widget!));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              title: title,
              color: plugTextColor,
              size: 18,
              weight: FontWeight.w500,
            ),
            const Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }
}
