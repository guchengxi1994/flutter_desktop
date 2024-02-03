// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'virtual_folder.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FileOrFolder {
  Object get field0 => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VirtualFile field0) file,
    required TResult Function(VirtualFolder field0) folder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VirtualFile field0)? file,
    TResult? Function(VirtualFolder field0)? folder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VirtualFile field0)? file,
    TResult Function(VirtualFolder field0)? folder,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileOrFolder_File value) file,
    required TResult Function(FileOrFolder_Folder value) folder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FileOrFolder_File value)? file,
    TResult? Function(FileOrFolder_Folder value)? folder,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileOrFolder_File value)? file,
    TResult Function(FileOrFolder_Folder value)? folder,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileOrFolderCopyWith<$Res> {
  factory $FileOrFolderCopyWith(
          FileOrFolder value, $Res Function(FileOrFolder) then) =
      _$FileOrFolderCopyWithImpl<$Res, FileOrFolder>;
}

/// @nodoc
class _$FileOrFolderCopyWithImpl<$Res, $Val extends FileOrFolder>
    implements $FileOrFolderCopyWith<$Res> {
  _$FileOrFolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FileOrFolder_FileCopyWith<$Res> {
  factory _$$FileOrFolder_FileCopyWith(
          _$FileOrFolder_File value, $Res Function(_$FileOrFolder_File) then) =
      __$$FileOrFolder_FileCopyWithImpl<$Res>;
  @useResult
  $Res call({VirtualFile field0});
}

/// @nodoc
class __$$FileOrFolder_FileCopyWithImpl<$Res>
    extends _$FileOrFolderCopyWithImpl<$Res, _$FileOrFolder_File>
    implements _$$FileOrFolder_FileCopyWith<$Res> {
  __$$FileOrFolder_FileCopyWithImpl(
      _$FileOrFolder_File _value, $Res Function(_$FileOrFolder_File) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$FileOrFolder_File(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as VirtualFile,
    ));
  }
}

/// @nodoc

class _$FileOrFolder_File implements FileOrFolder_File {
  const _$FileOrFolder_File(this.field0);

  @override
  final VirtualFile field0;

  @override
  String toString() {
    return 'FileOrFolder.file(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileOrFolder_File &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileOrFolder_FileCopyWith<_$FileOrFolder_File> get copyWith =>
      __$$FileOrFolder_FileCopyWithImpl<_$FileOrFolder_File>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VirtualFile field0) file,
    required TResult Function(VirtualFolder field0) folder,
  }) {
    return file(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VirtualFile field0)? file,
    TResult? Function(VirtualFolder field0)? folder,
  }) {
    return file?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VirtualFile field0)? file,
    TResult Function(VirtualFolder field0)? folder,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileOrFolder_File value) file,
    required TResult Function(FileOrFolder_Folder value) folder,
  }) {
    return file(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FileOrFolder_File value)? file,
    TResult? Function(FileOrFolder_Folder value)? folder,
  }) {
    return file?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileOrFolder_File value)? file,
    TResult Function(FileOrFolder_Folder value)? folder,
    required TResult orElse(),
  }) {
    if (file != null) {
      return file(this);
    }
    return orElse();
  }
}

abstract class FileOrFolder_File implements FileOrFolder {
  const factory FileOrFolder_File(final VirtualFile field0) =
      _$FileOrFolder_File;

  @override
  VirtualFile get field0;
  @JsonKey(ignore: true)
  _$$FileOrFolder_FileCopyWith<_$FileOrFolder_File> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FileOrFolder_FolderCopyWith<$Res> {
  factory _$$FileOrFolder_FolderCopyWith(_$FileOrFolder_Folder value,
          $Res Function(_$FileOrFolder_Folder) then) =
      __$$FileOrFolder_FolderCopyWithImpl<$Res>;
  @useResult
  $Res call({VirtualFolder field0});
}

/// @nodoc
class __$$FileOrFolder_FolderCopyWithImpl<$Res>
    extends _$FileOrFolderCopyWithImpl<$Res, _$FileOrFolder_Folder>
    implements _$$FileOrFolder_FolderCopyWith<$Res> {
  __$$FileOrFolder_FolderCopyWithImpl(
      _$FileOrFolder_Folder _value, $Res Function(_$FileOrFolder_Folder) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field0 = null,
  }) {
    return _then(_$FileOrFolder_Folder(
      null == field0
          ? _value.field0
          : field0 // ignore: cast_nullable_to_non_nullable
              as VirtualFolder,
    ));
  }
}

/// @nodoc

class _$FileOrFolder_Folder implements FileOrFolder_Folder {
  const _$FileOrFolder_Folder(this.field0);

  @override
  final VirtualFolder field0;

  @override
  String toString() {
    return 'FileOrFolder.folder(field0: $field0)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileOrFolder_Folder &&
            (identical(other.field0, field0) || other.field0 == field0));
  }

  @override
  int get hashCode => Object.hash(runtimeType, field0);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileOrFolder_FolderCopyWith<_$FileOrFolder_Folder> get copyWith =>
      __$$FileOrFolder_FolderCopyWithImpl<_$FileOrFolder_Folder>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(VirtualFile field0) file,
    required TResult Function(VirtualFolder field0) folder,
  }) {
    return folder(field0);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(VirtualFile field0)? file,
    TResult? Function(VirtualFolder field0)? folder,
  }) {
    return folder?.call(field0);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(VirtualFile field0)? file,
    TResult Function(VirtualFolder field0)? folder,
    required TResult orElse(),
  }) {
    if (folder != null) {
      return folder(field0);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FileOrFolder_File value) file,
    required TResult Function(FileOrFolder_Folder value) folder,
  }) {
    return folder(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FileOrFolder_File value)? file,
    TResult? Function(FileOrFolder_Folder value)? folder,
  }) {
    return folder?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FileOrFolder_File value)? file,
    TResult Function(FileOrFolder_Folder value)? folder,
    required TResult orElse(),
  }) {
    if (folder != null) {
      return folder(this);
    }
    return orElse();
  }
}

abstract class FileOrFolder_Folder implements FileOrFolder {
  const factory FileOrFolder_Folder(final VirtualFolder field0) =
      _$FileOrFolder_Folder;

  @override
  VirtualFolder get field0;
  @JsonKey(ignore: true)
  _$$FileOrFolder_FolderCopyWith<_$FileOrFolder_Folder> get copyWith =>
      throw _privateConstructorUsedError;
}
