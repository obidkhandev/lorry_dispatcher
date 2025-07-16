import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension DateFormatter on String {
  String formatDate() {
    DateTime dateTime = DateTime.parse(this).toLocal();
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    String output = dateFormat.format(dateTime);
    return output;
  }

  String formatDateFiler() {
    // if(this != null)
    DateTime dateTime = DateTime.parse(this).toLocal();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String output = dateFormat.format(dateTime);
    return output;
  }

  String formatTime() {
    DateTime dateTime = DateTime.parse(this).toLocal();
    DateFormat dateFormat = DateFormat("HH:mm");
    String output = dateFormat.format(dateTime
        .add(Duration(hours: int.tryParse(DateTime.now().timeZoneName) ?? 0)));
    return output;
  }

  String formatDateAndTime() {
    DateTime dateTime = DateTime.parse(this).toLocal();
    DateFormat dateFormat = DateFormat("yyyy.MM.dd HH:mm");
    String output = dateFormat.format(dateTime
        .add(Duration(hours: int.tryParse(DateTime.now().timeZoneName) ?? 0)));
    return output;
  }
}

String buildLoadFilterUrl({
  required int page,
  required int size,
  int? fromPlace,
  int? toPlace,
  int? transportId,
  String? loadingDate,
  num? fromPrice,
  num? toPrice,
}) {
  final queryParams = <String, dynamic>{
    'page': '$page',
    'size': '$size',
    if (fromPlace != null) 'from_place': fromPlace,
    if (toPlace != null) 'to_place': toPlace,
    if (transportId != null) 'transport_model': transportId,
    if (loadingDate != null) 'loading_date': loadingDate,
    if (fromPrice != null) 'from_price': '$fromPrice',
    if (toPrice != null) 'to_price': '$toPrice',
  };

  final queryString = queryParams.entries
      .where((entry) => entry.value != null)
      .map((entry) =>
          '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
      .join('&');

  return '/load/?$queryString';
}

String formatDateMMMMd(String dateTime, String languageCode) {
  DateTime parsedDate = DateTime.parse(dateTime);
  DateTime now = DateTime.now();

  var monthDayFormat = DateFormat('MMMM d', languageCode);
  var yearFormat = DateFormat('y', languageCode);

  String formattedDate = monthDayFormat.format(parsedDate);

  formattedDate = formattedDate.replaceFirst(
      formattedDate[0], formattedDate[0].toUpperCase());

  if (parsedDate.year != now.year) {
    String formattedYear = yearFormat.format(parsedDate);
    formattedDate = '$formattedDate, $formattedYear';
  }

  // Форматирование даты
  return formattedDate;
}

// extension WidgetShimmer on Widget {
//   Widget toShimmer({Color? color}) {
//     return Shimmer.fromColors(
//         baseColor: color ?? AppColors.grayLight,
//         highlightColor:
//             color?.withOpacity(.7) ?? AppColors.grayLight.withOpacity(.7),
//         child: this);
//   }
// }
//
// extension WidgetShimmer2 on Widget {
//   Widget toShimmer2({Color? color, bool? progress}) {
//     if (progress ?? false) {
//       return Shimmer.fromColors(
//           baseColor: color ?? AppColors.grayLight,
//           highlightColor:
//               color?.withOpacity(.7) ?? AppColors.grayLight.withOpacity(.7),
//           child: this);
//     } else {
//       return this;
//     }
//   }
// }
