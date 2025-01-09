import 'package:mra/constant/text.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/POS_Terminal/changeNotifier/terminalProvider.dart';
import 'package:provider/provider.dart';

import '../../res/import/import.dart';

class POS_Terminal extends StatelessWidget {
  POS_Terminal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final terminals = Provider.of<TerminalProvider>(context, listen: true);
    return ResponsiveScreen(
      mobile: Scaffold(
        appBar: const PlugAppBarTwo(title: 'POS'),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Column(
            children: [
              Visibility(
                  visible:
                      terminals.terminalData!.datas!.isEmpty ? true : false,
                  child: TextSemiBold(
                    "No Pos Terminal service!",
                    fontSize: 20,
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: terminals.terminalData?.datas?.length,
                  itemBuilder: (ctx, index) => MyText(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TERMINAL(
                              id: terminals.terminalData?.datas?[index].id,
                              barTitle: terminals
                                      .terminalData?.datas?[index].terminalId
                                      .toString() ??
                                  ''),
                        ),
                      );
                    },
                    title: terminals.terminalData?.datas?[index].terminalId,
                    fonts: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: plugTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
