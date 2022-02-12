abstract class Failure {}

class SchoolNotFound extends Failure {}

class SomethingWentWrong extends Failure {}

class InvalidCredential extends Failure {}

class UserFound extends Failure {}

class TimeOutError extends Failure {}

class UnexpectedError extends Failure {}

class ServerException extends Failure {}

class StudentNotFound extends Failure {}

class FailureToString {
  static String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerException:
        return "Oops! Please check your internet connection";
      case InvalidCredential:
        return 'Invalid authentication credential';
      case SchoolNotFound:
        return 'School not found';
      case SomethingWentWrong:
        return 'Something went wrong';
      case TimeOutError:
        return 'Connection timed out, tap to try again';
      case StudentNotFound:
        return 'Student not found';
      case UserFound:
        return 'User with email and/or phone number already exists';
      default:
        return 'Unexpected error! Try again or contact support';
    }
  }
}
