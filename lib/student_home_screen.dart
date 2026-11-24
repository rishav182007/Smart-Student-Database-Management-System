import 'package:flutter/material.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int selectedIndex = 0;

  // Theme colors
  static const Color primaryColor = Color(0xFF1A73E8);
  static const Color backgroundColor = Color(0xFFF5F7FB);

  // Sample student information
  final Map<String, dynamic> student = {
    'name': 'Rishav ',
    'rollNo': '240810204039',
    'branch': 'Computer Engineering',
    'batch': '2024 - 2027',
    'semester': '5th Semester',
    'college': 'Govt. Polytechnic Hamirpur',
  };

  // Sample academic information
  final double attendance = 85.0;

  final List<Map<String, dynamic>> subjects = [
    {'name': 'Software Engineering', 'attended': 42, 'total': 50},
    {'name': 'Web Programming', 'attended': 45, 'total': 50},
    {'name': 'E-Governance', 'attended': 38, 'total': 45},
    {'name': 'FOSS', 'attended': 40, 'total': 48},
  ];

  final List<Map<String, dynamic>> results = [
    {'subject': 'Software Engineering', 'marks': '85/100'},
    {'subject': 'Web Programming', 'marks': '90/100'},
    {'subject': 'E-Governance', 'marks': '78/100'},
  ];

  final List<Map<String, dynamic>> semesterRecords = [
    {'semester': 'Semester 1', 'status': 'Completed'},
    {'semester': 'Semester 2', 'status': 'Completed'},
    {'semester': 'Semester 3', 'status': 'Completed'},
    {'semester': 'Semester 4', 'status': 'Completed'},
    {'semester': 'Semester 5', 'status': 'Current'},
    {'semester': 'Semester 6', 'status': 'Upcoming'},
  ];

  Widget buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.12),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF202B3C),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildStudentHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Student Data',
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 38, color: primaryColor),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${student['name']}!',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Roll No: ${student['rollNo']}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '${student['branch']} | ${student['batch']}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAttendanceCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_month, color: primaryColor),
              SizedBox(width: 8),
              Text(
                'Overall Attendance',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Attendance Percentage',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '${attendance.toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: attendance / 100,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Attendance summary for the current semester',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget buildAttendanceDetails() {
    return Column(
      children: subjects.map((subject) {
        final int attended = subject['attended'];
        final int total = subject['total'];
        final double percentage = attended / total;

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      subject['name'],
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    '${(percentage * 100).toStringAsFixed(1)}%',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: percentage,
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.grey.shade200,
                color: primaryColor,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$attended / $total Lectures Attended',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget buildSemesterRecords() {
    return Column(
      children: semesterRecords.map((record) {
        final bool current = record['status'] == 'Current';
        final bool completed = record['status'] == 'Completed';

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.school_outlined,
                color: current
                    ? Colors.orange
                    : completed
                    ? Colors.green
                    : Colors.grey,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  record['semester'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                record['status'],
                style: TextStyle(
                  fontSize: 12,
                  color: current
                      ? Colors.orange
                      : completed
                      ? Colors.green
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget buildMarksDetails() {
    return Column(
      children: results.map((result) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.menu_book, color: primaryColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  result['subject'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                result['marks'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget buildFineCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFFFF0E6),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.deepOrange,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Pending Fine',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 5),
                Text(
                  '₹ 0',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.visibility_outlined, color: Colors.grey),
        ],
      ),
    );
  }

  Widget buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStudentHeader(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSectionTitle('Academic Overview'),

                Row(
                  children: [
                    Expanded(
                      child: buildInfoCard(
                        icon: Icons.calendar_month,
                        title: 'Attendance',
                        value: '${attendance.toInt()}%',
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildInfoCard(
                        icon: Icons.school,
                        title: 'Semester',
                        value: '05',
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),

                buildSectionTitle('Student Information'),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      buildDetailRow('Student Name', student['name']),
                      buildDetailRow('Board Roll No.', student['rollNo']),
                      buildDetailRow('Branch', student['branch']),
                      buildDetailRow('Batch', student['batch']),
                      buildDetailRow('Semester', student['semester']),
                      buildDetailRow('College', student['college']),
                    ],
                  ),
                ),

                buildSectionTitle(
                  'Attendance Details',
                  subtitle: 'Subject-wise attendance summary',
                ),
                buildAttendanceCard(),
                const SizedBox(height: 12),
                buildAttendanceDetails(),

                buildSectionTitle('Semester Records'),
                buildSemesterRecords(),

                buildSectionTitle(
                  'Examination & Marks',
                  subtitle: 'Your latest academic results',
                ),
                buildMarksDetails(),

                buildSectionTitle('Fine Details'),
                buildFineCard(),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: buildHomePage()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
