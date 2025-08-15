// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 bool get authenticated; int? get retryAfter; Failure? get getOtpFailure; Failure? get loginFailure; Failure? get registerFailure; Status get getOtpSt; Status get loginSt; Status get registerSt; Status get checkAuthSt;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.authenticated, authenticated) || other.authenticated == authenticated)&&(identical(other.retryAfter, retryAfter) || other.retryAfter == retryAfter)&&(identical(other.getOtpFailure, getOtpFailure) || other.getOtpFailure == getOtpFailure)&&(identical(other.loginFailure, loginFailure) || other.loginFailure == loginFailure)&&(identical(other.registerFailure, registerFailure) || other.registerFailure == registerFailure)&&(identical(other.getOtpSt, getOtpSt) || other.getOtpSt == getOtpSt)&&(identical(other.loginSt, loginSt) || other.loginSt == loginSt)&&(identical(other.registerSt, registerSt) || other.registerSt == registerSt)&&(identical(other.checkAuthSt, checkAuthSt) || other.checkAuthSt == checkAuthSt));
}


@override
int get hashCode => Object.hash(runtimeType,authenticated,retryAfter,getOtpFailure,loginFailure,registerFailure,getOtpSt,loginSt,registerSt,checkAuthSt);

@override
String toString() {
  return 'AuthState(authenticated: $authenticated, retryAfter: $retryAfter, getOtpFailure: $getOtpFailure, loginFailure: $loginFailure, registerFailure: $registerFailure, getOtpSt: $getOtpSt, loginSt: $loginSt, registerSt: $registerSt, checkAuthSt: $checkAuthSt)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 bool authenticated, int? retryAfter, Failure? getOtpFailure, Failure? loginFailure, Failure? registerFailure, Status getOtpSt, Status loginSt, Status registerSt, Status checkAuthSt
});




}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authenticated = null,Object? retryAfter = freezed,Object? getOtpFailure = freezed,Object? loginFailure = freezed,Object? registerFailure = freezed,Object? getOtpSt = null,Object? loginSt = null,Object? registerSt = null,Object? checkAuthSt = null,}) {
  return _then(_self.copyWith(
authenticated: null == authenticated ? _self.authenticated : authenticated // ignore: cast_nullable_to_non_nullable
as bool,retryAfter: freezed == retryAfter ? _self.retryAfter : retryAfter // ignore: cast_nullable_to_non_nullable
as int?,getOtpFailure: freezed == getOtpFailure ? _self.getOtpFailure : getOtpFailure // ignore: cast_nullable_to_non_nullable
as Failure?,loginFailure: freezed == loginFailure ? _self.loginFailure : loginFailure // ignore: cast_nullable_to_non_nullable
as Failure?,registerFailure: freezed == registerFailure ? _self.registerFailure : registerFailure // ignore: cast_nullable_to_non_nullable
as Failure?,getOtpSt: null == getOtpSt ? _self.getOtpSt : getOtpSt // ignore: cast_nullable_to_non_nullable
as Status,loginSt: null == loginSt ? _self.loginSt : loginSt // ignore: cast_nullable_to_non_nullable
as Status,registerSt: null == registerSt ? _self.registerSt : registerSt // ignore: cast_nullable_to_non_nullable
as Status,checkAuthSt: null == checkAuthSt ? _self.checkAuthSt : checkAuthSt // ignore: cast_nullable_to_non_nullable
as Status,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool authenticated,  int? retryAfter,  Failure? getOtpFailure,  Failure? loginFailure,  Failure? registerFailure,  Status getOtpSt,  Status loginSt,  Status registerSt,  Status checkAuthSt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.authenticated,_that.retryAfter,_that.getOtpFailure,_that.loginFailure,_that.registerFailure,_that.getOtpSt,_that.loginSt,_that.registerSt,_that.checkAuthSt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool authenticated,  int? retryAfter,  Failure? getOtpFailure,  Failure? loginFailure,  Failure? registerFailure,  Status getOtpSt,  Status loginSt,  Status registerSt,  Status checkAuthSt)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.authenticated,_that.retryAfter,_that.getOtpFailure,_that.loginFailure,_that.registerFailure,_that.getOtpSt,_that.loginSt,_that.registerSt,_that.checkAuthSt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool authenticated,  int? retryAfter,  Failure? getOtpFailure,  Failure? loginFailure,  Failure? registerFailure,  Status getOtpSt,  Status loginSt,  Status registerSt,  Status checkAuthSt)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.authenticated,_that.retryAfter,_that.getOtpFailure,_that.loginFailure,_that.registerFailure,_that.getOtpSt,_that.loginSt,_that.registerSt,_that.checkAuthSt);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.authenticated = false, this.retryAfter, this.getOtpFailure = const UnknownFailure(), this.loginFailure = const UnknownFailure(), this.registerFailure = const UnknownFailure(), this.getOtpSt = Status.UNKNOWN, this.loginSt = Status.UNKNOWN, this.registerSt = Status.UNKNOWN, this.checkAuthSt = Status.UNKNOWN});
  

