import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';
import '../../core/widgets/custom_button.dart';

class ElectionScheduleScreen extends StatefulWidget {
  const ElectionScheduleScreen({super.key});

  @override
  State<ElectionScheduleScreen> createState() => _ElectionScheduleScreenState();
}

class _ElectionScheduleScreenState extends State<ElectionScheduleScreen> {
  bool _isAddingElection = false;
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Upcoming', 'Ongoing', 'Completed'];

  final List<Map<String, dynamic>> _elections = [
    {
      'id': '1',
      'title': 'Student Council Election',
      'date': 'March 15, 2024',
      'startTime': '9:00 AM',
      'endTime': '5:00 PM',
      'status': 'Upcoming',
      'description': 'Annual election for Student Council positions',
      'positions': [
        'President',
        'Vice President',
        'Secretary',
        'Treasurer',
        'Auditor',
      ],
      'location': 'Main Campus',
      'organizer': 'Student Affairs Office',
    },
    {
      'id': '2',
      'title': 'Class Representative Election',
      'date': 'March 20, 2024',
      'startTime': '10:00 AM',
      'endTime': '4:00 PM',
      'status': 'Upcoming',
      'description': 'Election for class representatives',
      'positions': ['Class Representative'],
      'location': 'Department Buildings',
      'organizer': 'Department Heads',
    },
    {
      'id': '3',
      'title': 'Department Council Election',
      'date': 'February 28, 2024',
      'startTime': '9:00 AM',
      'endTime': '5:00 PM',
      'status': 'Completed',
      'description': 'Election for Department Council members',
      'positions': [
        'Department Representative',
        'Assistant Department Representative',
      ],
      'location': 'Department Buildings',
      'organizer': 'Department Heads',
    },
  ];

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _organizerController = TextEditingController();
  final List<String> _selectedPositions = [];

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _organizerController.dispose();
    super.dispose();
  }

  void _showAddElectionForm() {
    setState(() {
      _isAddingElection = true;
    });
  }

  void _hideAddElectionForm() {
    setState(() {
      _isAddingElection = false;
      _titleController.clear();
      _dateController.clear();
      _startTimeController.clear();
      _endTimeController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _organizerController.clear();
      _selectedPositions.clear();
    });
  }

  void _handleAddElection() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement adding election
      _hideAddElectionForm();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Election added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  List<Map<String, dynamic>> _getFilteredElections() {
    if (_selectedFilter == 'All') {
      return _elections;
    }
    return _elections.where((election) => election['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Election Schedule'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _filters.map((filter) => ListTile(
                    title: Text(filter),
                    selected: filter == _selectedFilter,
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                      Navigator.pop(context);
                    },
                  )).toList(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          if (_isAddingElection) _buildAddElectionForm(),
          Expanded(
            child: _buildElectionList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isAddingElection ? null : _showAddElectionForm,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      color: AppTheme.primaryColor.withOpacity(0.1),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Election Schedule',
                  style: AppTheme.headingStyle,
                ),
                const SizedBox(height: AppTheme.spacingS),
                Text(
                  'View and manage upcoming elections',
                  style: AppTheme.bodyStyle,
                ),
              ],
            ),
          ),
          Chip(
            label: Text(_selectedFilter),
            backgroundColor: AppTheme.primaryColor,
            labelStyle: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAddElectionForm() {
    return Card(
      margin: const EdgeInsets.all(AppTheme.spacingM),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Election',
                style: AppTheme.subheadingStyle,
              ),
              const SizedBox(height: AppTheme.spacingM),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) {
                          _dateController.text = '${date.month}/${date.day}/${date.year}';
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a date';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: TextFormField(
                      controller: _startTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Start Time',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          _startTimeController.text = time.format(context);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select start time';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: TextFormField(
                      controller: _endTimeController,
                      decoration: const InputDecoration(
                        labelText: 'End Time',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          _endTimeController.text = time.format(context);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select end time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingM),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              TextFormField(
                controller: _organizerController,
                decoration: const InputDecoration(
                  labelText: 'Organizer',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an organizer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingM),
              Wrap(
                spacing: AppTheme.spacingS,
                children: [
                  'President',
                  'Vice President',
                  'Secretary',
                  'Treasurer',
                  'Auditor',
                  'Class Representative',
                  'Department Representative',
                ].map((position) => FilterChip(
                  label: Text(position),
                  selected: _selectedPositions.contains(position),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedPositions.add(position);
                      } else {
                        _selectedPositions.remove(position);
                      }
                    });
                  },
                )).toList(),
              ),
              const SizedBox(height: AppTheme.spacingM),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Cancel',
                      onPressed: _hideAddElectionForm,
                      isOutlined: true,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: CustomButton(
                      text: 'Add Election',
                      onPressed: _handleAddElection,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElectionList() {
    final filteredElections = _getFilteredElections();
    if (filteredElections.isEmpty) {
      return Center(
        child: Text(
          'No ${_selectedFilter.toLowerCase()} elections',
          style: AppTheme.bodyStyle,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      itemCount: filteredElections.length,
      itemBuilder: (context, index) {
        final election = filteredElections[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
          child: ExpansionTile(
            title: Text(
              election['title'],
              style: AppTheme.subheadingStyle,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppTheme.spacingS),
                Text(
                  '${election['date']} • ${election['startTime']} - ${election['endTime']}',
                  style: AppTheme.bodyStyle,
                ),
                const SizedBox(height: AppTheme.spacingS),
                _buildStatusChip(election['status']),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: AppTheme.bodyStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Text(election['description']),
                    const SizedBox(height: AppTheme.spacingM),
                    Text(
                      'Positions',
                      style: AppTheme.bodyStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Wrap(
                      spacing: AppTheme.spacingS,
                      children: (election['positions'] as List<String>).map((position) => Chip(
                        label: Text(position),
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      )).toList(),
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    Text(
                      'Location',
                      style: AppTheme.bodyStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Text(election['location']),
                    const SizedBox(height: AppTheme.spacingM),
                    Text(
                      'Organizer',
                      style: AppTheme.bodyStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Text(election['organizer']),
                    const SizedBox(height: AppTheme.spacingM),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: 'View Details',
                            onPressed: () {
                              // TODO: Implement view details
                            },
                            isOutlined: true,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingM),
                        Expanded(
                          child: CustomButton(
                            text: 'Edit',
                            onPressed: () {
                              // TODO: Implement edit
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Upcoming':
        color = Colors.blue;
        break;
      case 'Ongoing':
        color = Colors.green;
        break;
      case 'Completed':
        color = Colors.grey;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(
        status,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
  }
} 