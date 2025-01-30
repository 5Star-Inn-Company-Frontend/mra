import 'package:mra/res/import/import.dart';

Widget MyText({
  final String? title,
  final double? size,
  final Color? color,
  final TextAlign? align,
  final FontWeight? weight,
  final TextOverflow? textOverflow,
  final int? maxLines,
  final TextStyle? fonts,
  final Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(
      title ?? '',
      style: fonts ??
          GoogleFonts.poppins(
            fontWeight: weight ?? FontWeight.w500,
            color: color,
            fontSize: size,
          ),
      textAlign: align,
      overflow: textOverflow,
      maxLines: maxLines,
    ),
  );
}
