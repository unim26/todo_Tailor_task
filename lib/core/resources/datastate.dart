abstract class Datastate<T> {
  final T? data;
  final String? message;

  Datastate({this.data, this.message});
}

//success state
class DataSuccess<T> extends Datastate<T> {
  DataSuccess(T? data) : super(data: data);
}

//data failure state
class DataFailed<T> extends Datastate<T> {
  DataFailed(String message) : super(message: message);
}
