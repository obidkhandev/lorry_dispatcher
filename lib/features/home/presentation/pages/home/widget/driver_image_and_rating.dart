import 'package:lorry_dispatcher/core/utills/general_functions.dart';
import 'package:lorry_dispatcher/core/values/app_text_sytle.dart';
import 'package:lorry_dispatcher/features/common/widget/custom_network_image.dart';

import '../../../../../../export.dart';

class DriverImageAndRating extends StatelessWidget {
  const DriverImageAndRating({
    super.key,
     this.isActive = true,
    this.showStatus = true,
    this.onTap,
  });

  final bool isActive;
  final bool showStatus;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
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
              Row(
                children: [
                  GestureDetector(
                    onTap: ()async {
                      await MyFunctions.dialPhoneNumber("+998942665030");
                    },
                    child: Text(
                      "+998942665030",
                      style: context.theme.textTheme.titleMedium?.copyWith(
                        fontSize: 14.sp,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  20.horizontalSpace,
                  SvgPicture.asset(AppIcons.star,width: 16),
                  2.horizontalSpace,
                  Text("4.5",style: context.theme.textTheme.titleSmall?.copyWith(
                    fontSize: 14,
                  ),),
                ],
              ),
            ],
          ),
          if (showStatus) ...[
            Spacer(),
            SvgPicture.asset(
              AppIcons.status,
              colorFilter: AppColors.colorFilter(
                isActive ? AppColors.green : AppColors.yellow,
              ),
            ),
            6.horizontalSpace,
            Text(
              isActive? S.of(context).active :  S.of(context).isNoActive,
              style: AppTextStyles().body13w4.copyWith(
                color: isActive ? AppColors.green : AppColors.yellow,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
