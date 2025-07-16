const Map<int, String> regionNamesUz = {
  1: "Toshkent",
  2: "Namangan",
  3: "Farg'ona",
  4: "Andijon",
  5: "Buxoro",
  6: "Jizzax",
  7: "Xorazm",
  8: "Navoiy",
  9: "Qashqadaryo",
  10: "Qoraqalpog'iston",
  11: "Samarqand",
  12: "Sirdaryo",
  13: "Surxondaryo"
};

const Map<int, String> regionNamesRu = {
  1: "Тошкент",
  2: "Наманган",
  3: "Фарғона",
  4: "Андижон",
  5: "Бухоро",
  6: "Жиззах",
  7: "Хоразм",
  8: "Навоий",
  9: "Қашқадарё",
  10: "Қорақалпоғистон",
  11: "Самарқанд",
  12: "Сирдарё",
  13: "Сурхондарё"
};


String getRegionName(int regionId, String languageCode) {
  if (languageCode == 'ru') {
    return regionNamesRu[regionId] ?? 'Неизвестный регион';
  } else if (languageCode == 'uz') {
    return regionNamesUz[regionId] ?? 'Noma’lum mintaqa';
  } else if (languageCode == 'en') {
    return regionNamesRu[regionId] ?? 'Noma’lum mintaqa';
  } else {
    return 'Unknown region';
  }
}

Map<int, String> getRegions(String languageCode) {
  if (languageCode == 'ru') {
    return regionNamesRu;
  } else if (languageCode == 'uz') {
    return regionNamesUz;
  } else if (languageCode == 'en') {
    return regionNamesRu;
  } else {
    return regionNamesUz;
  }
}

int? findKeyByValue(String value) {
  return regionNamesUz.keys.firstWhere((k) => regionNamesUz[k] == value);
}
String? findValueByKey(int value) {
  return regionNamesUz.values.firstWhere((k) => regionNamesUz[value] == k);
}





var regionsExport = [
  {"id": 1, "name": "KAZAKHSTAN".toUpperCase()},
  {"id": 2, "name": "QIRG'IZISTON".toUpperCase()},
  {"id": 3, "name": "OZARBAYJON".toUpperCase()},
  {"id": 4, "name": "ROSSIYA".toUpperCase()},
  {"id": 5, "name": "BELARUS".toUpperCase()},
  {"id": 6, "name": "TURKIYA".toUpperCase()},
  {"id": 7, "name": "CHINA".toUpperCase()},
];
