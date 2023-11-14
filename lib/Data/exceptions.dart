class ExceptionWorld implements Exception {
  final String error;
  ExceptionWorld({required this.error});

  @override
  String toString() {
    return error;
  }
}

class UnIdentifiedError extends ExceptionWorld {
  UnIdentifiedError({
    required String errormessage,
  }) : super(error: errormessage);
}





 