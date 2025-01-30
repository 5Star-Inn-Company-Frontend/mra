import '../../res/import/import.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String? val)? validator;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String? val)? onchanged;
  final Function(String? val)? onsaved;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? titleText;
  final TextStyle? textStyle;
  final int? maxLength;
  final int? maxLines;
  final fillColor;
  final double? height;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final textAlign;
  final bool obscureText;
  final bool readonly;

  const CustomTextFormField(
      {super.key,
      this.validator,
      this.label,
      this.controller,
      this.textInputType,
      required this.obscureText,
      this.onchanged,
      this.onsaved,
      this.textInputAction,
      this.hintText,
      this.titleText,
      this.textStyle,
      this.maxLength,
      this.maxLines,
      this.height,
      this.textInputFormatter,
      required this.readonly,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.fillColor,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: textInputType,
      textAlign: textAlign ?? TextAlign.start,
      inputFormatters: textInputFormatter,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
      onChanged: onchanged,
      onSaved: onsaved,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      readOnly: readonly,
      onTap: onTap,
      style: textStyle ??
          GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: plugHeaderTextColor,
            fontSize: 14.0,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: plugHeaderTextColor.withOpacity(0.6),
        ),
        fillColor: fillColor ?? Colors.transparent,
        filled: true,
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: plugHeaderTextColor,
        //   ),
        // ),
        //     borderRadius: BorderRadius.circular(8)),
        // errorBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: AppColors.plugPrimaryColor),
        //     borderRadius: BorderRadius.circular(10)),

        prefixIcon: prefixIcon,
        suffix: suffixIcon,
      ),
    );
  }
}

class CustomInAppTextFormField extends StatelessWidget {
  final String? Function(String? val)? validator;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String? val)? onchanged;
  final Function(String? val)? onsaved;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? titleText;
  final String? initText;
  final TextStyle? textStyle;
  final int? maxLength;
  final int? maxLines;
  final Color? fillColor;
  final double? height;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final bool obscureText;
  final bool readonly;

  const CustomInAppTextFormField(
      {super.key,
      this.validator,
      this.label,
      this.controller,
      this.textInputType,
      required this.obscureText,
      this.onchanged,
      this.onsaved,
      this.textInputAction,
      this.hintText,
      this.initText,
      this.titleText,
      this.textStyle,
      this.maxLength,
      this.maxLines,
      this.height,
      this.textInputFormatter,
      required this.readonly,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.fillColor,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: textInputType,
      textAlign: textAlign ?? TextAlign.start,
      inputFormatters: textInputFormatter,
      textInputAction: textInputAction ?? TextInputAction.next,
      validator: validator,
      onChanged: onchanged,
      onSaved: onsaved,
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
      readOnly: readonly,
      onTap: onTap,
      style: textStyle ??
          GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            color: plugHeaderTextColor,
            fontSize: 14.0,
          ),
      initialValue: initText,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: label,
        hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: plugHeaderTextColor.withOpacity(0.6),
        ),
        fillColor: fillColor ?? Colors.transparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: prefixIcon,
        suffix: suffixIcon,
      ),
    );
  }
}

class HomeScreenCustomTextFormField extends StatelessWidget {
  final String? Function(String? val)? validator;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Function(String? val)? onchanged;
  final Function(String? val)? onsaved;
  final Function()? onTap;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? titleText;
  final BorderRadius? radius;
  final Color? color;
  final TextStyle? textStyle;
  final int? maxLength;
  final int? maxLines;
  final double? height;
  final List<TextInputFormatter>? textInputFormatter;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final bool obscureText;
  final bool readonly;

  const HomeScreenCustomTextFormField(
      {super.key,
      this.validator,
      this.color,
      this.label,
      this.radius,
      this.controller,
      this.textInputType,
      required this.obscureText,
      this.onchanged,
      this.onsaved,
      this.textInputAction,
      this.hintText,
      this.titleText,
      this.textStyle,
      this.maxLength,
      this.maxLines,
      this.height,
      this.onTap,
      this.textInputFormatter,
      this.suffixIcon,
      required this.readonly,
      this.prefixIcon,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: textInputType,
        inputFormatters: textInputFormatter,
        textInputAction: textInputAction,
        validator: validator,
        onChanged: onchanged,
        onSaved: onsaved,
        maxLength: maxLength,
        maxLines: maxLines,
        readOnly: readonly,
        onTap: onTap,
        style: textStyle ??
            GoogleFonts.poppins(
                fontWeight: FontWeight.w500, color: plugBlack, fontSize: 16.0),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: label,
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: color ?? plugAshColor,
          ),
          fillColor: Colors.transparent,
          filled: true,
          contentPadding: padding ??
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: color ?? AppColors.plugPrimaryColor,
              ),
              borderRadius: radius ?? BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.plugPrimaryColor),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: color ?? AppColors.plugPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          labelStyle: GoogleFonts.poppins(
              color: plugBlack, fontSize: 16, fontWeight: FontWeight.w700),
          prefixIcon: prefixIcon,
          suffix: suffixIcon,
          prefixIconConstraints: BoxConstraints(
            minWidth: 13,
          ),
        ),
      ),
    );
  }
}

class pinFied extends StatelessWidget {
  final Function(String value)? onchanged;
  final Function(String value)? onSubmit;
  final TextEditingController? controller;
  const pinFied({
    required this.onchanged,
    required this.onSubmit,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        enabled: true,
        cursorHeight: 30,
        cursorColor: AppColors.plugPrimaryColor,
        smartDashesType: SmartDashesType.enabled,
        textAlign: TextAlign.center,
        maxLength: 1,
        buildCounter: (context,
            {required currentLength, required isFocused, maxLength}) {
          return null;
        },
        onChanged: onchanged,
        onSubmitted: onSubmit,
        controller: controller,
        style: TextStyle(
          color: plugSecondaryTextColor,
          fontSize: 30,
        ),
        obscureText: true,
        decoration: InputDecoration(
          enabled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.plugPrimaryColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
