import 'package:flutter/material.dart';
import '../../../core/constants/app_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_input_field.dart';
import '../../../routes/app_routes.dart';

class LoginAdminScreen extends StatefulWidget {
  const LoginAdminScreen({super.key});

  @override
  State<LoginAdminScreen> createState() => _LoginAdminScreenState();
}

class _LoginAdminScreenState extends State<LoginAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Election Officer';
  bool _isLoading = false;

  final List<String> _roles = [
    'Election Officer',
    'System Administrator',
    'Auditor',
  ];

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      // Simulate login delay
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);

        final username = _usernameController.text.trim();
        final password = _passwordController.text.trim();

        // Check credentials
        if (username == 'admin' && password == 'admin123') {
          Navigator.pushReplacementNamed(context, AppRoutes.adminDashboard);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid admin credentials'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.spacingXL),
                Text(
                  'Admin Login',
                  style: AppTheme.headingStyle.copyWith(
                    color: AppTheme.textPrimaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingM),
                Text(
                  'Access the election management system',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacingXL),
                CustomInputField(
                  label: 'Username',
                  hint: 'Enter your username',
                  controller: _usernameController,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppTheme.spacingM),
                CustomInputField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  prefixIcon: const Icon(Icons.lock_outline),
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
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: InputDecoration(
                    labelText: 'Admin Role',
                    prefixIcon: const Icon(Icons.admin_panel_settings),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                    ),
                  ),
                  items: _roles.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedRole = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: AppTheme.spacingXL),
                CustomButton(
                  text: 'Login as Admin',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: AppTheme.spacingM),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.loginStudent);
                  },
                  child: const Text('Back to Student Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}