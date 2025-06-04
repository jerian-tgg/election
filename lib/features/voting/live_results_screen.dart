import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';

class LiveResultsScreen extends StatefulWidget {
  const LiveResultsScreen({super.key});

  @override
  State<LiveResultsScreen> createState() => _LiveResultsScreenState();
}

class _LiveResultsScreenState extends State<LiveResultsScreen> {
  final List<Map<String, dynamic>> _candidates = [
    {
      'id': '1',
      'name': 'John Smith',
      'party': 'Student Alliance',
      'votes': 450,
      'color': Colors.blue,
    },
    {
      'id': '2',
      'name': 'Sarah Johnson',
      'party': 'Progressive Students',
      'votes': 380,
      'color': Colors.green,
    },
    {
      'id': '3',
      'name': 'Michael Chen',
      'party': 'Student Alliance',
      'votes': 270,
      'color': Colors.orange,
    },
  ];

  int _totalVotes = 0;
  int _totalVoters = 1000;

  @override
  void initState() {
    super.initState();
    _calculateTotalVotes();
  }

  void _calculateTotalVotes() {
    _totalVotes = _candidates.fold(0, (sum, candidate) => sum + candidate['votes'] as int);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Results'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppTheme.spacingL),
            _buildResultsChart(),
            const SizedBox(height: AppTheme.spacingL),
            _buildCandidateList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Council Election 2024',
              style: AppTheme.headingStyle,
            ),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              'Live voting results',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            Row(
              children: [
                _buildInfoChip(
                  'Total Votes',
                  _totalVotes.toString(),
                  Icons.how_to_vote,
                ),
                const SizedBox(width: AppTheme.spacingM),
                _buildInfoChip(
                  'Voter Turnout',
                  '${((_totalVotes / _totalVoters) * 100).toStringAsFixed(1)}%',
                  Icons.people,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingS),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: AppTheme.primaryColor),
            const SizedBox(width: AppTheme.spacingXS),
            Column(
              children: [
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsChart() {
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
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: _candidates.map((candidate) {
                          final percentage = (candidate['votes'] as int) / _totalVotes;
                          return PieChartSectionData(
                            color: candidate['color'] as Color,
                            value: candidate['votes'].toDouble(),
                            title: '${(percentage * 100).toStringAsFixed(1)}%',
                            radius: 80,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }).toList(),
                        sectionsSpace: 2,
                        centerSpaceRadius: 30,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _candidates.map((candidate) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: candidate['color'] as Color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                candidate['name'],
                                style: AppTheme.captionStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateList() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Candidate Results',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: AppTheme.spacingM),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _candidates.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final candidate = _candidates[index];
                final percentage = (candidate['votes'] as int) / _totalVotes;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: candidate['color'] as Color,
                    child: Text(
                      candidate['name'][0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(candidate['name']),
                  subtitle: Text(candidate['party']),
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
      ),
    );
  }
} 