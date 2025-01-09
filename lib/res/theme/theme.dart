// import '../import/import.dart';
//
// class Rentahelper {
//   Rentahelper._();
//
//
//
//
//   /// background color
//
//   //Reusable Colors
//   static Color grey = Color(0xFF999999);
//
//   //Reusable Spacers
//   static const kPaddingS = 8.0;
//   static const kPaddingM = 16.0;
//   static const kPaddingL = 32.0;
//
// /// toggled theme data
// //   static ThemeData themeData(bool isDarkTheme, BuildContext context) {
// //     return ThemeData(
// //       // primarySwatch: Colors.red,
// //       primaryColor: isDarkTheme ? RentaPrimaryColor : RentaPrimaryColor,
// //
// //       backgroundColor: isDarkTheme ? zeenahdarkbackgroundcolor : zeenahdarkbackgroundcolor,
// //       fontFamily: 'HelveticaNeue',
// //       // indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
// //       // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
// //       //
// //       // hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
// //       //
// //       // highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
// //       // hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
// //       //
// //       // focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
// //       // disabledColor: Colors.grey,
// //       // textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
// //       // cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
// //       // canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
// //       // brightness: isDarkTheme ? Brightness.dark : Brightness.light,
// //       // buttonTheme: Theme.of(context).buttonTheme.copyWith(
// //       //     colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
// //       // appBarTheme: AppBarTheme(
// //       //   elevation: 0.0,
// //       // ),
// //     );
// //
// //   }
//
//   ///Light Theme
//   static ThemeData lightTheme() {
//     final base = ThemeData.light();
//     return ThemeData(
//       primaryColor: RentaPrimaryColor,
//       appBarTheme: AppBarTheme(
//         iconTheme: IconThemeData(color: Colors.white),
//         color: Color(0xFF211048),
//         textTheme: TextTheme(
//           headline6: TextStyle(
//             fontSize: 28.0,
//             color: RentaTextColor,
//           ),
//         ),
//       ),
//       brightness: Brightness.light,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//       scaffoldBackgroundColor: RentaBackgroundColor,
//       primarySwatch: Colors.blue,
//       textTheme: _buildTextTheme(base.textTheme),
//     );
//   }
//
//   ///Dark Theme
//   static ThemeData darkTheme() {
//     final base = ThemeData.light();
//     return ThemeData(
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//       appBarTheme: const AppBarTheme(
//           brightness: Brightness.dark, elevation: 0, color: Colors.transparent),
//       scaffoldBackgroundColor: RentaBackgroundColor,
//       backgroundColor: RentaBackgroundColor,
//       textTheme: _buildTextTheme(base.textTheme),
//     );
//   }
//
//   ///Text Theme
//   static TextTheme _buildTextTheme(TextTheme base) {
//     return base.copyWith(
//       bodyText2: TextStyle(
//           fontFamily: "Helvetica Neue",
//           fontWeight: FontWeight.normal,
//           color: Colors.black,
//           fontSize: 12.0),
//       bodyText1: TextStyle(
//         fontFamily: "Helvetica Neue",
//         fontWeight: FontWeight.normal,
//         fontSize: 14.0,
//         color: Colors.black,
//       ),
//       button: TextStyle(
//         fontFamily: "Helvetica Neue",
//         fontWeight: FontWeight.normal,
//         fontSize: 17,
//         color: Colors.white,
//       ),
//       headline5: TextStyle(
//         fontFamily: "Helvetica Neue",
//         fontWeight: FontWeight.normal,
//         color: Colors.black,
//         fontSize: 18.0,
//       ),
//       headline6: TextStyle(
//         fontFamily: "Helvetica Neue",
//         fontWeight: FontWeight.normal,
//         color: Colors.black,
//         fontSize: 16.0,
//       ),
//       headline1: TextStyle(
//         fontWeight: FontWeight.w600,
//         fontSize: 18.0,
//         fontFamily: "Helvetica Neue",
//         color: Colors.black,
//       ),
//       caption: TextStyle(
//         fontFamily: "Helvetica Neue",
//         fontWeight: FontWeight.w400,
//         fontSize: 13.0,
//         color: Color(0xff7C809E),
//       ),
//     );
//   }
//
//   /// A constant that is true if the application was compiled to run on the web.
//   ///
//   /// This implementation takes advantage of the fact that JavaScript does not
//   /// support integers. In this environment, Dart's doubles and ints are
//   /// backed by the same kind of object. Thus a double `0.0` is identical
//   /// to an integer `0`. This is not true for Dart code running in AOT or on the
//   /// VM.
//   static final bool kIsWeb = identical(0, 0.0);
//
//   /// Using letter spacing in Flutter for Web can cause a performance drop,
//   /// see https://github.com/flutter/flutter/issues/51234.
//   static double letterSpacingOrNone(double letterSpacing) =>
//       kIsWeb ? 0.0 : letterSpacing;
// }
//
// BoxShadow kDropShadow(double dx, double dy, double blurRadius,
//         {color = Colors.grey}) =>
//     BoxShadow(
//       offset: Offset(dx, dy),
//       blurRadius: blurRadius,
//       color: color,
//     );
