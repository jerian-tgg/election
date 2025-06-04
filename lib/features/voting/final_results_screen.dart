import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';

class FinalResultsScreen extends StatefulWidget {
  const FinalResultsScreen({super.key});

  @override
  State<FinalResultsScreen> createState() => _FinalResultsScreenState();
}

class _FinalResultsScreenState extends State<FinalResultsScreen> {
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
        title: const Text('Final Results'),
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
              'Final election results',
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
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _totalVotes.toDouble(),
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${rod.toY.round()} votes',
                          const TextStyle(color: Colors.white),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value >= 0 && value < _candidates.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                _candidates[value.toInt()]['name'],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: _candidates.asMap().entries.map((entry) {
                    final index = entry.key;
                    final candidate = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: candidate['votes'].toDouble(),
                          color: candidate['color'] as Color,
                          width: 20,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(6),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
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