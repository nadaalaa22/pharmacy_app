part of 'medicine_bloc.dart';

@immutable
abstract class MedicineState {}

class MedicineInitial extends MedicineState {}

class MedicineLoading extends MedicineState {}

class MedicineLoaded extends MedicineState {
  List<MedicineModel> medicines;
  MedicineLoaded({required this.medicines});
}