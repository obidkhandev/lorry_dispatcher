import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;

import 'package:lorry_dispatcher/core/values/app_assets.dart';

class IDCardOverlay extends StatefulWidget {
  @override
  _IDCardOverlayState createState() => _IDCardOverlayState();
}

class _IDCardOverlayState extends State<IDCardOverlay>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _flipAnimation;
  bool _isShowingFront = true;

  // Your user data
  final String surname = "QODIROV";
  final String givenName = "ALISHER";
  final String patronymic = "SHAVKAT-O'G'LI";
  final String dateOfBirth = "12.08.2005";
  final String sex = "ERKAK";
  final String dateOfIssue = "22.07.2023";
  final String citizenship = "O'ZBEKISTON";
  final String dateOfExpiry = "22.07.2033";
  final String cardNumber = "BC1847392";
  final String personalNumber = "51208059870083";
  final String nationality = "O'ZBEK";
  final String placeOfBirth = "TOSHKENT";
  final String placeOfIssue = "IIV";

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isShowingFront) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      _isShowingFront = !_isShowingFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final isShowingFront = _flipAnimation.value < 0.5;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_flipAnimation.value * math.pi),
            child: isShowingFront
                ? IDCardFrontOverlay()
                : Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(math.pi),
              child: IDCardBackOverlay(),
            ),
          );
        },
      ),
    );
  }

  Widget IDCardFrontOverlay() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(AppImages.idCardFront),
                // AppImages.idCardFront
                fit: BoxFit.fill,
              ),
            ),
          ),

          Positioned(
            left: 130.w,
            top: 70.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surname,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Text(
                  givenName,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Text(
                  patronymic,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                5.verticalSpace,
                Text(
                  dateOfBirth,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Text(
                  dateOfIssue,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Text(
                  dateOfExpiry,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 145.h,
            right: 14.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  sex,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Text(
                  citizenship,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Text(
                  cardNumber,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget IDCardBackOverlay() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(AppImages.idCardBack), // AppImages.idCardBack
                fit: BoxFit.fill,
              ),
            ),
          ),

          Positioned(
            top: 50.h,
            left: 115.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  personalNumber,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Text(
                  nationality,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Text(
                  placeOfBirth,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Text(
                  placeOfIssue,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}