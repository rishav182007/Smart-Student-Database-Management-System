import 'package:flutter/material.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  final Color primaryColor = const Color(0xFF194487);
  final Color backgroundColor = const Color(0xFFF5F9FF);
  final Color orangeColor = const Color(0xFFFFA629);

  String? selectedBatch;
  String? selectedBranch;
  int? selectedSemester;

  final TextEditingController searchController = TextEditingController();

  final List<String> batches = ['2024 - 2027', '2025 - 2028', '2026 - 2029'];

  final List<String> branches = [
    'Computer Engineering',
    'Civil Engineering',
    'Mechanical Engineering',
    'Electrical Engineering',
  ];

  final List<Map<String, String>> students = [
    {
      'name': 'Rahul Sharma',
      'roll': '240800204001',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
    {
      'name': 'Sneha Gupta',
      'roll': '240800204002',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
    {
      'name': 'Amit Singh',
      'roll': '240800204003',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
    {
      'name': 'Priya Patel',
      'roll': '240800204004',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
    {
      'name': 'Rohit Kumar',
      'roll': '240800204005',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
    {
      'name': 'Anjali Verma',
      'roll': '240800204006',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
    {
      'name': 'Vikas Sharma',
      'roll': '240800204007',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
    {
      'name': 'Neha Singh',
      'roll': '240800204008',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
    {
      'name': 'Mohit Gupta',
      'roll': '240800204009',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
    {
      'name': 'Karan Patel',
      'roll': '240800204010',
      'branch': 'Computer Engineering',
      'batch': '2024 - 2027',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void resetSelection() {
    setState(() {
      selectedBatch = null;
      selectedBranch = null;
      selectedSemester = null;
      searchController.clear();
    });
  }

  void selectBatch(String batch) {
    setState(() {
      selectedBatch = batch;
      selectedBranch = null;
      selectedSemester = null;
    });
  }

  void selectBranch(String branch) {
    setState(() {
      selectedBranch = branch;
      selectedSemester = null;
    });
  }

  List<Map<String, String>> get filteredStudents {
    final query = searchController.text.toLowerCase();

    return students.where((student) {
      final matchesBatch = student['batch'] == selectedBatch;
      final matchesBranch = student['branch'] == selectedBranch;
      final matchesSearch =
          student['name']!.toLowerCase().contains(query) ||
          student['roll']!.toLowerCase().contains(query);

      return matchesBatch && matchesBranch && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Students',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (selectedSemester != null) {
              setState(() => selectedSemester = null);
            } else if (selectedBranch != null) {
              setState(() => selectedBranch = null);
            } else if (selectedBatch != null) {
              setState(() => selectedBatch = null);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: resetSelection,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _buildCurrentPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    String subtitle = 'View and manage student records';

    if (selectedBatch != null) {
      subtitle = 'Batch: $selectedBatch';
    }
    if (selectedBranch != null) {
      subtitle = selectedBranch!;
    }
    if (selectedSemester != null) {
      subtitle = 'Semester $selectedSemester';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Student Directory',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _stepIndicator('Batch', selectedBatch != null),
              _stepLine(),
              _stepIndicator('Branch', selectedBranch != null),
              _stepLine(),
              _stepIndicator('Semester', selectedSemester != null),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepIndicator(String title, bool completed) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: completed ? orangeColor : Colors.white24,
            child: Icon(
              completed ? Icons.check : Icons.circle_outlined,
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _stepLine() {
    return Container(
      height: 2,
      width: 20,
      color: Colors.white38,
      margin: const EdgeInsets.only(bottom: 18),
    );
  }

  Widget _buildCurrentPage() {
    if (selectedSemester != null) {
      return _buildStudentList();
    }

    if (selectedBranch != null) {
      return _buildSemesterSelection();
    }

    if (selectedBatch != null) {
      return _buildBranchSelection();
    }

    return _buildBatchSelection();
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchSelection() {
    return Column(
      key: const ValueKey('batch'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Select Batch', 'Choose the academic batch to continue'),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: batches.length,
            itemBuilder: (context, index) {
              return _selectionCard(
                icon: Icons.calendar_month,
                title: batches[index],
                subtitle: 'Academic Batch',
                onTap: () => selectBatch(batches[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBranchSelection() {
    return Column(
      key: const ValueKey('branch'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle('Select Branch', 'Choose the branch of $selectedBatch'),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: branches.length,
            itemBuilder: (context, index) {
              return _selectionCard(
                icon: Icons.account_tree_outlined,
                title: branches[index],
                subtitle: 'View students of this branch',
                onTap: () => selectBranch(branches[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSemesterSelection() {
    return Column(
      key: const ValueKey('semester'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Select Semester',
          'Choose semester to view the student list',
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(18),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.65,
            ),
            itemBuilder: (context, index) {
              final semester = index + 1;

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  setState(() {
                    selectedSemester = semester;
                    searchController.clear();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: primaryColor.withOpacity(0.12)),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        color: primaryColor,
                        size: 27,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Semester $semester',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStudentList() {
    final list = filteredStudents;

    return Column(
      key: const ValueKey('students'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          'Student List',
          '$selectedBranch • $selectedBatch • Semester $selectedSemester',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: TextField(
            controller: searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search name or roll number',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close),
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Students',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                '${list.length} Records',
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ],
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? const Center(
                  child: Text(
                    'No students found',
                    style: TextStyle(color: Colors.black54),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(18, 4, 18, 20),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final student = list[index];
                    return _studentCard(student);
                  },
                ),
        ),
      ],
    );
  }

  Widget _selectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(17),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: primaryColor.withOpacity(0.10)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: primaryColor, size: 25),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: orangeColor, size: 17),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _studentCard(Map<String, String> student) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryColor.withOpacity(0.10)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.04),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 23,
            backgroundColor: backgroundColor,
            child: Icon(Icons.person, color: primaryColor, size: 25),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student['name']!,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                _studentDetail('Branch', student['branch']!),
                _studentDetail('Batch', student['batch']!),
                _studentDetail('Board Roll No', student['roll']!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _studentDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 12, color: Colors.black54),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
