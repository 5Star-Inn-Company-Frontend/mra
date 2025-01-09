import 'package:flutter/cupertino.dart';
import 'package:mra/constant/app_colors.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CupertinoActivityIndicator(
      color: AppColors.plugPrimaryColor,
      radius: 35,
    ));
  }
}
