import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/home/presentation/pages/about_driver/widget/comment_item_card.dart';

class AboutDriverScreen extends StatelessWidget {
  const AboutDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButton(text: "Tasdiqlash")
          .paddingSymmetric(horizontal: 16.w)
          .paddingOnly(bottom: customButtonPadding),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: SvgPicture.asset(AppIcons.arrowLeft, width: 30),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 60.r,
                  backgroundImage: NetworkImage(
                    "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                SizedBox(width: 50.r),
                Spacer(),
              ],
            ),
          ),
          10.verticalSpace,
          Center(
            child: Text(
              "Po‘latov Jasurbek",
              style: context.theme.textTheme.titleLarge,
            ),
          ),
          30.verticalSpace,
          Text("Fikrlar", style: context.theme.textTheme.titleMedium),
          16.verticalSpace,
          CommentItemCard(),
        ],
      ).paddingSymmetric(horizontal: 16.w).paddingOnly(top: 20.h),
    );
  }
}
