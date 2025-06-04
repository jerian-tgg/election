import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_input_field.dart';
import '../../routes/app_routes.dart';

class CandidateManagementScreen extends StatefulWidget {
  const CandidateManagementScreen({super.key});

  @override
  State<CandidateManagementScreen> createState() => _CandidateManagementScreenState();
}

class _CandidateManagementScreenState extends State<CandidateManagementScreen> {
  final List<Map<String, dynamic>> _candidates = [
    {
      'id': '1',
      'name': 'John Smith',
      'position': 'President',
      'department': 'Computer Science',
      'year': '4th Year',
      'image': 'https://via.placeholder.com/150',
      'status': 'Active',
    },
    {
      'id': '2',
      'name': 'Sarah Johnson',
      'position': 'President',
      'department': 'Business Administration',
      'year': '3rd Year',
      'image': 'https://via.placeholder.com/150',
      'status': 'Active',
    },
    {
      'id': '3',
      'name': 'Michael Chen',
      'position': 'President',
      'department': 'Engineering',
      'year': '4th Year',
      'image': 'https://via.placeholder.com/150',
      'status': 'Pending',
    },
  ];

  bool _isAddingCandidate = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _departmentController = TextEditingController();
  final _yearController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _departmentController.dispose();
    _yearController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _showAddCandidateForm() {
    setState(() {
      _isAddingCandidate = true;
    });
  }

  void _hideAddCandidateForm() {
    setState(() {
      _isAddingCandidate = false;
      _formKey.currentState?.reset();
    });
  }

  void _handleAddCandidate() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simulate adding candidate
      setState(() {
        _candidates.add({
          'id': (_candidates.length + 1).toString(),
          'name': _nameController.text,
          'position': _positionController.text,
          'department': _departmentController.text,
          'year': _yearController.text,
          'image': _imageController.text,
          'status': 'Pending',
        });
        _hideAddCandidateForm();
      });
    }
  }

  void _handleUpdateStatus(String candidateId, String newStatus) {
    setState(() {
      final candidate = _candidates.firstWhere((c) => c['id'] == candidateId);
      candidate['status'] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidate Management'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppTheme.spacingL),
            if (_isAddingCandidate) _buildAddCandidateForm(),
            if (!_isAddingCandidate) _buildCandidateList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Manage Candidates',
          style: AppTheme.headingStyle,
        ),
        if (!_isAddingCandidate)
          CustomButton(
            text: 'Add Candidate',
            onPressed: _showAddCandidateForm,
            icon: Icons.add,
          ),
      ],
    );
  }

  Widget _buildAddCandidateForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Candidate',
                style: AppTheme.subheadingStyle,
              ),
              const SizedBox(height: AppTheme.spacingM),
              CustomInputField(
                label: 'Full Name',
                hint: 'Enter candidate\'s full name',
                controller: _nameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the candidate\'s name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              CustomInputField(
                label: 'Position',
                hint: 'Enter position (e.g., President)',
                controller: _positionController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the position';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              CustomInputField(
                label: 'Department',
                hint: 'Enter department',
                controller: _departmentController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the department';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              CustomInputField(
                label: 'Year',
                hint: 'Enter year (e.g., 4th Year)',
                controller: _yearController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the year';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              CustomInputField(
                label: 'Image URL',
                hint: 'Enter image URL',
                controller: _imageController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingL),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'Cancel',
                    onPressed: _hideAddCandidateForm,
                    isOutlined: true,
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  CustomButton(
                    text: 'Add Candidate',
                    onPressed: _handleAddCandidate,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCandidateList() {
    return Card(
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _candidates.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final candidate = _candidates[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(candidate['image']),
                ),
                title: Text(candidate['name']),
                subtitle: Text(
                  '${candidate['position']} • ${candidate['department']} • ${candidate['year']}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStatusChip(candidate['status']),
                    const SizedBox(width: AppTheme.spacingS),
                    PopupMenuButton<String>(
                      onSelected: (value) => _handleUpdateStatus(
                        candidate['id'],
                        value,
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'Active',
                          child: Text('Set Active'),
                        ),
                        const PopupMenuItem(
                          value: 'Pending',
                          child: Text('Set Pending'),
                        ),
                        const PopupMenuItem(
                          value: 'Inactive',
                          child: Text('Set Inactive'),
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.candidateProfile,
                    arguments: {
                      'candidateId': candidate['id'],
                      'candidateName': candidate['name'],
                      'candidateImage': candidate['image'],
                      'candidatePosition': candidate['position'],
                      'candidateDescription': '${candidate['department']} • ${candidate['year']}',
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Active':
        color = Colors.green;
        break;
      case 'Pending':
        color = Colors.orange;
        break;
      case 'Inactive':
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