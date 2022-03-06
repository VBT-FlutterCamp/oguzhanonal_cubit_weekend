import 'package:flutter_bloc/flutter_bloc.dart';

import 'cats_repo.dart';
import 'cats_state.dart';

class CatsCubit extends Cubit<CatState> {
  // ignore: prefer_const_constructors
  final CatsRepo _catsRepo;
  CatsCubit(this._catsRepo) : super(CatInitial());

  Future<void> getCats() async {
    try {
      emit(CatsLoading());
      Future.delayed(Duration(milliseconds: 500));
      final response = await _catsRepo.getCats();
      emit(CatsCompleted(response));
    } on Exception catch (e) {
      emit(CatsError("Couldnt get message"));
    }
  }
}
