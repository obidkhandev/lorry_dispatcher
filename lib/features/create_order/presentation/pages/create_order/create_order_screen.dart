import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorry_dispatcher/export.dart';
import 'package:lorry_dispatcher/features/create_order/data/models/country_region_model.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/bloc/create_order_bloc.dart';
import 'package:lorry_dispatcher/features/create_order/presentation/pages/create_order/widget/location_list_section.dart';

class CreateOrderScreen extends StatelessWidget {
  const CreateOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Yuk qidirish"),
      body: BlocBuilder<CreateOrderBloc, CreateOrderState>(
        builder: (context, state) {
          final bloc = context.read<CreateOrderBloc>();
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            children: [
              LocationListSection(
                title: "pickup_address",
                locations: state.pickUpAddress,
                onRemoveLocation: (index) {

                  bloc.add(DeletePickupLocationEvent(index));
                },
                onAddLocation: () async {
                  bloc.add(
                    AddPickupLocationEvent(
                      CountryRegionModel(
                        name: 'random_!',
                        latLng: LatLng(0, 0),
                      ),
                    ),
                  );
                },
              ),
              20.verticalSpace,
              LocationListSection(
                title: "pickup_address",
                locations: state.dropOffAddress,
                onRemoveLocation: (index) {

                  bloc.add(DeleteDropoffLocationEvent(index));

                },
                onAddLocation: () async {
                  bloc.add(
                    AddDropoffLocationEvent(
                      CountryRegionModel(
                        name: 'random_!',
                        latLng: LatLng(0, 0),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
