import '../../res/import/import.dart';

StatefulBuilder customCheck({
  bool isChecked = false,
  required String title,
}) {
  return StatefulBuilder(builder: (context, setState) {
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  //shape: BoxShape.circle,

                  ),
              child: isChecked
                  ? Image.asset('assets/images/check.png')
                  : Image.asset('assets/images/uncheck.png'),
            ),
            AppHorizontalSpacing.horizontalSpacingS,
            MyText(
              title: title,
              weight: FontWeight.w500,
              color: plugTextColor,
              size: 13,
            ),
          ],
        ),
      ),
    );
  });
}
