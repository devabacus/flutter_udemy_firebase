
abstract class StringValidator{

  bool isValid(String value);

}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty ;
  }

}


class EmailAndPasswordValidators{
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passValidator = NonEmptyStringValidator();
  final String invalidErrorText = 'Поле почта должно быть заполнено';
}