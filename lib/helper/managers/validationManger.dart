/// Utility class for validating email and password inputs.



/// Validates an email address for required format.
///
/// Returns an error message if the email is empty or has an invalid format.
/// Returns `null` if the email is valid.
class ValidationManager {
  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  /// Validates a password for required complexity.
  ///
  /// Returns an error message if the password is empty, too short,
  /// lacks a number, or lacks at least one of (!\$#^*) characters.
  /// Returns `null` if the password is valid.
  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(r'\d').hasMatch(password)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'[$!#^*]').hasMatch(password)) {
      return 'Password must contain at least one of (!\$#^*)';
    }
    return null;
  }
}