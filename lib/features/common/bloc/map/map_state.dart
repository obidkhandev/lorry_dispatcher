// import 'package:equatable/equatable.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';
//
// abstract class MapSelectCurrentLocationState extends Equatable{}
//
// class MapInitial extends MapSelectCurrentLocationState{
//   @override
//   List<Object?> get props => [];
// }
//
// class MapLoading extends MapSelectCurrentLocationState{
//
//   final Point? point;
//
//   MapLoading({this.point});
//
//   @override
//   List<Object?> get props => [
//     point,
//   ];
// }
//
// class MapSuccess extends MapSelectCurrentLocationState{
//   final String locationName;
//   final Point point;
//
//   MapSuccess(this.locationName, this.point);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//     locationName,
//     point,
//
//   ];
//
// }
//
// class MapError extends MapSelectCurrentLocationState{
//   final String errorText;
//
//   MapError(this.errorText);
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [
//     errorText,
//
//   ];
//
// }