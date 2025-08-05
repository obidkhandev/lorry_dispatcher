import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/core/routes/app_routes.dart';
import 'package:lorry_dispatcher/core/utills/helper_widget.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/common/widget/drop_down_widget.dart';
import 'package:lorry_dispatcher/features/common/widget/text_field_widget.dart';
import 'package:lorry_dispatcher/features/create_order/data/models/country_region_model.dart';
import 'package:lorry_dispatcher/features/create_order/data/models/location_item_model.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/create_order_bloc.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/pages/create_order/widget/location_list_section.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButton(
        text: "Yaratish",
        height: 50.h,
      ).paddingOnly(bottom: customButtonPadding.h, left: 16.w, right: 16.w),
      appBar: CustomAppBar(title: "Yuk yaratish"),
      body: BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, state) {
          final bloc = context.read<CreateOrderBloc>();
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            children: [
              LocationListSection(
                title: "Yuklash manzili",
                locations: state.pickUpAddress,
                onRemoveLocation: (index) {
                  bloc.add(DeletePickupLocationEvent(index));
                },
                onAddLocation: () async {
                  context.push(AppRoutes.selectLocationScreen).then((e) {
                    if (e != null) {
                      e as LocationItemModel;
                      bloc.add(
                        AddPickupLocationEvent(
                          CountryRegionModel(
                            name: e.title,
                            latLng: Point(
                              latitude: e.latitude,
                              longitude: e.longitude,
                            ),
                          ),
                        ),
                      );
                    }
                  });
                },
              ),
              20.verticalSpace,
              LocationListSection(
                title: "Tushirish manzili",
                locations: state.dropOffAddress,
                onRemoveLocation: (index) {
                  bloc.add(DeleteDropoffLocationEvent(index));
                },
                onAddLocation: () async {
                  context.push(AppRoutes.selectLocationScreen).then((e) {
                    if (e != null) {
                      e as LocationItemModel;
                      bloc.add(
                        AddDropoffLocationEvent(
                          CountryRegionModel(
                            name: e.title,
                            latLng: Point(
                              latitude: e.latitude,
                              longitude: e.longitude,
                            ),
                          ),
                        ),
                      );
                    }
                  });
                },
              ),
              16.verticalSpace,
              CustomDropDownWidget(
                // height: 60.h,
                hintText: "Avtomobil turi",
                enableSearch: false,
                items: ["Fura", "Isuzu"],
              ),
              16.verticalSpace,
              CustomDropDownWidget(
                // height: 60.h,
                enableSearch: false,
                hintText: "Tirkama turi",
                items: ["Tent"],
              ),
              16.verticalSpace,
              CustomDropDownWidget(
                // height: 60.h,
                enableSearch: false,
                hintText: "To'lov turi",
                items: ["So'm", "Usd", "Rubl"],
              ),
              16.verticalSpace,
              CustomTextField(
                borderColor: context.isDarkMode
                    ? AppColors.grey808080
                    : AppColors.grey2,
                // contentPadding: EdgeInsets.symmetric(
                //   vertical: 18.h,
                //   horizontal: 12.w,
                // ),
                hintText: "To’lov summasi",
              ),
              16.verticalSpace,
              CustomTextField(
                borderColor: context.isDarkMode
                    ? AppColors.grey808080
                    : AppColors.grey2,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 12.w,
                ),
                hintText: "Qo’shimcha ma’lumot",
                maxLines: 3,
                minLines: 3,
              ),
              30.verticalSpace,

              // Spacer(),
            ],
          );
        },
      ),
    );
  }
}
