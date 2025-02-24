import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Account/pages/Referrals/model/referral_model.dart';
import '../../../../res/import/import.dart';

class Referrals extends StatelessWidget {
  const Referrals({super.key});

Future<ReferralModel?> loadReferralsList() async {
  final token = await const FlutterSecureStorage().read(key: 'token');
  print(token);
  try {
    final response = await ApiService.dio.get(
      '/referrals-list',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Referrals list: ${response.data}');
      return ReferralModel.fromJson(response.data);
    }
  } on DioException catch (e) {
    if (DioExceptionType.badResponse == e.type) {
      throw Exception('Unable to fetch referrals list');
    }
    if (DioExceptionType.connectionError == e.type ||
        DioExceptionType.connectionTimeout == e.type ||
        DioExceptionType.receiveTimeout == e.type ||
        DioExceptionType.sendTimeout == e.type) {
      throw Exception('Unable to make requests, try again');
    }
  }

  return null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PlugAppBarTwo(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                title: 'Referral Link',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),

              AppVerticalSpacing.verticalSpacingD,
              customBbox(
                borderColor: AppColors.plugPrimaryColor,
                radius: BorderRadius.circular(8),
                widget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: HomeScreenCustomTextFormField(
                          obscureText: false,
                          readonly: false,
                          textInputAction: TextInputAction.next,
                          color: Colors.transparent,
                        ),
                      ),
                      customBbox(
                        width: 52,
                        height: 24,
                        radius: BorderRadius.circular(24),
                        widget: Center(
                          child: MyText(
                            title: 'Share',
                            weight: FontWeight.w400,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                        gradient: gradient2,
                      )
                    ],
                  ),
                ),
              ),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Referral Code',
                color: Color(0xff797878),
                weight: FontWeight.w400,
                size: 14,
              ),

              AppVerticalSpacing.verticalSpacingD,
              customBbox(
                borderColor: AppColors.plugPrimaryColor,
                radius: BorderRadius.circular(8),
                widget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text('1', style: GoogleFonts.poppins(fontSize: 12.sp),)
                      ),
                      customBbox(
                        width: 52,
                        height: 24,
                        radius: BorderRadius.circular(24),
                        widget: Center(
                          child: MyText(
                            title: 'Share',
                            weight: FontWeight.w400,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                        gradient: gradient2,
                      )
                    ],
                  ),
                ),
              ),

              AppVerticalSpacing.verticalSpacingN,
              MyText(
                title: 'Referral List',
                color: plugTetTextColor,
                weight: FontWeight.w600,
                size: 24,
              ),

              AppVerticalSpacing.verticalSpacingD,
              FutureBuilder<ReferralModel?>(
                future: loadReferralsList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final referrals = snapshot.data?.data ?? [];
                    if (referrals.isEmpty) {
                      return Center(child: Text('No referrals found.'));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: referrals.length,
                      itemBuilder: (context, index) {
                        final referral = referrals[index];
                        return ListTile(
                          title: Text('Referral ${index + 1}', style: GoogleFonts.poppins(fontSize: 13.5.sp),),
                          subtitle: Text(
                            'Name: ${referral.firstname} ${referral.lastname}\n'
                            'Phone: ${referral.phone}',
                            style: GoogleFonts.poppins(fontSize: 11.5.sp),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: Text('No data available.'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
