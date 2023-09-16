part of 'banners_bloc.dart';

@freezed
class BannersEvent with _$BannersEvent {
  const factory BannersEvent.started() = _Started;
  const factory BannersEvent.getAll() = _GetAll;
}