import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/datasource/medicine_remote_ds.dart';
import '../../../data/models/medicine_data.dart';


part 'medicine_event.dart';
part 'medicine_state.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  MedicineRemoteDs medicineRemoteDs;
  MedicineBloc(this.medicineRemoteDs) : super(MedicineInitial()) {
    on<MedicineEvent>((event, emit) async {
      if (event is GetMedicines) {
        emit(MedicineLoading());
        List<MedicineModel> medicineModel =
        await medicineRemoteDs.getMedicines();
        emit(MedicineLoaded(medicines: medicineModel));
      }
      else if (event is SearchProducts) {
        emit(MedicineLoading());
        List<MedicineModel> searchResults =
        await medicineRemoteDs.searchProducts(event.query);
        emit(MedicineLoaded(medicines: searchResults));
      }
    });
  }
}