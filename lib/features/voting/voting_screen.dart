import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';
import '../../routes/app_routes.dart';

class VotingScreen extends StatefulWidget {
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  String? _selectedCandidateId;
  bool _isSubmitting = false;

  final List<Map<String, dynamic>> _candidates = [
    {
      'id': '1',
      'name': 'John Smith',
      'position': 'President',
      'image': 'https://via.placeholder.com/150',
      'description': 'Computer Science, 4th Year',
      'platform': 'Building a stronger student community through innovation and inclusivity.',
    },
    {
      'id': '2',
      'name': 'Sarah Johnson',
      'position': 'President',
      'image': 'https://via.placeholder.com/150',
      'description': 'Business Administration, 3rd Year',
      'platform': 'Empowering students through effective communication and sustainable initiatives.',
    },
    {
      'id': '3',
      'name': 'Michael Chen',
      'position': 'President',
      'image': 'https://via.placeholder.com/150',
      'description': 'Engineering, 4th Year',
      'platform': 'Creating opportunities for academic excellence and student welfare.',
    },
  ];

  void _handleVote() {
    if (_selectedCandidateId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a candidate to vote for'),
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    // Simulate vote submission
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isSubmitting = false);
      _showVoteConfirmation();
    });
  }

  void _showVoteConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Vote Confirmation'),
        content: const Text(
          'Your vote has been successfully recorded. Thank you for participating in the election!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
            },
            child: const Text('Return to Dashboard'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cast Your Vote'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Council Election',
              style: AppTheme.headingStyle,
            ),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              'Select your candidate for President',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingL),
            ..._candidates.map((candidate) => _buildCandidateCard(candidate)),
            const SizedBox(height: AppTheme.spacingL),
            CustomButton(
              text: 'Submit Vote',
              onPressed: _handleVote,
              isLoading: _isSubmitting,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateCard(Map<String, dynamic> candidate) {
    final isSelected = _selectedCandidateId == candidate['id'];

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
        side: BorderSide(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCandidateId = candidate['id'];
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(candidate['image']),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          candidate['name'],
                          style: AppTheme.subheadingStyle,
                        ),
                        Text(
                          candidate['description'],
                          style: AppTheme.bodyStyle,
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check_circle,
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingM),
              Text(
                'Platform:',
                style: AppTheme.bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingXS),
              Text(
                candidate['platform'],
                style: AppTheme.bodyStyle,
              ),
              const SizedBox(height: AppTheme.spacingM),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.candidateProfile,
                        arguments: {
                          'candidateId': candidate['id'],
                          'candidateName': candidate['name'],
                          'candidateImage': candidate['image'],
                          'candidatePosition': candidate['position'],
                          'candidateDescription': candidate['description'],
                        },
                      );
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('View Profile'),
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