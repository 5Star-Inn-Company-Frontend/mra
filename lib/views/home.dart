import 'package:flutter/material.dart';
import 'package:mra/constant/loader.dart';
import 'package:mra/views/Account/dashboard.dart';
import 'package:mra/views/Account/changeNotifiers/user_data_provider.dart';
// import 'package:mra/views/POS_Terminal/changeNotifier/terminalProvider.dart';
import 'package:mra/views/Transactions/changeNotifiers/transactions.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserDataProvider>().loadUserData(context);
      context.read<UserDataProvider>().loadWallet(context);
      context.read<TransactionsDataProvider>().loadTransactionData(context);
      // context.read<TerminalProvider>().loadTerminal(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserDataProvider>(context, listen: true);
    final transactions = Provider.of<TransactionsDataProvider>(context, listen: true);
    // final terminal = Provider.of<TerminalProvider>(context, listen: true);

    if (data.userData != null && data.walletData != null || transactions.transactionsData != null
        // terminal.terminalData != null
      ) {
      return DashBoard();
    } else {
      return const Scaffold(
        body: Loading(),
      );
    }
  }
}
