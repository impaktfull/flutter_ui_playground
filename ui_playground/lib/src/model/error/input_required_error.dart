class InputRequiredError<T> extends Error {
  final String paramName;

  InputRequiredError(
    this.paramName,
  );

  @override
  String toString() => 'InputRequiredError: $paramName is required for $T';
}
