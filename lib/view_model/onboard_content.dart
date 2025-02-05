import '../res/import/import.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.title2,
    required this.description2,
    this.subtitle,
    this.subtitle2,
    this.subtitle3,
    this.subtitle4,
    this.subtitle5,
    this.subtitle6,
    this.subtitle7,
  });
  final String image, title, description, title2, description2;
  final String? subtitle;
  final String? subtitle2;
  final String? subtitle3;
  final String? subtitle4;
  final String? subtitle5;
  final String? subtitle6;
  final String? subtitle7;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: MyText(
            title: title2,
            color: Color(0xff0B1426),
            weight: FontWeight.w700,
            size: 24,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        RichText(
          text: TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: GoogleFonts.poppins(
              wordSpacing: 5,
              fontSize: 20.0,
              color: Color(0xffCC0B1426),
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
              TextSpan(text: description2),
              TextSpan(
                text: subtitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: subtitle2),
              TextSpan(
                text: subtitle3,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: subtitle4),
              TextSpan(
                text: subtitle5,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: subtitle6),
            ],
          ),
        ),
        Container(
          height: 342,
          width: double.infinity,
          foregroundDecoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
            ),
          ),
        ),
        MyText(
          title: title,
          color: Color(0xff0B1426),
          weight: FontWeight.w700,
          size: 20,
          align: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        RichText(
          text: TextSpan(
            // Note: Styles for TextSpans must be explicitly defined.
            // Child text spans will inherit styles from parent
            style: const TextStyle(
              fontSize: 20.0,
              color: Color(0xffCC0B1426),
            ),
            children: <TextSpan>[
              TextSpan(text: description),
              TextSpan(
                  text: subtitle7,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
