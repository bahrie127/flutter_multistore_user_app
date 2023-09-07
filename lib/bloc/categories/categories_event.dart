part of 'categories_bloc.dart';

@freezed
class CategoriesEvent with _$CategoriesEvent {
  const factory CategoriesEvent.started() = _Started;
  const factory CategoriesEvent.getCategories() = _GetCategories;
}