import 'package:mra/res/import/import.dart';
// import 'package:mra/views/Transfer/pages/default_page.dart';

class GridModel {
  final String image;
  final String title;
  final String route;

  GridModel({
    required this.image,
    required this.title,
    required this.route,
  });
}

List gridItems = <GridModel>[
  GridModel(
    image: 'assets/images/airtime.png',
    title: 'Airtime',
    route: Routes.airtime
  ),
  GridModel(
    image: 'assets/images/data.png',
    title: 'Data', route: Routes.data
  ),
  // GridModel(
  //     image: 'assets/images/transact.png',
  //     title: 'Transfer',
  //     route: const DefaultPage(),
  //   ),
  GridModel(
    image: 'assets/images/bulb.png',
    title: 'Electricity',
    route: Routes.electricity
  ), 
  GridModel(
    image: 'assets/images/cable.png', 
    title: 'Cable TV', route: Routes.cableTv
  ),
// GridModel(
  //     image: 'assets/images/pos.png',
  //     title: 'POS/ Terminal',
  //     route: POS_Terminal()),
];
