class FormValidator {

  static String? validator (String? value,{String fieldName='This Field'}){
    if (value!.isEmpty) {
      return '$fieldName must not be empty';
    }
    else {
      return null;
    }

  }

}