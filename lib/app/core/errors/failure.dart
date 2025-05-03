// File: lib/core/error/failure.dart

abstract class Failure {
  final String? message;
  Failure([this.message]);
}

class ServerFailure extends Failure {
  ServerFailure([String? message]) : super(message);
}

class NoConnectionFailure extends Failure {
  NoConnectionFailure() : super('Tidak ada koneksi internet');
}

class SlowConnectionFailure extends Failure {
  SlowConnectionFailure() : super('Koneksi internet lambat');
}