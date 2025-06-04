import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';

class VoterHistoryScreen extends StatelessWidget {
  const VoterHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _votingHistory = [
      {
        'id': '1',
        'electionTitle': 'Student Council Election',
        'date': 'March 10, 2024',
        'time': '2:30 PM',
        'position': 'President',
        'candidate': 'John Smith',
        'status': 'Completed',
      },
      {
        'id': '2',
        'electionTitle': 'Department Council Election',
        'date': 'February 28, 2024',
        'time': '11:15 AM',
        'position': 'Department Representative',
        'candidate': 'Sarah Johnson',
        'status': 'Cancelled',
      },
      {
        'id': '3',
        'electionTitle': 'Class Representative Election',
        'date': 'January 15, 2024',
        'time': '3:45 PM',
        'position': 'Class Representative',
        'candidate': 'Michael Chen',
        'status': 'Did Not Vote',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting History'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppTheme.spacingL),
            _buildVotingStats(_votingHistory),
            const SizedBox(height: AppTheme.spacingL),
            _buildVotingHistory(_votingHistory),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voting History',
          style: AppTheme.headingStyle.copyWith(
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacingS),
        Text(
          'View your past voting activities',
          style: AppTheme.bodyStyle.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildVotingStats(List<Map<String, dynamic>> history) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Voting Statistics',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Total Votes',
                  history.length.toString(),
                  Icons.how_to_vote,
                ),
                _buildStatItem(
                  'Elections Participated',
                  '3',
                  Icons.event,
                ),
                _buildStatItem(
                  'Last Vote',
                  'March 10, 2024',
                  Icons.calendar_today,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.primaryColor),
        const SizedBox(height: AppTheme.spacingXS),
        Text(
          value,
          style: AppTheme.bodyStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTheme.captionStyle,
        ),
      ],
    );
  }

  Widget _buildVotingHistory(List<Map<String, dynamic>> history) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Votes',
          style: AppTheme.subheadingStyle,
        ),
        const SizedBox(height: AppTheme.spacingM),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: history.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final vote = history[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.how_to_vote,
                    color: AppTheme.primaryColor,
                  ),
                ),
                title: Text(
                  vote['electionTitle'],
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vote['date']} • ${vote['time']}',
                      style: AppTheme.captionStyle,
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      'Position: ${vote['position']}',
                      style: AppTheme.bodyStyle,
                    ),
                    if (vote['status'] == 'Completed')
                      Text(
                        'Voted for: ${vote['candidate']}',
                        style: AppTheme.bodyStyle,
                      ),
                  ],
                ),
                trailing: _buildStatusChip(vote['status']),
                isThreeLine: true,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Did Not Vote':
        color = Colors.grey;
        break;
      case 'Completed':
        color = Colors.green;
        break;
      case 'Pending':
        color = Colors.orange;
        break;
      case 'Cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      backgroundColor: color,
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}