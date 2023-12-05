part of 'medicine_bloc.dart';

@immutable
abstract class MedicineEvent {}

class SetMedicines extends MedicineEvent {}

class GetMedicines extends MedicineEvent {

}
class SearchProducts extends MedicineEvent {
  final String query;

  SearchProducts({required this.query});

}