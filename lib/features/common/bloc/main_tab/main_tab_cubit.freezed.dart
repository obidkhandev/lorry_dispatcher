// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_tab_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainTabState {

 int get main;
/// Create a copy of MainTabState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainTabStateCopyWith<MainTabState> get copyWith => _$MainTabStateCopyWithImpl<MainTabState>(this as MainTabState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainTabState&&(identical(other.main, main) || other.main == main));
}


@override
int get hashCode => Object.hash(runtimeType,main);

@override
String toString() {
  return 'MainTabState(main: $main)';
}


}

/// @nodoc
abstract mixin class $MainTabStateCopyWith<$Res>  {
  factory $MainTabStateCopyWith(MainTabState value, $Res Function(MainTabState) _then) = _$MainTabStateCopyWithImpl;
@useResult
$Res call({
 int main
});




}
/// @nodoc
class _$MainTabStateCopyWithImpl<$Res>
    implements $MainTabStateCopyWith<$Res> {
  _$MainTabStateCopyWithImpl(this._self, this._then);

  final MainTabState _self;
  final $Res Function(MainTabState) _then;

/// Create a copy of MainTabState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? main = null,}) {
  return _then(_self.copyWith(
main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MainTabState].
extension MainTabStatePatterns on MainTabState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MainTabState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MainTabState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MainTabState value)  $default,){
final _that = this;
switch (_that) {
case _MainTabState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MainTabState value)?  $default,){
final _that = this;
switch (_that) {
case _MainTabState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int main)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MainTabState() when $default != null:
return $default(_that.main);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int main)  $default,) {final _that = this;
switch (_that) {
case _MainTabState():
return $default(_that.main);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int main)?  $default,) {final _that = this;
switch (_that) {
case _MainTabState() when $default != null:
return $default(_that.main);case _:
  return null;

}
}

}

/// @nodoc


class _MainTabState implements MainTabState {
  const _MainTabState({this.main = 1});
  

@override@JsonKey() final  int main;

/// Create a copy of MainTabState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MainTabStateCopyWith<_MainTabState> get copyWith => __$MainTabStateCopyWithImpl<_MainTabState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MainTabState&&(identical(other.main, main) || other.main == main));
}


@override
int get hashCode => Object.hash(runtimeType,main);

@override
String toString() {
  return 'MainTabState(main: $main)';
}


}

/// @nodoc
abstract mixin class _$MainTabStateCopyWith<$Res> implements $MainTabStateCopyWith<$Res> {
  factory _$MainTabStateCopyWith(_MainTabState value, $Res Function(_MainTabState) _then) = __$MainTabStateCopyWithImpl;
@override @useResult
$Res call({
 int main
});




}
/// @nodoc
class __$MainTabStateCopyWithImpl<$Res>
    implements _$MainTabStateCopyWith<$Res> {
  __$MainTabStateCopyWithImpl(this._self, this._then);

  final _MainTabState _self;
  final $Res Function(_MainTabState) _then;

/// Create a copy of MainTabState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? main = null,}) {
  return _then(_MainTabState(
main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
