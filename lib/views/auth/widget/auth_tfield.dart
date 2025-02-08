import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/res/import/import.dart';

class AuthTfield extends StatefulWidget {
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  const AuthTfield({super.key, required this.hintText, required this.prefixIcon, this.controller, this.validator, required this.obscureText, required this.suffixIcon, this.keyboardType});

  @override
  State<AuthTfield> createState() => _AuthTfieldState();
}

class _AuthTfieldState extends State<AuthTfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      cursorColor: plugHeaderTextColor.withOpacity(0.6),
      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14.sp, color: plugHeaderTextColor.withOpacity(0.6),),
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14.sp,color: plugHeaderTextColor.withOpacity(0.6),),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.plugPrimaryColor.withOpacity(0.4), width: 2,),
        ),
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: plugHeaderTextColor.withOpacity(0.6), width: 2,),
        ),
      ),
    );
  }
}