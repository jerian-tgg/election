import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../routes/app_routes.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isChangingPassword = false;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showChangePasswordForm() {
    setState(() {
      _isChangingPassword = true;
    });
  }

  void _hideChangePasswordForm() {
    setState(() {
      _isChangingPassword = false;
      _formKey.currentState?.reset();
    });
  }

  void _handleChangePassword() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simulate password change
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password changed successfully'),
          backgroundColor: Colors.green,
        ),
      );
      _hideChangePasswordForm();
    }
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.loginStudent);
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSection(),
            const SizedBox(height: AppTheme.spacingL),
            _buildSettingsList(),
            if (_isChangingPassword) ...[
              const SizedBox(height: AppTheme.spacingL),
              _buildChangePasswordForm(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.spacingXS),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: AppTheme.primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'John Doe',
            style: AppTheme.headingStyle.copyWith(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          Text(
            'john.doe@isatu.edu.ph',
            style: AppTheme.bodyStyle.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              // Navigate to edit profile
            },
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: _showChangePasswordForm,
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notification Settings',
            onTap: () {
              // Navigate to notification settings
            },
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.language,
            title: 'Language',
            onTap: () {
              // Show language selection
            },
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.color_lens_outlined,
            title: 'Theme',
            onTap: () {
              // Show theme selection
            },
          ),
          const Divider(height: 1),
          _buildSettingsTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: _handleLogout,
            textColor: Colors.red,
            iconColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? AppTheme.primaryColor,
      ),
      title: Text(
        title,
        style: AppTheme.bodyStyle.copyWith(
          color: textColor ?? AppTheme.textPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildChangePasswordForm() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Password',
                style: AppTheme.subheadingStyle.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),
              CustomInputField(
                label: 'Current Password',
                hint: 'Enter current password',
                controller: _currentPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              CustomInputField(
                label: 'New Password',
                hint: 'Enter new password',
                controller: _newPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a new password';
                  }
                  if (value!.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              CustomInputField(
                label: 'Confirm New Password',
                hint: 'Confirm new password',
                controller: _confirmPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingL),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _hideChangePasswordForm,
                    child: Text(
                      'Cancel',
                      style: AppTheme.bodyStyle.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  ElevatedButton(
                    onPressed: _handleChangePassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingL,
                        vertical: AppTheme.spacingM,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                      ),
                    ),
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
} 