import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';

class FinalResultsScreen extends StatelessWidget {
  const FinalResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _candidates = [
      {
        'id': '1',
        'name': 'John Smith',
        'votes': 245,
        'color': Colors.blue,
        'position': 'President',
        'department': 'Computer Science',
        'year': '4th Year',
      },
      {
        'id': '2',
        'name': 'Sarah Johnson',
        'votes': 189,
        'color': Colors.green,
        'position': 'President',
        'department': 'Business Administration',
        'year': '3rd Year',
      },
      {
        'id': '3',
        'name': 'Michael Chen',
        'votes': 156,
        'color': Colors.orange,
        'position': 'President',
        'department': 'Engineering',
        'year': '4th Year',
      },
    ];

    final totalVotes = _candidates.fold(0, (sum, candidate) => sum + candidate['votes'] as int);
    final winner = _candidates.reduce((a, b) => (a['votes'] as int) > (b['votes'] as int) ? a : b);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWinnerCard(winner),
            const SizedBox(height: AppTheme.spacingL),
            _buildElectionStats(totalVotes),
            const SizedBox(height: AppTheme.spacingL),
            _buildResultsChart(_candidates, totalVotes),
            const SizedBox(height: AppTheme.spacingL),
            _buildDetailedResults(_candidates, totalVotes),
          ],
        ),
      ),
    );
  }

  Widget _buildWinnerCard(Map<String, dynamic> winner) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          children: [
            const Icon(
              Icons.emoji_events,
              size: 48,
              color: Colors.amber,
            ),
            const SizedBox(height: AppTheme.spacingM),
            Text(
              'Winner',
              style: AppTheme.headingStyle.copyWith(
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            CircleAvatar(
              radius: 40,
              backgroundColor: winner['color'] as Color,
              child: Text(
                winner['name'].toString().split(' ').map((e) => e[0]).join(''),
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            Text(
              winner['name'],
              style: AppTheme.headingStyle,
            ),
            Text(
              winner['position'],
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              '${winner['department']} • ${winner['year']}',
              style: AppTheme.bodyStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            Text(
              '${winner['votes']} votes',
              style: AppTheme.bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: winner['color'] as Color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElectionStats(int totalVotes) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Election Statistics',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            _buildStatRow(
              'Total Votes Cast',
              totalVotes.toString(),
              Icons.how_to_vote,
            ),
            const Divider(),
            _buildStatRow(
              'Total Registered Voters',
              '1,000',
              Icons.people,
            ),
            const Divider(),
            _buildStatRow(
              'Voter Turnout',
              '${((totalVotes / 1000) * 100).toStringAsFixed(1)}%',
              Icons.trending_up,
            ),
            const Divider(),
            _buildStatRow(
              'Election Duration',
              '8 hours',
              Icons.timer,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingS),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Text(
              label,
              style: AppTheme.bodyStyle,
            ),
          ),
          Text(
            value,
            style: AppTheme.bodyStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsChart(List<Map<String, dynamic>> candidates, int totalVotes) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vote Distribution',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: candidates.map((candidate) {
                    final percentage = (candidate['votes'] as int) / totalVotes;
                    return PieChartSectionData(
                      color: candidate['color'] as Color,
                      value: candidate['votes'].toDouble(),
                      title: '${(percentage * 100).toStringAsFixed(1)}%',
                      radius: 100,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedResults(List<Map<String, dynamic>> candidates, int totalVotes) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Text(
              'Detailed Results',
              style: AppTheme.subheadingStyle,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: candidates.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final candidate = candidates[index];
              final percentage = (candidate['votes'] as int) / totalVotes;
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: candidate['color'] as Color,
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(candidate['name']),
                subtitle: Text(
                  '${candidate['department']} • ${candidate['year']}',
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      candidate['votes'].toString(),
                      style: AppTheme.bodyStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(percentage * 100).toStringAsFixed(1)}%',
                      style: AppTheme.captionStyle,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
} 