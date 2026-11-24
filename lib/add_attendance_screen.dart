import 'package:flutter/material.dart';

class AddAttendanceScreen extends StatefulWidget {
  const AddAttendanceScreen({super.key});

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  // Dashboard Theme Colors
  static const Color navy = Color(0xFF194487);
  static const Color background = Color(0xFFF5F9FF);
  static const Color orange = Color(0xFFFFA629);
  static const Color green = Color(0xFF30AD86);
  static const Color red = Color(0xFFE85B5B);

  // Class Details
  String? selectedBatch;
  String? selectedSemester;
  String? selectedSubject;
  String? lectureType;

  DateTime selectedDate = DateTime.now();

  final searchController = TextEditingController();

  // Demo Student List

  final List<Map<String, String>> students = [
    {'roll': '240810204001', 'name': 'Rahul Sharma'},
    {'roll': '240810204002', 'name': 'Aman Kumar'},
    {'roll': '240810204003', 'name': 'Priya Sharma'},
    {'roll': '240810204004', 'name': 'Rohit Verma'},
    {'roll': '240810204005', 'name': 'Anjali Thakur'},
    {'roll': '240810204006', 'name': 'Vikas Kumar'},
    {'roll': '240810204007', 'name': 'Neha Sharma'},
    {'roll': '240810204008', 'name': 'Mohit Singh'},
    {'roll': '240810204009', 'name': 'Karan Singh'},
    {'roll': '240810204010', 'name': 'Simran Sharma'},
  ];

  // true = Present, false = Absent
  final Map<String, bool> attendance = {};

