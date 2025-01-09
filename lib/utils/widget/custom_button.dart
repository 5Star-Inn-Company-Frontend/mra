import '../../res/import/import.dart';

class CustomButtonWithIconRight extends StatelessWidget {
  const CustomButtonWithIconRight({
    super.key,
    this.title,
    this.buttonColor,
    this.textColor,
    this.onPressed,
    this.borderColor,
    this.textSize,
    this.showIcon = false,
    this.icon,
    this.radius,
    this.gradient,
  });

  final String? title;
  final Color? buttonColor;
  final Color? textColor;
  final bool? showIcon;
  final double? textSize;
  final BorderRadius? radius;
  final Color? borderColor;
  final Widget? icon;
  final LinearGradient? gradient;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: gradient,
          border: Border.all(color: borderColor ?? Colors.transparent),
          color: buttonColor,
          borderRadius: radius ?? BorderRadius.circular(28),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(
                title: title ?? '',
                size: textSize ?? 16,
                weight: FontWeight.w500,
                color: textColor ?? plugWhite,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon ?? SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.buttonColor,
    this.textColor,
    this.onPressed,
    this.borderColor,
    this.textSize,
  });

  final String? title;
  final Color? buttonColor;
  final Color? textColor;
  final double? textSize;
  final Color? borderColor;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
            color: buttonColor ?? plugPrimaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: MyText(
                  title: title ?? '',
                  size: textSize ?? 16,
                  weight: FontWeight.w700,
                  color: textColor ?? plugBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomButtonWithIconRight extends StatelessWidget {
//   const CustomButtonWithIconRight({
//     Key? key,
//     this.title,
//     this.buttonColor,
//     this.textColor,
//     this.onPressed,
//     this.borderColor,
//     this.textSize,
//     this.showIcon = false,
//     this.icon,
//   }) : super(key: key);
//
//   final String? title;
//   final Color? buttonColor;
//   final Color? textColor;
//   final bool? showIcon;
//   final double? textSize;
//   final Color? borderColor;
//   final Widget? icon;
//
//   final Function()? onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56,
//       decoration: BoxDecoration(
//           color: buttonColor,
//           border: Border.all(color: borderColor ?? Zinarihelper.zeenahlightPrimary),
//           borderRadius: BorderRadius.circular(28)),
//       child: FlatButton(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         onPressed: onPressed,
//         child: Center(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Flexible(
//                 child: Text(
//                   title ?? '',
//                   style: TextStyle(
//                       fontFamily: "Helvetica Neue",
//
//                       fontSize: textSize ?? 18,
//                       fontWeight: FontWeight.bold,
//                       color: textColor),
//                 ),
//               ),
//               // SizedBox(width: ,)
//               Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     icon ?? SizedBox(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
