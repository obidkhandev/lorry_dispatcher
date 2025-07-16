import 'dart:convert';

import 'package:crypto/crypto.dart';

class MyFunction{
  static String sha1Hash(String text) {
    // UTF-8 orqali matnni baytlarga o'zgartirish
    final List<int> bytes = utf8.encode(text);

    // SHA-1 hashni hisoblash
    final Digest sha1Hash = sha1.convert(bytes);

    // Natijani o'n oltilik (hexadecimal) satrga aylantirish
    return sha1Hash.toString();
  }


  static Map<String, String> generateToken(String secretKey) {
    final int timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final String keyData = '$timestamp$secretKey';

    // Generate SHA256 hash
    final List<int> bytes = utf8.encode(keyData);
    final Digest sha256Hash = sha256.convert(bytes);

    return {
      "keyData": keyData,
      "timeStamp": timestamp.toString(),
      "sha256": sha256Hash.toString()
    };
  }
}