part of 'banners_bloc.dart';

@freezed
class BannersState with _$BannersState {
  const factory BannersState.initial() = _Initial;
  const factory BannersState.loading() = _Loading;
  const factory BannersState.loaded(BannersResponseModel banners) = _Loaded;
  const factory BannersState.error(String message) = _Error;
}
