abstract class UseCase<T, P> {
  Future<T> call(P params);
}

abstract class UseCaseWithoutParams<T> {
  Future<T> call();
}
