import 'package:mra/constant/fonts.dart';
import 'package:mra/res/import/import.dart';

final textInputDecoration = InputDecoration(
  fillColor: Colors.transparent,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
          color: AppColors.plugPrimaryColor.withOpacity(0.6), width: 0.5)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        width: 1,
        color: AppColors.plugPrimaryColor.withOpacity(0.6),
      )),
  focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(
        width: 1,
        color: Colors.red,
      )),
  errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
    width: 1,
    color: Colors.red,
  )),
  errorStyle: const TextStyle(
    // height: ,
    color: Colors.redAccent,
  ),
  labelStyle: const TextStyle(
    color: AppColors.textPrimaryColor,
  ),
  hintStyle: const TextStyle(
    color: Color(0xffB1B1B2),
    fontFamily: AppFonts.poppins,
    fontSize: 14.0,
  ),
);
