abstract class Failure {
  String massage;
   Failure([this.massage = 'An Unexpected error occurred.']);
}

class CacheFailure extends Failure {
   CacheFailure({required String message}) ;
}
