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
  bool _isEditingElection = false;
  String? _editingElectionId;
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
      'candidates': [
        {
          'position': 'President',
          'candidates': ['John Doe', 'Jane Smith']
        },
        {
          'position': 'Vice President',
          'candidates': ['Mike Johnson', 'Sarah Wilson']
        }
      ]
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
      'candidates': []
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
      'candidates': [
        {
          'position': 'Department Representative',
          'candidates': ['Alice Brown', 'Bob Davis']
        }
      ]
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
  String _selectedStatus = 'Upcoming';
  List<Map<String, dynamic>> _editingCandidates = [];

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
      _isEditingElection = false;
      _editingElectionId = null;
    });
  }

  void _showEditElectionForm(Map<String, dynamic> election) {
    setState(() {
      _isEditingElection = true;
      _isAddingElection = false;
      _editingElectionId = election['id'];

      // Populate form fields with existing data
      _titleController.text = election['title'];
      _dateController.text = election['date'];
      _startTimeController.text = election['startTime'];
      _endTimeController.text = election['endTime'];
      _descriptionController.text = election['description'];
      _locationController.text = election['location'];
      _organizerController.text = election['organizer'];
      _selectedPositions.clear();
      _selectedPositions.addAll(List<String>.from(election['positions']));
      _selectedStatus = election['status'];

      // Initialize candidates for editing
      _editingCandidates = List<Map<String, dynamic>>.from(
          election['candidates'] ?? []
      );

      // Ensure all positions have candidate entries
      for (String position in _selectedPositions) {
        bool hasEntry = _editingCandidates.any((c) => c['position'] == position);
        if (!hasEntry) {
          _editingCandidates.add({
            'position': position,
            'candidates': <String>[]
          });
        }
      }
    });
  }

  void _hideForm() {
    setState(() {
      _isAddingElection = false;
      _isEditingElection = false;
      _editingElectionId = null;
      _titleController.clear();
      _dateController.clear();
      _startTimeController.clear();
      _endTimeController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _organizerController.clear();
      _selectedPositions.clear();
      _selectedStatus = 'Upcoming';
      _editingCandidates.clear();
    });
  }

  void _handleAddElection() {
    if (_formKey.currentState!.validate()) {
      final newElection = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': _titleController.text,
        'date': _dateController.text,
        'startTime': _startTimeController.text,
        'endTime': _endTimeController.text,
        'status': _selectedStatus,
        'description': _descriptionController.text,
        'positions': List<String>.from(_selectedPositions),
        'location': _locationController.text,
        'organizer': _organizerController.text,
        'candidates': List<Map<String, dynamic>>.from(_editingCandidates),
      };

      setState(() {
        _elections.add(newElection);
      });

      _hideForm();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Election added successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _handleEditElection() {
    if (_formKey.currentState!.validate()) {
      final electionIndex = _elections.indexWhere((e) => e['id'] == _editingElectionId);
      if (electionIndex != -1) {
        setState(() {
          _elections[electionIndex] = {
            'id': _editingElectionId,
            'title': _titleController.text,
            'date': _dateController.text,
            'startTime': _startTimeController.text,
            'endTime': _endTimeController.text,
            'status': _selectedStatus,
            'description': _descriptionController.text,
            'positions': List<String>.from(_selectedPositions),
            'location': _locationController.text,
            'organizer': _organizerController.text,
            'candidates': List<Map<String, dynamic>>.from(_editingCandidates),
          };
        });

        _hideForm();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Election updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _addCandidateToPosition(String position) {
    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text('Add Candidate for $position'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Candidate Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  setState(() {
                    final candidateEntry = _editingCandidates.firstWhere(
                            (c) => c['position'] == position,
                        orElse: () {
                          final newEntry = {
                            'position': position,
                            'candidates': <String>[]
                          };
                          _editingCandidates.add(newEntry);
                          return newEntry;
                        }
                    );
                    (candidateEntry['candidates'] as List<String>).add(controller.text);
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _removeCandidateFromPosition(String position, String candidate) {
    setState(() {
      final candidateEntry = _editingCandidates.firstWhere(
            (c) => c['position'] == position,
      );
      (candidateEntry['candidates'] as List<String>).remove(candidate);
    });
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
          if (_isAddingElection || _isEditingElection)
            Expanded(
              child: _buildElectionForm(),
            )
          else
            Expanded(
              child: _buildElectionList(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (_isAddingElection || _isEditingElection) ? null : _showAddElectionForm,
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
                  style: AppTheme.headingStyle.copyWith(
                    color: Colors.black,
                  ),
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

  Widget _buildElectionForm() {
    return Card(
        margin: const EdgeInsets.all(AppTheme.spacingM),
    child: Padding(
    padding: const EdgeInsets.all(AppTheme.spacingM),
    child: Form(
    key: _formKey,
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    _isEditingElection ? 'Edit Election' : 'Add New Election',
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
    DropdownButtonFormField<String>(
    value: _selectedStatus,
    decoration: const InputDecoration(
    labelText: 'Status',
    border: OutlineInputBorder(),
    ),
    items: ['Upcoming', 'Ongoing', 'Completed'].map((status) {
    return DropdownMenuItem(
    value: status,
    child: Text(status),
    );
    }).toList(),
    onChanged: (value) {
    setState(() {
    _selectedStatus = value!;
    });
    },
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
    Text(
    'Positions',
    style: AppTheme.bodyStyle.copyWith(fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: AppTheme.spacingS),
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
    // Add candidate entry for new position
    _editingCandidates.add({
    'position': position,
    'candidates': <String>[]
    });
    } else {
    _selectedPositions.remove(position);
    // Remove candidate entry for removed position
    _editingCandidates.removeWhere((c) => c['position'] == position);
    }
    });
    },
    )).toList(),
    ),
    if (_selectedPositions.isNotEmpty) ...[
    const SizedBox(height: AppTheme.spacingM),
    Text(
    'Candidates',
    style: AppTheme.bodyStyle.copyWith(fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: AppTheme.spacingS),
    ..._selectedPositions.map((position) => _buildCandidateSection(position)),
    ],
    const SizedBox(height: AppTheme.spacingM),
    Row(
    children: [
    Expanded(
    child: CustomButton(
    text: 'Cancel',
    onPressed: _hideForm,
    isOutlined: true,
    ),
    ),
    const SizedBox(width: AppTheme.spacingM),
    Expanded(
    child: CustomButton(
    text: _isEditingElection ? 'Update Election' : 'Add Election',
    onPressed: _isEditingElection ? _handleEditElection : _handleAddElection,
    ),
    ),
    ],
    ),
    ],
    ),
    ),
    ),
    ));
  }

  Widget _buildCandidateSection(String position) {
    final candidateEntry = _editingCandidates.firstWhere(
          (c) => c['position'] == position,
      orElse: () => {'position': position, 'candidates': <String>[]},
    );
    final candidates = candidateEntry['candidates'] as List<String>;

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingS),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  position,
                  style: AppTheme.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addCandidateToPosition(position),
                ),
              ],
            ),
            if (candidates.isEmpty)
              const Text('No candidates added yet')
            else
              Wrap(
                spacing: AppTheme.spacingS,
                children: candidates.map((candidate) => Chip(
                  label: Text(candidate),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted: () => _removeCandidateFromPosition(position, candidate),
                )).toList(),
              ),
          ],
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
                    if (election['candidates'] != null && (election['candidates'] as List).isNotEmpty) ...[
                      const SizedBox(height: AppTheme.spacingM),
                      Text(
                        'Candidates',
                        style: AppTheme.bodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingS),
                      ...(election['candidates'] as List<Map<String, dynamic>>).map((candidateEntry) {
                        final position = candidateEntry['position'] as String;
                        final candidates = candidateEntry['candidates'] as List<String>;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$position:',
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              if (candidates.isEmpty)
                                const Text('No candidates')
                              else
                                Wrap(
                                  spacing: AppTheme.spacingS,
                                  children: candidates.map((candidate) => Chip(
                                    label: Text(candidate),
                                    backgroundColor: Colors.green.withOpacity(0.1),
                                  )).toList(),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
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
                            onPressed: () => _showEditElectionForm(election),
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