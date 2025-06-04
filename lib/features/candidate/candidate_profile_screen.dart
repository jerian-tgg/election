import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';

class CandidateProfileScreen extends StatelessWidget {
  final String candidateId;
  final String candidateName;
  final String candidateImage;
  final String candidatePosition;
  final String candidateDescription;

  const CandidateProfileScreen({
    super.key,
    required this.candidateId,
    required this.candidateName,
    required this.candidateImage,
    required this.candidatePosition,
    required this.candidateDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(),
                  const SizedBox(height: AppTheme.spacingL),
                  _buildAboutSection(),
                  const SizedBox(height: AppTheme.spacingL),
                  _buildPlatformSection(),
                  const SizedBox(height: AppTheme.spacingL),
                  _buildExperienceSection(),
                  const SizedBox(height: AppTheme.spacingL),
                  _buildGoalsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              candidateImage,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(candidateImage),
            ),
            const SizedBox(height: AppTheme.spacingM),
            Text(
              candidateName,
              style: AppTheme.headingStyle,
            ),
            Text(
              candidatePosition,
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              candidateDescription,
              style: AppTheme.bodyStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(Icons.facebook, () {}),
                const SizedBox(width: AppTheme.spacingM),
                _buildSocialButton(Icons.language, () {}),
                const SizedBox(width: AppTheme.spacingM),
                _buildSocialButton(Icons.email, () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: AppTheme.primaryColor,
    );
  }

  Widget _buildAboutSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            Text(
              'A dedicated student leader with a passion for creating positive change in our university community. With a strong academic background and extensive involvement in student organizations, I am committed to representing the interests of all students.',
              style: AppTheme.bodyStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Platform',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildPlatformItem(
              'Academic Excellence',
              'Advocate for improved study resources and academic support services.',
              Icons.school,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildPlatformItem(
              'Student Welfare',
              'Enhance mental health services and create more inclusive campus spaces.',
              Icons.favorite,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildPlatformItem(
              'Community Engagement',
              'Foster stronger connections between students, faculty, and administration.',
              Icons.people,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlatformItem(String title, String description, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.primaryColor),
        const SizedBox(width: AppTheme.spacingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingXS),
              Text(
                description,
                style: AppTheme.bodyStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Experience',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildExperienceItem(
              'Class Representative',
              'Computer Science Department',
              '2022 - Present',
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildExperienceItem(
              'Student Council Member',
              'University Student Government',
              '2021 - 2022',
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildExperienceItem(
              'Event Coordinator',
              'Computer Science Society',
              '2020 - 2021',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceItem(String title, String organization, String period) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.bodyStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          organization,
          style: AppTheme.bodyStyle,
        ),
        Text(
          period,
          style: AppTheme.captionStyle,
        ),
      ],
    );
  }

  Widget _buildGoalsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Goals',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildGoalItem(
              'Improve student-faculty communication channels',
              Icons.chat,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildGoalItem(
              'Establish more study spaces across campus',
              Icons.room,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildGoalItem(
              'Create a mentorship program for new students',
              Icons.people_alt,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalItem(String goal, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primaryColor),
        const SizedBox(width: AppTheme.spacingM),
        Expanded(
          child: Text(
            goal,
            style: AppTheme.bodyStyle,
          ),
        ),
      ],
    );
  }
} 