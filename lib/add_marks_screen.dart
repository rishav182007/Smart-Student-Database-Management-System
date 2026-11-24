import 'package:flutter/material.dart';

class AddMarksScreen extends StatefulWidget {
  const AddMarksScreen({super.key});

  @override
  State<AddMarksScreen> createState() => _AddMarksScreenState();
}

class _AddMarksScreenState extends State<AddMarksScreen> {
  final Color navy = const Color(0xFF194487);
  final Color background = const Color(0xFFF5F9FF);
  final Color orange = const Color(0xFFFFA629);

  // Academic details
  String? selectedBatch = '2024 - 2027';
  String? selectedSemester = 'Semester 1';
  String? selectedSubject = 'FOSS';

  String selectedTest = 'Class Test 1';

  final List<String> subjects = [
    'FOSS',
    'E governance',
    'Cyber Laws and Ethics',
    'Web Programming',
    'Software Engineering',
  ];

  final List<String> tests = ['Class Test 1', 'Class Test 2', 'House Test'];

  final TextEditingController rollController = TextEditingController();

  // Student details from your original code
  final List<Map<String, String>> students = [
    {'name': 'Rahul Sharma', 'roll': '240800204001'},
    {'name': 'Sneha Gupta', 'roll': '240800204002'},
    {'name': 'Amit Singh', 'roll': '240800204003'},
    {'name': 'Priya Patel', 'roll': '240800204004'},
    {'name': 'Rohit Kumar', 'roll': '240800204005'},
    {'name': 'Anjali Verma', 'roll': '240800204006'},
    {'name': 'Vikas Sharma', 'roll': '240800204007'},
    {'name': 'Neha Singh', 'roll': '240800204008'},
    {'name': 'Mohit Gupta', 'roll': '240800204009'},
    {'name': 'Karan Patel', 'roll': '240800204010'},
  ];

  // Separate marks controllers for every test
  late final Map<String, Map<String, TextEditingController>> testControllers;

  // Demo saved marks, separately for each test
  final Map<String, Map<String, String>> savedMarks = {
    'Class Test 1': {},
    'Class Test 2': {},
    'House Test': {},
  };

  @override
  void initState() {
    super.initState();

    testControllers = {
      for (final test in tests)
        test: {
          for (final student in students)
            student['roll']!: TextEditingController(),
        },
    };
  }

  @override
  void dispose() {
    rollController.dispose();

    for (final test in testControllers.values) {
      for (final controller in test.values) {
        controller.dispose();
      }
    }

    super.dispose();
  }

  // Automatic maximum marks
  int get maximumMarks {
    return selectedTest == 'House Test' ? 60 : 30;
  }

  Map<String, TextEditingController> get currentControllers {
    return testControllers[selectedTest]!;
  }

  // Search students using name or board roll number
  List<Map<String, String>> get filteredStudents {
    final query = rollController.text.trim().toLowerCase();

    if (query.isEmpty) return students;

    return students.where((student) {
      return student['roll']!.toLowerCase().contains(query) ||
          student['name']!.toLowerCase().contains(query);
    }).toList();
  }

  int get enteredCount {
    return currentControllers.values
        .where((controller) => controller.text.trim().isNotEmpty)
        .length;
  }

