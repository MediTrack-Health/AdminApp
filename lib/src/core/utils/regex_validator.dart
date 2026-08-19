class RegexValidator {
  RegexValidator._();

  static final email = RegExp(r"^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$");
  static final password = RegExp(r"^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+$");
}


// clean arch

// data
// domain
// presentation - ui & bloc

// login -> 1. ui login button click -> bloc event trigger -> bloc perform operation -> call api in data folder -> response in data model class-> convert to domain model -> bloc state emit -> response ui
