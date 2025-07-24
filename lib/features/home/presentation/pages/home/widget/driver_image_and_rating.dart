import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_network_image.dart';

import '../../../../../../export.dart';

class DriverImageAndRating extends StatelessWidget {
  const DriverImageAndRating({
    super.key,
    required this.isActive,
    this.showStatus = true,
  });

  final bool isActive;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCachedNetworkImage(
          imageUrl:
          'https://media.istockphoto.com/id/1437816897/photo/business-woman-manager-or-human-resources-portrait-for-career-success-company-we-are-hiring.jpg?s=612x612&w=0&k=20&c=tyLvtzutRh22j9GqSGI33Z4HpIwv9vL_MZw_xOE19NQ=',
          height: 50.r,
          width: 50.r,
          iconSize: 30.r,
          radius: BorderRadius.circular(100.r),
        ),
        10.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Xumoyunmirzo Y.",
              style: context.theme.textTheme.titleMedium?.copyWith(
                fontSize: 17.sp,
              ),
            ),
            Row(children: [SvgPicture.asset(AppIcons.star), Text("4.5")]),
          ],
        ),
        if(showStatus)...[
          Spacer(),
          SvgPicture.asset(
            AppIcons.status,
            colorFilter: AppColors.colorFilter(
              isActive ? AppColors.green : AppColors.yellow,
            ),
          ),
          6.horizontalSpace,
          Text(
            "Aktiv emas",
            style: AppTextStyles().body13w4.copyWith(
              color: isActive ? AppColors.green : AppColors.yellow,
            ),
          ),
        ],
      ],
    );
  }
}