  @override
  void initState() {
    super.initState();

    // Automatically mark all students Present
    for (var student in students) {
      attendance[student['roll']!] = true;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Attendance Calculations
  int get totalStudents => students.length;

  int get presentCount => attendance.values.where((value) => value).length;

  int get absentCount => totalStudents - presentCount;

  double get attendancePercentage =>
      totalStudents == 0 ? 0 : (presentCount / totalStudents) * 100;

  // Search Filter
  List<Map<String, String>> get filteredStudents {
    final query = searchController.text.toLowerCase();

    return students.where((student) {
      return student['name']!.toLowerCase().contains(query) ||
          student['roll']!.toLowerCase().contains(query);
    }).toList();
  }

  // Date Picker
  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: navy,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  // Section Heading
  Widget sectionHeading(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: navy, size: 21),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  color: navy,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 30,
            decoration: BoxDecoration(
              color: orange,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  // Dropdown Widget
  Widget dropdownField(
    String label,
    String? value,
    List<String> items,
    IconData icon,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.blueGrey, fontSize: 13),
          prefixIcon: Icon(icon, color: navy, size: 20),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.blueGrey.shade100),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.blueGrey.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: navy, width: 1.5),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item, style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // Date Card
  Widget dateCard() {
    return InkWell(
      onTap: pickDate,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.blueGrey.shade100),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_outlined, color: navy),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attendance Date',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${selectedDate.day.toString().padLeft(2, '0')}/'
                    '${selectedDate.month.toString().padLeft(2, '0')}/'
                    '${selectedDate.year}',
                    style: const TextStyle(
                      color: navy,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.edit_calendar, color: orange),
          ],
        ),
      ),
    );
  }

  // Mark All Present
  void markAllPresent() {
    setState(() {
      for (var student in students) {
        attendance[student['roll']!] = true;
      }
    });
  }

  // Toggle Student Attendance
  void toggleAttendance(String roll) {
    setState(() {
      attendance[roll] = !(attendance[roll] ?? true);
    });
  }

  // Student Card
  Widget studentCard(Map<String, String> student) {
    final roll = student['roll']!;
    final name = student['name']!;
    final isPresent = attendance[roll] ?? true;

    return InkWell(
      onTap: () => toggleAttendance(roll),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isPresent ? Colors.blueGrey.shade100 : red.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 21,
              backgroundColor: const Color(0xFFE9F0FB),
              child: Text(
                name[0],
                style: const TextStyle(
                  color: navy,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: navy,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Roll No: $roll',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
              decoration: BoxDecoration(
                color: isPresent
                    ? green.withOpacity(0.12)
                    : red.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPresent ? Icons.check_circle : Icons.cancel,
                    color: isPresent ? green : red,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    isPresent ? 'Present' : 'Absent',
                    style: TextStyle(
                      color: isPresent ? green : red,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Summary Card
  Widget summaryCard(String title, String value, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 23),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(color: Colors.blueGrey, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  // Attendance Percentage Card
  Widget percentageCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attendance Percentage',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 13),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: attendancePercentage / 100,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(green),
            ),
          ),
          const SizedBox(height: 9),
          Text(
            '${attendancePercentage.toStringAsFixed(1)}% Present',
            style: const TextStyle(
              color: green,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  // Save Attendance - UI Only
  void saveAttendance() {
    if (selectedBatch == null ||
        selectedSemester == null ||
        selectedSubject == null ||
        lectureType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select all class details first.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          'Attendance Summary',
          style: TextStyle(color: navy, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Batch: $selectedBatch\n'
          'Semester: $selectedSemester\n'
          'Subject: $selectedSubject\n'
          'Lecture: $lectureType\n'
          'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}\n\n'
          'Total Students: $totalStudents\n'
          'Present: $presentCount\n'
          'Absent: $absentCount\n'
          'Attendance: ${attendancePercentage.toStringAsFixed(1)}%\n\n'
          'This is a UI demo. Data is not permanently saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: navy)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // AppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: navy,
          elevation: 0,
          centerTitle: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(23)),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Add Attendance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: navy,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: navy.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xFF42679D),
                      child: Icon(
                        Icons.fact_check_outlined,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mark Attendance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Mark only absent students',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Class Information
              sectionHeading('Class Information', Icons.school_outlined),

              dropdownField(
                'Select Batch',
                selectedBatch,
                ['2024 - 2027', '2025 - 2028', '2026 - 2029'],
                Icons.groups_outlined,
                (value) => setState(() => selectedBatch = value),
              ),

              dropdownField(
                'Select Semester',
                selectedSemester,
                ['1', '2', '3', '4', '5', '6'],
                Icons.menu_book_outlined,
                (value) => setState(() => selectedSemester = value),
              ),

              dropdownField(
                'Select Subject',
                selectedSubject,
                [
                  'Data Structures',
                  'Database Management System',
                  'Software Engineering',
                  'Web Programming',
                  'Computer Networks',
                  'Operating System',
                ],
                Icons.book_outlined,
                (value) => setState(() => selectedSubject = value),
              ),

              dateCard(),

              dropdownField(
                'Lecture Type',
                lectureType,
                ['Theory', 'Lab'],
                Icons.category_outlined,
                (value) => setState(() => lectureType = value),
              ),

              // Student Attendance - FIRST
              sectionHeading('Student Attendance', Icons.people_alt_outlined),

              // Instruction
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF1FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: navy, size: 20),
                    SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        'All students are marked Present by default. '
                        'Tap only the absent students.',
                        style: TextStyle(color: navy, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 13),

              // Search Students
              TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search name or roll number...',
                  prefixIcon: const Icon(Icons.search, color: navy),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            searchController.clear();
                            setState(() {});
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey.shade100),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide(color: Colors.blueGrey.shade100),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Mark All Present
              SizedBox(
                width: double.infinity,
                height: 43,
                child: OutlinedButton.icon(
                  onPressed: markAllPresent,
                  icon: const Icon(Icons.check_circle_outline, size: 19),
                  label: const Text(
                    'Mark All Present',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: green,
                    side: const BorderSide(color: green),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Student List Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Student List',
                    style: TextStyle(
                      color: navy,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$presentCount Present / $absentCount Absent',
                    style: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Student Cards
              if (filteredStudents.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: Text('No students found')),
                ),

              ...filteredStudents.map((student) => studentCard(student)),

              // Attendance Summary - AFTER STUDENT LIST
              sectionHeading('Attendance Summary', Icons.analytics_outlined),

              Row(
                children: [
                  summaryCard(
                    'Total',
                    '$totalStudents',
                    navy,
                    Icons.people_outline,
                  ),
                  const SizedBox(width: 9),
                  summaryCard(
                    'Present',
                    '$presentCount',
                    green,
                    Icons.check_circle_outline,
                  ),
                  const SizedBox(width: 9),
                  summaryCard(
                    'Absent',
                    '$absentCount',
                    red,
                    Icons.cancel_outlined,
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Attendance Percentage
              percentageCard(),

              const SizedBox(height: 20),

              // Save Attendance Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: saveAttendance,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text(
                    'Save Attendance',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navy,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
