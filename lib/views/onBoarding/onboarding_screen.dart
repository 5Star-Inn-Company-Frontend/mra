import 'package:mra/views/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/import/import.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  int selectedIndex = 0;

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      mobile: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  _controller.jumpToPage(2);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: MyText(
                    title: 'Skip',
                    weight: FontWeight.w400,
                    color: const Color(0xffcc0b1426),
                    size: 14,
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _controller,
                  onPageChanged: (index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                  itemBuilder: (context, i) {
                    var details = demoData[i];
                    return OnBoardingContent(
                      image: details.image.toString(),
                      title: details.title.toString(),
                      description: details.description.toString(),
                      description2: details.description2.toString(),
                      title2: details.title2.toString(),
                      subtitle: details.subtitle,
                      subtitle2: details.subtitle2,
                      subtitle3: details.subtitle3,
                      subtitle4: details.subtitle4,
                      subtitle5: details.subtitle5,
                      subtitle6: details.subtitle6,
                      subtitle7: details.subtitle7,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    axisDirection: Axis.horizontal,
                    controller: _controller,
                    count: 3,
                    effect: const ScrollingDotsEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      fixedCenter: true,
                      dotColor: Color(0xffDD4712),
                      activeDotColor: Color(0xffDD4712),
                    ),
                  ),
                  selectedIndex == 0 || selectedIndex == 1
                      ? InkWell(
                          onTap: () {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                          child: customBbox(
                            color: const Color(0xffDD4712),
                            width: 91,
                            height: 39,
                            radius: BorderRadius.circular(5),
                            widget: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MyText(
                                    title: 'NEXT',
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : selectedIndex == 2
                          ? GestureDetector(
                              onTap: () {
                                _storeOnboardInfo();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Wrapper()));
                              },
                              child: customBbox(
                                color: const Color(0xffDD4712),
                                width: 142,
                                height: 39,
                                radius: BorderRadius.circular(5),
                                widget: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MyText(
                                      title: 'Get Started',
                                      size: 16,
                                      color: Colors.white,
                                      weight: FontWeight.w500,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
