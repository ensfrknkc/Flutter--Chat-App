class ErrorException{

  static String show(String errorCode){
    print(errorCode);
    switch (errorCode){
      case'email-already-in-use':
        return "This e-mail address has been used before. Please use a different e-mail address.";
      case 'user-not-found':
        return"No user found.";
      case 'wrong-password':
        return"E-mail or password is incorrect";
      default:
        return "Something went wrong";
    }

  }

}
