import 'cat.dart';

abstract class CatState {
  const CatState();
}

class CatInitial extends CatState {
  const CatInitial();
}

class CatsLoading extends CatState {
  const CatsLoading();
}

class CatsCompleted extends CatState {
  final List<Cat> response;
  const CatsCompleted(this.response);
}

class CatsError extends CatState {
  final String message;
  const CatsError(this.message);
}