@override@JsonKey() final  bool authenticated;
@override final  int? retryAfter;
@override@JsonKey() final  Failure? getOtpFailure;
@override@JsonKey() final  Failure? loginFailure;
@override@JsonKey() final  Failure? registerFailure;
@override@JsonKey() final  Status getOtpSt;
@override@JsonKey() final  Status loginSt;
@override@JsonKey() final  Status registerSt;
@override@JsonKey() final  Status checkAuthSt;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.authenticated, authenticated) || other.authenticated == authenticated)&&(identical(other.retryAfter, retryAfter) || other.retryAfter == retryAfter)&&(identical(other.getOtpFailure, getOtpFailure) || other.getOtpFailure == getOtpFailure)&&(identical(other.loginFailure, loginFailure) || other.loginFailure == loginFailure)&&(identical(other.registerFailure, registerFailure) || other.registerFailure == registerFailure)&&(identical(other.getOtpSt, getOtpSt) || other.getOtpSt == getOtpSt)&&(identical(other.loginSt, loginSt) || other.loginSt == loginSt)&&(identical(other.registerSt, registerSt) || other.registerSt == registerSt)&&(identical(other.checkAuthSt, checkAuthSt) || other.checkAuthSt == checkAuthSt));
}


@override
int get hashCode => Object.hash(runtimeType,authenticated,retryAfter,getOtpFailure,loginFailure,registerFailure,getOtpSt,loginSt,registerSt,checkAuthSt);

@override
String toString() {
  return 'AuthState(authenticated: $authenticated, retryAfter: $retryAfter, getOtpFailure: $getOtpFailure, loginFailure: $loginFailure, registerFailure: $registerFailure, getOtpSt: $getOtpSt, loginSt: $loginSt, registerSt: $registerSt, checkAuthSt: $checkAuthSt)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 bool authenticated, int? retryAfter, Failure? getOtpFailure, Failure? loginFailure, Failure? registerFailure, Status getOtpSt, Status loginSt, Status registerSt, Status checkAuthSt
});




}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authenticated = null,Object? retryAfter = freezed,Object? getOtpFailure = freezed,Object? loginFailure = freezed,Object? registerFailure = freezed,Object? getOtpSt = null,Object? loginSt = null,Object? registerSt = null,Object? checkAuthSt = null,}) {
  return _then(_AuthState(
authenticated: null == authenticated ? _self.authenticated : authenticated // ignore: cast_nullable_to_non_nullable
as bool,retryAfter: freezed == retryAfter ? _self.retryAfter : retryAfter // ignore: cast_nullable_to_non_nullable
as int?,getOtpFailure: freezed == getOtpFailure ? _self.getOtpFailure : getOtpFailure // ignore: cast_nullable_to_non_nullable
as Failure?,loginFailure: freezed == loginFailure ? _self.loginFailure : loginFailure // ignore: cast_nullable_to_non_nullable
as Failure?,registerFailure: freezed == registerFailure ? _self.registerFailure : registerFailure // ignore: cast_nullable_to_non_nullable
as Failure?,getOtpSt: null == getOtpSt ? _self.getOtpSt : getOtpSt // ignore: cast_nullable_to_non_nullable
as Status,loginSt: null == loginSt ? _self.loginSt : loginSt // ignore: cast_nullable_to_non_nullable
as Status,registerSt: null == registerSt ? _self.registerSt : registerSt // ignore: cast_nullable_to_non_nullable
as Status,checkAuthSt: null == checkAuthSt ? _self.checkAuthSt : checkAuthSt // ignore: cast_nullable_to_non_nullable
as Status,
  ));
}


}

// dart format on
