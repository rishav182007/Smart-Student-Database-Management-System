import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final Color primaryColor = const Color(0xFF194487);
  final Color backgroundColor = const Color(0xFFF5F9FF);
  final Color orangeColor = const Color(0xFFFFA629);

  String selectedBatch = '2024 - 2027';

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> students = [
    {
      'name': 'Rahul Sharma',
      'roll': '240800204001',
      'sgpi': [8.2, 8.5, 7.9, 8.6, 8.3, 8.7],
      'cgpi': [8.2, 8.35, 8.20, 8.30, 8.30, 8.37],
    },
    {
      'name': 'Sneha Gupta',
      'roll': '240800204002',
      'sgpi': [8.8, 8.6, 9.0, 8.7, 8.9, 9.1],
      'cgpi': [8.8, 8.7, 8.8, 8.78, 8.8, 8.85],
    },
    {
      'name': 'Amit Singh',
      'roll': '240800204003',
      'sgpi': [7.5, 7.8, 8.0, 7.6, 8.1, 7.9],
      'cgpi': [7.5, 7.65, 7.77, 7.73, 7.80, 7.82],
    },
    {
      'name': 'Priya Patel',
      'roll': '240800204004',
      'sgpi': [9.0, 8.9, 9.2, 9.1, 8.8, 9.3],
      'cgpi': [9.0, 8.95, 9.03, 9.05, 9.0, 9.05],
    },
    {
      'name': 'Rohit Kumar',
      'roll': '240800204005',
      'sgpi': [7.2, 7.5, 7.8, 7.4, 7.6, 7.9],
      'cgpi': [7.2, 7.35, 7.50, 7.48, 7.50, 7.57],
    },
    {
      'name': 'Anjali Verma',
      'roll': '240800204006',
      'sgpi': [8.6, 8.8, 8.4, 8.9, 9.0, 8.7],
      'cgpi': [8.6, 8.7, 8.6, 8.68, 8.74, 8.73],
    },
    {
      'name': 'Vikas Sharma',
      'roll': '240800204007',
      'sgpi': [7.9, 8.1, 8.3, 8.0, 8.2, 8.4],
      'cgpi': [7.9, 8.0, 8.1, 8.08, 8.10, 8.15],
    },
    {
      'name': 'Neha Singh',
      'roll': '240800204008',
      'sgpi': [9.1, 9.0, 8.8, 9.2, 9.1, 9.3],
      'cgpi': [9.1, 9.05, 8.97, 9.03, 9.04, 9.08],
    },
    {
      'name': 'Mohit Gupta',
      'roll': '240800204009',
      'sgpi': [7.6, 7.9, 7.5, 7.8, 8.0, 7.7],
      'cgpi': [7.6, 7.75, 7.67, 7.70, 7.76, 7.75],
    },
    {
      'name': 'Karan Patel',
      'roll': '240800204010',
      'sgpi': [8.3, 8.0, 8.5, 8.2, 8.4, 8.6],
      'cgpi': [8.3, 8.15, 8.27, 8.25, 8.28, 8.33],
    },
  ];

  List<Map<String, dynamic>> get filteredStudents {
    final query = searchController.text.toLowerCase().trim();

    return students.where((student) {
      return student['name'].toString().toLowerCase().contains(query) ||
          student['roll'].toString().contains(query);
    }).toList();
  }

  Widget buildStudentCard(Map<String, dynamic> student) {
    final sgpi = student['sgpi'] as List<double>;
    final cgpi = student['cgpi'] as List<double>;

    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        leading: CircleAvatar(
          backgroundColor: primaryColor.withOpacity(0.1),
          child: Icon(Icons.person, color: primaryColor),
        ),
        title: Text(
          student['name'],
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            'Roll No: ${student['roll']}',
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ),
        children: [
          const Divider(),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Semester',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'SGPI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'CGPI',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: orangeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          ...List.generate(6, (index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                color: index.isEven ? backgroundColor : Colors.white,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Semester ${index + 1}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      sgpi[index].toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      cgpi[index].toStringAsFixed(2),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: orangeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
          'Student Results',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Academic Performance',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'SGPI & CGPI Results',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Semester-wise student performance',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Select Batch',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedBatch,
                isExpanded: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(
                    value: '2024 - 2027',
                    child: Text('2024 - 2027'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedBatch = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 18),

              // Search
              TextField(
                controller: searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search by name or board roll number',
                  hintStyle: const TextStyle(fontSize: 12),
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchController.clear();
                      setState(() {});
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Student list heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Student List',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Text(
                    '${filteredStudents.length} Students',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Table guide
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: orangeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFF194487),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tap on a student to view semester-wise SGPI and CGPI.',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              if (filteredStudents.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text('No student found'),
                  ),
                )
              else
                ...filteredStudents.map(buildStudentCard),
            ],
          ),
        ),
      ),
    );
  }
}
