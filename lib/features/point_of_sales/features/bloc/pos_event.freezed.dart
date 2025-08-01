// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pos_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PosEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BillEntity bill) addBill,
    required TResult Function() loadSalesList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BillEntity bill)? addBill,
    TResult? Function()? loadSalesList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BillEntity bill)? addBill,
    TResult Function()? loadSalesList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddBill value) addBill,
    required TResult Function(LoadSalesList value) loadSalesList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddBill value)? addBill,
    TResult? Function(LoadSalesList value)? loadSalesList,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddBill value)? addBill,
    TResult Function(LoadSalesList value)? loadSalesList,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PosEventCopyWith<$Res> {
  factory $PosEventCopyWith(PosEvent value, $Res Function(PosEvent) then) =
      _$PosEventCopyWithImpl<$Res, PosEvent>;
}

/// @nodoc
class _$PosEventCopyWithImpl<$Res, $Val extends PosEvent>
    implements $PosEventCopyWith<$Res> {
  _$PosEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PosEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddBillImplCopyWith<$Res> {
  factory _$$AddBillImplCopyWith(
          _$AddBillImpl value, $Res Function(_$AddBillImpl) then) =
      __$$AddBillImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BillEntity bill});
}

/// @nodoc
class __$$AddBillImplCopyWithImpl<$Res>
    extends _$PosEventCopyWithImpl<$Res, _$AddBillImpl>
    implements _$$AddBillImplCopyWith<$Res> {
  __$$AddBillImplCopyWithImpl(
      _$AddBillImpl _value, $Res Function(_$AddBillImpl) _then)
      : super(_value, _then);

  /// Create a copy of PosEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bill = null,
  }) {
    return _then(_$AddBillImpl(
      null == bill
          ? _value.bill
          : bill // ignore: cast_nullable_to_non_nullable
              as BillEntity,
    ));
  }
}

/// @nodoc

class _$AddBillImpl implements AddBill {
  const _$AddBillImpl(this.bill);

  @override
  final BillEntity bill;

  @override
  String toString() {
    return 'PosEvent.addBill(bill: $bill)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddBillImpl &&
            (identical(other.bill, bill) || other.bill == bill));
  }

  @override
  int get hashCode => Object.hash(runtimeType, bill);

  /// Create a copy of PosEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddBillImplCopyWith<_$AddBillImpl> get copyWith =>
      __$$AddBillImplCopyWithImpl<_$AddBillImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BillEntity bill) addBill,
    required TResult Function() loadSalesList,
  }) {
    return addBill(bill);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BillEntity bill)? addBill,
    TResult? Function()? loadSalesList,
  }) {
    return addBill?.call(bill);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BillEntity bill)? addBill,
    TResult Function()? loadSalesList,
    required TResult orElse(),
  }) {
    if (addBill != null) {
      return addBill(bill);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddBill value) addBill,
    required TResult Function(LoadSalesList value) loadSalesList,
  }) {
    return addBill(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddBill value)? addBill,
    TResult? Function(LoadSalesList value)? loadSalesList,
  }) {
    return addBill?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddBill value)? addBill,
    TResult Function(LoadSalesList value)? loadSalesList,
    required TResult orElse(),
  }) {
    if (addBill != null) {
      return addBill(this);
    }
    return orElse();
  }
}

abstract class AddBill implements PosEvent {
  const factory AddBill(final BillEntity bill) = _$AddBillImpl;

  BillEntity get bill;

  /// Create a copy of PosEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddBillImplCopyWith<_$AddBillImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadSalesListImplCopyWith<$Res> {
  factory _$$LoadSalesListImplCopyWith(
          _$LoadSalesListImpl value, $Res Function(_$LoadSalesListImpl) then) =
      __$$LoadSalesListImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadSalesListImplCopyWithImpl<$Res>
    extends _$PosEventCopyWithImpl<$Res, _$LoadSalesListImpl>
    implements _$$LoadSalesListImplCopyWith<$Res> {
  __$$LoadSalesListImplCopyWithImpl(
      _$LoadSalesListImpl _value, $Res Function(_$LoadSalesListImpl) _then)
      : super(_value, _then);

  /// Create a copy of PosEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadSalesListImpl implements LoadSalesList {
  const _$LoadSalesListImpl();

  @override
  String toString() {
    return 'PosEvent.loadSalesList()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadSalesListImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BillEntity bill) addBill,
    required TResult Function() loadSalesList,
  }) {
    return loadSalesList();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BillEntity bill)? addBill,
    TResult? Function()? loadSalesList,
  }) {
    return loadSalesList?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BillEntity bill)? addBill,
    TResult Function()? loadSalesList,
    required TResult orElse(),
  }) {
    if (loadSalesList != null) {
      return loadSalesList();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AddBill value) addBill,
    required TResult Function(LoadSalesList value) loadSalesList,
  }) {
    return loadSalesList(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AddBill value)? addBill,
    TResult? Function(LoadSalesList value)? loadSalesList,
  }) {
    return loadSalesList?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AddBill value)? addBill,
    TResult Function(LoadSalesList value)? loadSalesList,
    required TResult orElse(),
  }) {
    if (loadSalesList != null) {
      return loadSalesList(this);
    }
    return orElse();
  }
}

abstract class LoadSalesList implements PosEvent {
  const factory LoadSalesList() = _$LoadSalesListImpl;
}
