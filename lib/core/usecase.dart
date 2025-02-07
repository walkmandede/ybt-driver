abstract class UseCase<T, P> {
  Future<T> call({required P params});
}

class UseCaseParam {
  Map<String, String>? header;

  UseCaseParam({this.header});
}
