import 'package:mra/res/import/import.dart';

class GridModel {
  final String image;
  final String title;
  final Widget route;

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
      route: const Airtime()),
  GridModel(
      image: 'assets/images/transact.png',
      title: 'Transfer',
      route: const DashBoard()
    ),
  GridModel(
      image: 'assets/images/bulb.png',
      title: 'Electricity',
      route: Electricity()),
  GridModel(
      image: 'assets/images/data.png', 
      title: 'Data', route: const Data()),
  GridModel(
      image: 'assets/images/cable.png', 
      title: 'Cable TV', route: CableTv()),
  GridModel(
      image: 'assets/images/pos.png',
      title: 'POS/ Terminal',
      route: POS_Terminal()),
];
