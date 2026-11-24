import 'package:flutter/material.dart';

class RecordsScreen extends StatelessWidget {
  const RecordsScreen({super.key});

  static const Color primaryColor = Color(0xFF194487);
  static const Color backgroundColor = Color(0xFFF5F9FF);
  static const Color orangeColor = Color(0xFFFFA629);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Records',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Academic Records',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'View and manage all academic records',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(20, 23, 20, 14),
              child: Text(
                'Select Record Type',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                children: [
                  _recordCard(
                    context,
                    icon: Icons.calendar_month_outlined,
                    title: 'Attendance Records',
                    subtitle: 'View student attendance details',
                    page: const AttendanceRecordsPage(),
                  ),
                  _recordCard(
                    context,
                    icon: Icons.assignment_outlined,
                    title: 'Class Test Records',
                    subtitle: 'Class Test 1 and Class Test 2 marks',
                    page: const ClassTestRecordsPage(),
                  ),
                  _recordCard(
                    context,
                    icon: Icons.menu_book_outlined,
                    title: 'House Test Records',
                    subtitle: 'View house test marks',
                    page: const HouseTestRecordsPage(),
                  ),
                  _recordCard(
                    context,
                    icon: Icons.school_outlined,
                    title: 'Semester Results',
                    subtitle: 'View SGPI and CGPI records',
                    page: const SemesterRecordsPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(0.10)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: primaryColor, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
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
              const Icon(Icons.arrow_forward_ios, size: 17, color: orangeColor),
            ],
          ),
        ),
      ),
    );
  }
}

class AttendanceRecordsPage extends StatelessWidget {
  const AttendanceRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordPlaceholderPage(
      title: 'Attendance Records',
      icon: Icons.calendar_month,
    );
  }
}

class ClassTestRecordsPage extends StatelessWidget {
  const ClassTestRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordPlaceholderPage(
      title: 'Class Test Records',
      icon: Icons.assignment,
    );
  }
}

class HouseTestRecordsPage extends StatelessWidget {
  const HouseTestRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordPlaceholderPage(
      title: 'House Test Records',
      icon: Icons.menu_book,
    );
  }
}

class SemesterRecordsPage extends StatelessWidget {
  const SemesterRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecordPlaceholderPage(
      title: 'Semester Results',
      icon: Icons.school,
    );
  }
}

class RecordPlaceholderPage extends StatelessWidget {
  final String title;
  final IconData icon;

  const RecordPlaceholderPage({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RecordsScreen.backgroundColor,
      appBar: AppBar(
        backgroundColor: RecordsScreen.primaryColor,
        foregroundColor: Colors.white,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 55, color: RecordsScreen.primaryColor),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: RecordsScreen.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Record details will be displayed here.',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
