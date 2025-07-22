// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:video_player/video_player.dart';
// import '../../../core/utils/size_config.dart';
// import '../../../core/values/app_colors.dart';
// import '../../../core/values/app_assets.dart';
//
// class FullScreenVideoPlayer extends StatefulWidget {
//   final VideoPlayerController controller;
//
//   const FullScreenVideoPlayer({super.key, required this.controller});
//
//   @override
//   State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
// }
//
// class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = widget.controller;
//     _isPlaying = _controller.value.isPlaying;
//
//     // Lock orientation to landscape on entering full-screen
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//
//     // Hide system UI for immersive experience
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   }
//
//   @override
//   void dispose() {
//     // Revert orientation to portrait on exit
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//
//     // Restore system UI
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//     super.dispose();
//   }
//
//   void togglePlayPause() {
//     setState(() {
//       if (_controller.value.isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//       _isPlaying = _controller.value.isPlaying;
//     });
//   }
//
//   void rewind() {
//     final position = _controller.value.position;
//     _controller.seekTo(position - const Duration(seconds: 15));
//   }
//
//   void forward() {
//     final position = _controller.value.position;
//     _controller.seekTo(position + const Duration(seconds: 15));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         fit: StackFit.expand,
//         alignment: Alignment.center,
//         children: [
//           // Video Player
//           AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: VideoPlayer(_controller),
//           ),
//
//           // Gradient Overlay
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.black.withOpacity(0.3),
//                     Colors.transparent,
//                     Colors.black.withOpacity(0.1),
//                     Colors.black.withOpacity(0.7),
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//           ),
//
//           // Center Controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Rewind Button
//               _controlButton(
//                 icon: AppIcons.icBack15Second,
//                 onPressed: rewind,
//                   iconPadding: 8
//
//               ),
//               SizedBox(width: wi(16)),
//
//               // Play/Pause Button
//               _controlButton(
//                 icon: _isPlaying ? AppIcons.icPause : AppIcons.icPlay,
//                 onPressed: togglePlayPause,
//
//                 size: he(80),
//                 iconPadding: 24,
//               ),
//               SizedBox(width: wi(16)),
//
//               // Forward Button
//               _controlButton(
//                 icon: AppIcons.icNext15Second,
//                 onPressed: forward,
//                 iconPadding: 8
//               ),
//             ],
//           ),
//
//           // Back Button
//           Positioned(
//             top: he(40),
//             left: wi(30),
//             child:
//             _controlButton(icon:  AppIcons.icArrowLeft,
//                 size: 30,
//                 onPressed: (){
//               Navigator.pop(context);
//           })
//
//           ),
//
//           // Bottom Controls
//           Positioned(
//             bottom: he(50),
//             left: wi(30),
//             right: wi(30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 // Time Display
//                 Text(
//                   "${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}",
//                   style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                     color: AppColors.white,
//                   ),
//                 ),
//                 SizedBox(height: he(10)),
//
//                 // Video Progress Indicator
//                 VideoProgressIndicator(
//                   _controller,
//                   allowScrubbing: true,
//                   colors: const VideoProgressColors(
//                     playedColor: AppColors.white,
//                     bufferedColor: AppColors.grey3,
//                     backgroundColor: AppColors.primaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _controlButton({
//     required String icon,
//     required VoidCallback onPressed,
//     double size = 60,
//     double iconPadding = 10,
//   }) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         shape: const CircleBorder(),
//         padding: EdgeInsets.all(iconPadding + 10),
//         backgroundColor: AppColors.black.withOpacity(0.3),
//         elevation: 0,
//       ),
//       child: SvgPicture.asset(
//         icon,
//         width: wi(size * 0.3),
//         height: wi(size * 0.3),
//         colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
//       ),
//     );
//   }
//
//   String _formatDuration(Duration position) {
//     final minutes = position.inMinutes.remainder(60).toString().padLeft(2, '0');
//     final seconds = position.inSeconds.remainder(60).toString().padLeft(2, '0');
//     return "$minutes:$seconds";
//   }
// }
