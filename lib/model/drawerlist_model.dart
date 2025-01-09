import '../res/import/import.dart';

class DrawerModel {
  final String image;
  final String title;
  final Widget route;
  DrawerModel({required this.image, required this.title, required this.route});
}

List drawerList = <DrawerModel>[
  DrawerModel(
      image: 'assets/images/dash_icon.png',
      title: 'Dashboard',
      route: DashBoard()),
  DrawerModel(
      image: 'assets/images/dash_icon2.png',
      title: 'Transactions',
      route: const TransactionScreen()),
  DrawerModel(
      image: 'assets/images/dash_icon3.png',
      title: 'Airtime',
      route: const Airtime()),
  DrawerModel(
      image: 'assets/images/dash_icon4.png',
      title: 'Data',
      route: const Data()),
  DrawerModel(
      image: 'assets/images/dash_icon5.png',
      title: 'Terminal',
      route: POS_Terminal()),
  DrawerModel(
      image: 'assets/images/dash_icon6.png',
      title: 'Settings',
      route: Settings()),
];
