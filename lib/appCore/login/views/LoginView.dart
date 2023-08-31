import 'package:flutter/material.dart';
import 'package:izmalogintask/AppCore/Login/ViewModel/loginVM.dart';
import 'package:provider/provider.dart';


/// A login screen with user authentication.
///
/// Displays a login interface with email and password input fields.
/// Handles validation, authentication, and UI state using [LoginViewModel].
///

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);

    Future<void> handleLogin() async {
      await loginVM.login(context);
    }

    final emailField = TextFormField(
      onChanged: loginVM.setEmail,
      decoration: InputDecoration(
        labelText: 'Email Address',
        errorText: loginVM.emailError,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        FocusScope.of(context).nextFocus(); // Move to the next field
      },
    );

    final passwordField = TextFormField(
      onChanged: loginVM.setPassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: loginVM.passwordError,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) {
        FocusScope.of(context).unfocus(); // Hide the keyboard
      },
    );

    final loginButton = Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: loginVM.isLoading
            ? null
            : handleLogin, // Call the _handleLogin function
        child: loginVM.isLoading
            ? const CircularProgressIndicator() // Show loading indicator
            : const Text('Login'),
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40.0), // Space for the image logo
            Image.asset(
              'images/Logo.png', // Replace with your image asset path
              width: 100.0,
              height: 100.0,
            ),
            const  SizedBox(height: 50.0),
            FractionallySizedBox(
              widthFactor: 0.9, // Set the desired height
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Welcome , Log in',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      emailField,
                      const SizedBox(height: 16.0),
                      passwordField,
                      const SizedBox(height: 16.0),
                      loginButton,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
