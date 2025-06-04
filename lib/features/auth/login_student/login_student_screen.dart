import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_input_field.dart';
import '../../../routes/app_routes.dart';

class LoginStudentScreen extends StatefulWidget {
  const LoginStudentScreen({super.key});

  @override
  State<LoginStudentScreen> createState() => _LoginStudentScreenState();
}

class _LoginStudentScreenState extends State<LoginStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // Simulate login delay
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingL),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Student Login',
                    style: AppTheme.headingStyle.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacingXL),
                  CustomInputField(
                    label: 'Email',
                    hint: 'Enter your email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your email';
                      }
                      if (!value!.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      if (!value.endsWith('@students.isatu.edu.ph')) {
                        return 'Only ISAT-U student emails are allowed';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  CustomInputField(
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your password';
                      }
                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppTheme.spacingL),
                  CustomButton(
                    text: 'Login',
                    onPressed: _handleLogin,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: const Text('Don\'t have an account? Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.loginAdmin);
                    },
                    child: const Text('Login as Admin'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}