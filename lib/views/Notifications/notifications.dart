import 'package:mra/constant/fonts.dart';
import 'package:mra/constant/text.dart';
import 'package:mra/utils/formatter.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Notifications/model/notifications.dart';
import 'package:mra/views/Notifications/service/notification_service.dart';

import '../../res/import/import.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  // NotificationsModel? notificationsData;

  late Future<NotificationsModel> futureNotifications;

  @override
  void initState() {
    super.initState();
    futureNotifications = loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(title: 'Notification '),
      body: FutureBuilder<NotificationsModel>(
        future: futureNotifications,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.data!.isEmpty) {
              return Center(
                child: TextBold(
                  'No Notification yet!',
                  fontSize: 20,
                  color: AppColors.plugPrimaryColor,
                ),
              );
            }
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: 'New',
                    weight: FontWeight.w500,
                    size: 20,
                    color: plugBlack,
                  ),
                  AppVerticalSpacing.verticalSpacingS,
                  ListView.builder(
                    itemCount: snapshot.data?.data?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final date = formatDateAndTime(
                          snapshot.data?.data?[index].createdAt.toString() ??
                              '');
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: customBbox(
                            height: 111,
                            radius: BorderRadius.circular(15),
                            color: Colors.white,
                            shadowcolor:
                                const Color.fromRGBO(77, 113, 121, 0.102).withOpacity(0.1),
                            widget: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                            title: date,
                                            weight: FontWeight.w500,
                                            size: 11,
                                            color: plugTetTextColor,
                                          ),
                                          AppVerticalSpacing.verticalSpacingB,
                                          Container(
                                            constraints: BoxConstraints(
                                                maxWidth:
                                                    screenWidth(context) * 0.7),
                                            child: Text(
                                              snapshot.data?.data?[index].data
                                                      ?.message
                                                      .toString() ??
                                                  '',
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: AppFonts.poppins),
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          AppVerticalSpacing.verticalSpacingB,
                                          MyText(
                                            title: snapshot.data?.data?[index]
                                                .data?.sender,
                                            maxLines: 1,
                                            weight: FontWeight.w500,
                                            size: 11,
                                            color: plugTetTextColor,
                                          ),
                                        ],
                                      ),
                                      customBbox(
                                        shapes: BoxShape.circle,
                                        height: 21,
                                        width: 21,
                                        borderColor: const Color(0xff56BE15),
                                        widget: const Icon(
                                          Icons.keyboard_arrow_up_sharp,
                                          color: Color(0xff56BE15),
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: Loading(),
          );
        },
      ),
    );
  }
}
