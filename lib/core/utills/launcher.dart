import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void launchPhone(String phone) async {
    final phoneNumber = 'tel:$phone';

    await launch(phoneNumber);
  }


   static Future<void> launchSms(String sms) async {
    final Uri uri = Uri(scheme: 'sms', path: sms);

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch SMS for $sms';
    }
  }
  static void launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'example@example.com',
      query: 'subject=Hello&body=Hello%20World',
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Could not launch $emailUri';
    }
  }

  static void launchMaps() async {
    const mapUrl =
        'https://www.google.com/maps/search/?api=1&query=1600+Amphitheatre+Parkway,+Mountain+View,+California';
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw 'Could not launch $mapUrl';
    }
  }


  static lauchMapOnIOS(
      BuildContext context, double latitude, double longitude) async {
    try {
      final url = Uri.parse('maps:$latitude,$longitude?q=$latitude,$longitude');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      if (context.mounted) {
        // Util.showErrorDialog(context: context, error: error.toString());
      }
    }
  }

  static launchMapOnAndroid(
      BuildContext context, double latitude, double longitude) async {
    try {
      const String markerLabel = 'Here';
      final url = Uri.parse(
          'geo:$latitude,$longitude?q=$latitude,$longitude($markerLabel)');
      await launchUrl(url);
    } catch (error) {
      if (context.mounted) {
        // Util.showErrorDialog(context: context, error: error.toString());
      }
    }
  }
}
