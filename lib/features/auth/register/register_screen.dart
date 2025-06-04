import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_input_field.dart';
import '../../../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _studentIdController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // Simulate registration delay
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        Navigator.pushReplacementNamed(context, AppRoutes.loginStudent);
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
                    'Create Account',
                    style: AppTheme.headingStyle.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacingXL),
                  CustomInputField(
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    controller: _nameController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  CustomInputField(
                    label: 'Student ID',
                    hint: 'Enter your student ID',
                    controller: _studentIdController,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your student ID';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  CustomInputField(
                    label: 'Email',
                    hint: 'Enter your ISAT-U email (@students.isatu.edu.ph)',
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
                  const SizedBox(height: AppTheme.spacingM),
                  CustomInputField(
                    label: 'Confirm Password',
                    hint: 'Confirm your password',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppTheme.spacingL),
                  CustomButton(
                    text: 'Register',
                    onPressed: _handleRegister,
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.loginStudent);
                    },
                    child: const Text('Already have an account? Login'),
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