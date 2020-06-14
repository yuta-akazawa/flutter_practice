// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'todo_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$TodoStateTearOff {
  const _$TodoStateTearOff();

  _TodoStateData call({List<String> todos = const <String>[]}) {
    return _TodoStateData(
      todos: todos,
    );
  }
}

// ignore: unused_element
const $TodoState = _$TodoStateTearOff();

mixin _$TodoState {
  List<String> get todos;

  $TodoStateCopyWith<TodoState> get copyWith;
}

abstract class $TodoStateCopyWith<$Res> {
  factory $TodoStateCopyWith(TodoState value, $Res Function(TodoState) then) =
      _$TodoStateCopyWithImpl<$Res>;
  $Res call({List<String> todos});
}

class _$TodoStateCopyWithImpl<$Res> implements $TodoStateCopyWith<$Res> {
  _$TodoStateCopyWithImpl(this._value, this._then);

  final TodoState _value;
  // ignore: unused_field
  final $Res Function(TodoState) _then;

  @override
  $Res call({
    Object todos = freezed,
  }) {
    return _then(_value.copyWith(
      todos: todos == freezed ? _value.todos : todos as List<String>,
    ));
  }
}

abstract class _$TodoStateDataCopyWith<$Res>
    implements $TodoStateCopyWith<$Res> {
  factory _$TodoStateDataCopyWith(
          _TodoStateData value, $Res Function(_TodoStateData) then) =
      __$TodoStateDataCopyWithImpl<$Res>;
  @override
  $Res call({List<String> todos});
}

class __$TodoStateDataCopyWithImpl<$Res> extends _$TodoStateCopyWithImpl<$Res>
    implements _$TodoStateDataCopyWith<$Res> {
  __$TodoStateDataCopyWithImpl(
      _TodoStateData _value, $Res Function(_TodoStateData) _then)
      : super(_value, (v) => _then(v as _TodoStateData));

  @override
  _TodoStateData get _value => super._value as _TodoStateData;

  @override
  $Res call({
    Object todos = freezed,
  }) {
    return _then(_TodoStateData(
      todos: todos == freezed ? _value.todos : todos as List<String>,
    ));
  }
}

class _$_TodoStateData with DiagnosticableTreeMixin implements _TodoStateData {
  const _$_TodoStateData({this.todos = const <String>[]})
      : assert(todos != null);

  @JsonKey(defaultValue: const <String>[])
  @override
  final List<String> todos;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoState(todos: $todos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoState'))
      ..add(DiagnosticsProperty('todos', todos));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoStateData &&
            (identical(other.todos, todos) ||
                const DeepCollectionEquality().equals(other.todos, todos)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(todos);

  @override
  _$TodoStateDataCopyWith<_TodoStateData> get copyWith =>
      __$TodoStateDataCopyWithImpl<_TodoStateData>(this, _$identity);
}

abstract class _TodoStateData implements TodoState {
  const factory _TodoStateData({List<String> todos}) = _$_TodoStateData;

  @override
  List<String> get todos;
  @override
  _$TodoStateDataCopyWith<_TodoStateData> get copyWith;
}
