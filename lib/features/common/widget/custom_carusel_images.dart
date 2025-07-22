// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// class CustomCarouselImages extends StatefulWidget {
//   final List<BuildingImageModel> imageUrls;
//   final bool autoPlay;
//   final BorderRadius? radius;
//
//   const CustomCarouselImages({
//     super.key,
//     required this.imageUrls,
//     this.autoPlay = true,
//     this.radius,
//   });
//
//   @override
//   State<CustomCarouselImages> createState() => _CustomCarouselImagesState();
// }
//
// class _CustomCarouselImagesState extends State<CustomCarouselImages> {
//   final CarouselSliderController _controller = CarouselSliderController();
//   int _current = 0;
//   @override
//   Widget build(BuildContext context) {
//     debugPrint("Hello carousel--- ${widget.imageUrls.length}");
//
//     return Stack(
//       alignment: Alignment.topCenter,
//       children: [
//         CarouselSlider(
//           carouselController: _controller,
//           options: CarouselOptions(
//             height: he(280),
//             viewportFraction: 1.0,
//             enableInfiniteScroll: false,
//             reverse: false,
//             initialPage: 0,
//             autoPlay: widget.autoPlay,
//             autoPlayInterval: const Duration(seconds: 3),
//             autoPlayAnimationDuration: const Duration(milliseconds: 1000),
//             onPageChanged: (index, reason) => setState(() => _current = index),
//           ),
//           items: widget.imageUrls.map((imageUrl) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return CustomCachedNetworkImage(
//                   // imageUrl: imageUrl.imageLink,
//                   imageUrl: '',
//                   height: he(280),
//                   width: context.w,
//                   radius: widget.radius ?? BorderRadius.circular(0),
//                   fit: BoxFit.cover,
//                 );
//               },
//             );
//           }).toList(),
//         ),
//         Positioned(
//           bottom: 10,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: widget.imageUrls.asMap().entries.map((entry) {
//               return Container(
//                 width: _current == entry.key ? 10 : 7,
//                 height: _current == entry.key ? 10 : 7,
//                 margin:
//                     const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _current == entry.key
//                       ? AppColors.primaryColor
//                       : Colors.white,
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }
