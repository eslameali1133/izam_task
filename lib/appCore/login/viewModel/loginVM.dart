import 'package:flutter/material.dart';
import 'package:izmalogintask/appCore/login/models/userLoginModel.dart';
import 'package:izmalogintask/helper/managers/validationManger.dart';
import 'package:izmalogintask/helper/managers/userDatabaseManager.dart';

class LoginViewModel extends ChangeNotifier {
  String email = '';
  String password = '';
  String? emailError;
  String? passwordError;
  int userLoginCount = 1;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Set loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

// Set email and perform email validation
  void setEmail(String value) {
    email = value;
    emailError = ValidationManager.validateEmail(value);
    notifyListeners();
  }

  // Set password and perform password validation
  void setPassword(String value) {
    password = value;
    passwordError = ValidationManager.validatePassword(value);
    notifyListeners();
  }

  // Check if the data is valid
  bool isValid() {
    return emailError == null && passwordError == null;
  }

  Future<void> login(BuildContext context) async {
    // If the form is not valid, exit
    if (!isValid()) {
      return;
    }

// Show loading indicator
    setLoading(true);

    // Attempt to retrieve user login data from the database
    UserLoginModel? userLogin =
        await UserDatabaseManager.instance.getUserLogin(email, password);

    if (userLogin != null) {
      // Increment login count if user login data exists
      userLoginCount = userLogin.loginCount + 1;
      print('old  $userLoginCount');
    } else {
      // Create new user login data if it doesn't exist
      print('new');
      userLogin = UserLoginModel(email: email, password: password);
      userLoginCount = 1;
    }

    // Update user login count and insert/update in the database
    userLogin.loginCount = userLoginCount;
    await UserDatabaseManager.instance.insertOrUpdateUserLogin(userLogin);

    // Show success message using a SnackBar
    final snackBar = SnackBar(
      content: Text(
          'Login successful!\nThis pair has been used $userLoginCount times.'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // Hide loading indicator
    setLoading(false);
  }
}
