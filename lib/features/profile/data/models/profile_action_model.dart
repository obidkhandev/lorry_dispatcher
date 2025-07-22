
import 'package:flutter/material.dart';

class ProfileActionModel {
  final Function()? onTap;
  final String? title, secondTitle, icon;
  final Color? icColor;
  final Widget? tralingWidget;

  ProfileActionModel({
    this.onTap,
    this.title,
    this.secondTitle,
    this.icon,
    this.icColor,
    this.tralingWidget,
  });
}
