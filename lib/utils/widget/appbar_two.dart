import 'package:flutter/material.dart';
import 'package:mra/constant/app_colors.dart';
import 'package:mra/constant/text.dart';
import 'package:mra/utils/widget/back_button.dart';
import 'package:mra/utils/widget/touchable_opacity.dart';

class PlugAppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  const PlugAppBarTwo({
    super.key,
    required this.title,
    this.actions = const [],
    this.centerTitle = true,
  });

  final String title;
  final List<Widget> actions;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.plugPrimaryColor,
      leading: TouchableOpacity(
        onTap: () => Navigator.pop(context),
        child: const AppBackButton(),
      ),
      title: TextBold(
        title,
        fontSize: 22,
        color: AppColors.white,
      ),
      actions: actions,
      flexibleSpace: Image(
        image: AssetImage("assets/images/appBarMask.png"),
        fit: BoxFit.fill,
      ),
      elevation: 0.4,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
