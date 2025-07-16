import 'dart:ui';

class SelectServiceModel {
  final String? icon;
  final String? title;
  final String? subtitle;
  final bool? isSelected ;
  final Color? bgColor;
  final Function()? onTap;

  SelectServiceModel({
     this.icon,
     this.title,
     this.subtitle,
     this.isSelected = false,
    this.bgColor,
    this.onTap,
  });
}