  int get savedCount {
    return savedMarks[selectedTest]!.length;
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // Save marks only for students whose marks are entered
  void saveMarks() {
    if (selectedBatch == null ||
        selectedSemester == null ||
        selectedSubject == null) {
      showMessage('Please select all academic details.');
      return;
    }

    final enteredStudents = <String>[];

    for (final student in students) {
      final roll = student['roll']!;
      final value = currentControllers[roll]!.text.trim();

      if (value.isEmpty) continue;

      final marks = double.tryParse(value);

      if (marks == null || marks < 0 || marks > maximumMarks) {
        showMessage(
          'Enter valid marks between 0 and $maximumMarks for roll no. $roll.',
        );
        return;
      }

      enteredStudents.add(roll);
    }

    if (enteredStudents.isEmpty) {
      showMessage('Please enter marks for at least one student.');
      return;
    }

    for (final roll in enteredStudents) {
      savedMarks[selectedTest]![roll] = currentControllers[roll]!.text.trim();
    }

    setState(() {});

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Marks Saved'),
        content: Text(
          '$selectedTest marks saved successfully.\n\n'
          'Batch: $selectedBatch\n'
          'Semester: $selectedSemester\n'
          'Subject: $selectedSubject\n'
          'Maximum Marks: $maximumMarks\n'
          'Students saved now: ${enteredStudents.length}\n'
          'Total saved for this test: $savedCount\n\n'
          'Demo only: marks are not permanently stored yet.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void clearMarks() {
    for (final controller in currentControllers.values) {
      controller.clear();
    }

    savedMarks[selectedTest]!.clear();

    setState(() {});
  }

  Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildTestSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Test Type',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Row(
          children: tests.map((test) {
            final isSelected = selectedTest == test;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTest = test;
                    rollController.clear();
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 6),
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? navy : Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                      color: isSelected ? navy : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    test,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : navy,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildStudentCard(Map<String, String> student) {
    final roll = student['roll']!;
    final controller = currentControllers[roll]!;
    final isSaved = savedMarks[selectedTest]!.containsKey(roll);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5ECF5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFEAF1FF),
            child: Text(
              student['name']![0],
              style: TextStyle(color: navy, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Roll No: $roll',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                ),
                if (isSaved)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'Previously saved',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(
            width: 76,
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Marks',
                isDense: true,
                filled: true,
                fillColor: const Color(0xFFF5F8FD),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleStudents = filteredStudents;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Marks',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Student Marks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Enter marks for each test separately',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.edit_note_rounded, color: orange, size: 42),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Academic Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: buildDropdown(
                      label: 'Batch',
                      value: selectedBatch,
                      items: ['2024 - 2027', '2025 - 2028'],
                      onChanged: (v) {
                        setState(() => selectedBatch = v);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: buildDropdown(
                      label: 'Semester',
                      value: selectedSemester,
                      items: List.generate(6, (i) => 'Semester ${i + 1}'),
                      onChanged: (v) {
                        setState(() => selectedSemester = v);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Your original subject names
              buildDropdown(
                label: 'Subject',
                value: selectedSubject,
                items: subjects,
                onChanged: (v) {
                  setState(() => selectedSubject = v);
                },
              ),

              const SizedBox(height: 20),

              buildTestSelector(),

              const SizedBox(height: 16),

              // Automatic maximum marks
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFD6E3FA)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.stars_rounded, color: navy, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Maximum Marks',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '$maximumMarks Marks',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: navy,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      selectedTest == 'House Test'
                          ? 'House Test'
                          : 'Class Test',
                      style: TextStyle(
                        color: navy,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // Roll number search
              const Text(
                'Find Student by Roll Number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: rollController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Enter board roll number or student name',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      rollController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.close),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Student list
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Student List',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$enteredCount / ${students.length} Entered',
                    style: TextStyle(
                      color: navy,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              if (visibleStudents.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    'No student found with this roll number or name.',
                    textAlign: TextAlign.center,
                  ),
                )
              else
                ...visibleStudents.map(buildStudentCard),

              const SizedBox(height: 12),

              // Progress
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Marks Entry Progress',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '$enteredCount / ${students.length}',
                          style: TextStyle(
                            color: navy,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: enteredCount / students.length,
                      backgroundColor: Colors.grey.shade200,
                      color: navy,
                      minHeight: 7,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$savedCount students saved for $selectedTest',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: saveMarks,
                  icon: const Icon(Icons.save_rounded),
                  label: Text('Save $selectedTest Marks'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: clearMarks,
                  child: const Text('Clear Current Test Marks'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
