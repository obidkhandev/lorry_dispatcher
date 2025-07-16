import 'package:flutter/material.dart';
import 'package:lorry_dispatcher/core/values/app_colors.dart';

import '../resources/global_variables.dart' show rootNavigatorKey;

String elon =
    "https://www.gipr.uz/files/01-2024/ad20104/bannierlarda-rieklama-riek-1305947804_large.webp";
String news =
    "https://static.1tv.ru/uploads/video/material/splash/2024/11/12/913099/_original/913099_2fa85cecc2.jpg";
String elon1 =
    'https://nurobod.takm.uz/media/k2/items/cache/0a47a31ecf1649c40be3821bbc214aed_L.jpg';

final double customButtonPadding =
    MediaQuery.of(rootNavigatorKey.currentState!.context).padding.bottom + 20;
final double customBarPadding =
    MediaQuery.of(rootNavigatorKey.currentState!.context).padding.top;
Widget customDivider =
    Divider(color: AppColors.secondary, thickness: 1.5, height: 0);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
    // Divider(color: AppColors().secondaryColor, thickness: 1.5, height: 0);

