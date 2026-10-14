import 'package:flutter/material.dart';

import 'register_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int currentIndex = 0;

  // Theme colors
  static const Color navy = Color(0xFF123E83);
  static const Color orange = Color(0xFFFF9F1C);
  static const Color background = Color(0xFFF8FBFF);
  static const Color lightBlue = Color(0xFFEAF4FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // ---------------- BODY ----------------
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeSection(),
                    _buildSearchBox(),
                    _buildOverviewSection(),
                    _buildBatchesSection(),
                    _buildQuickActionsSection(),
                    _buildRecentActivitySection(),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ---------------- BOTTOM NAVIGATION ----------------
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 15, 16),
      decoration: const BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          // Menu
          IconButton(
            onPressed: () {
              _showMenu();
            },
            icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          ),

          const SizedBox(width: 5),

          // Title
          const Expanded(
            child: Text(
              'Admin Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Profile
          GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = 3;
              });
            },
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(Icons.person, color: navy, size: 27),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // WELCOME SECTION
  // =========================================================

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 25, 22, 15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome, Admin 👋',
                  style: TextStyle(
                    color: navy,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  'Polytechnic Student Database',
                  style: TextStyle(
                    color: navy.withValues(alpha: 0.65),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Education illustration
          Container(
            height: 82,
            width: 105,
            decoration: BoxDecoration(
              color: lightBlue,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 10,
                  left: 15,
                  child: Icon(Icons.menu_book_rounded, size: 48, color: orange),
                ),
                Positioned(
                  top: 8,
                  right: 12,
                  child: Icon(Icons.school_rounded, size: 48, color: navy),
                ),
                Positioned(
                  bottom: 8,
                  right: 12,
                  child: Icon(
                    Icons.storage_rounded,
                    size: 30,
                    color: navy.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SEARCH BOX
  // =========================================================

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 62,
        padding: const EdgeInsets.only(left: 18, right: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: navy.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: navy.withValues(alpha: 0.65), size: 28),

            const SizedBox(width: 12),

            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter Board Roll No.',
                  hintStyle: TextStyle(color: Color(0xFF7A8CA8), fontSize: 15),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(),
            TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.person_add_alt_1),
              label: const Text('Register'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF123E83),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Search button
            Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                color: orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search, color: Colors.white, size: 25),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // OVERVIEW
  // =========================================================

  Widget _buildOverviewSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Overview'),

          const SizedBox(height: 15),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.55,
            children: [
              _statCard(
                title: 'Students',
                value: '0',
                icon: Icons.groups_rounded,
                iconColor: navy,
                backgroundColor: const Color(0xFFEAF4FF),
              ),

              _statCard(
                title: 'Batches',
                value: '0',
                icon: Icons.library_books_rounded,
                iconColor: orange,
                backgroundColor: const Color(0xFFFFF5E5),
              ),

              _statCard(
                title: 'Active',
                value: '0',
                icon: Icons.check_circle_rounded,
                iconColor: const Color(0xFF28A879),
                backgroundColor: const Color(0xFFE9FAF4),
              ),

              _statCard(
                title: 'Updated',
                value: '0',
                icon: Icons.sync_rounded,
                iconColor: const Color(0xFF7357D9),
                backgroundColor: const Color(0xFFF0EDFF),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: iconColor.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 23),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: navy.withValues(alpha: 0.85),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BATCHES
  // =========================================================

  Widget _buildBatchesSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _sectionTitle('Batches')),

              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: navy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, color: navy, size: 18),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          SizedBox(
            height: 145,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                _batchCard(
                  year: '2024 - 2027',
                  students: '120 Students',
                  iconColor: navy,
                ),

                const SizedBox(width: 14),

                _batchCard(
                  year: '2025 - 2028',
                  students: '135 Students',
                  iconColor: orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _batchCard({
    required String year,
    required String students,
    required Color iconColor,
  }) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: iconColor.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.school_rounded, color: iconColor, size: 25),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      year,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      students,
                      style: TextStyle(
                        color: navy.withValues(alpha: 0.6),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View',
                  style: TextStyle(
                    color: iconColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(Icons.arrow_forward, color: iconColor, size: 17),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // QUICK ACTIONS
  // =========================================================

  Widget _buildQuickActionsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle('Quick Actions'),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: _actionCard(
                  title: 'Add Student',
                  icon: Icons.person_add_alt_1_rounded,
                  color: navy,
                  onTap: () {},
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _actionCard(
                  title: 'Attendance',
                  icon: Icons.bar_chart_rounded,
                  color: const Color(0xFFFFBD3F),
                  onTap: () {},
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _actionCard(
                  title: 'Marks',
                  icon: Icons.edit_note_rounded,
                  color: const Color(0xFF35AD82),
                  onTap: () {},
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _actionCard(
                  title: 'Results',
                  icon: Icons.assignment_turned_in_outlined,
                  color: const Color(0xFF8064D8),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 115,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 25),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // RECENT ACTIVITY
  // =========================================================

  Widget _buildRecentActivitySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _sectionTitle('Recent Activity')),

              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: navy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, color: navy, size: 18),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: navy.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _activityItem(
                  icon: Icons.description_outlined,
                  iconColor: navy,
                  title: 'Student marks updated',
                  time: '2m ago',
                  showDivider: true,
                ),

                _activityItem(
                  icon: Icons.person_add_alt_1,
                  iconColor: const Color(0xFF35AD82),
                  title: 'New student added',
                  time: '10m ago',
                  showDivider: true,
                ),

                _activityItem(
                  icon: Icons.calendar_month_outlined,
                  iconColor: orange,
                  title: 'Attendance updated',
                  time: '20m ago',
                  showDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String time,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Row(
            children: [
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF425675),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Text(
                time,
                style: TextStyle(
                  color: navy.withValues(alpha: 0.55),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        if (showDivider)
          Divider(
            height: 1,
            indent: 15,
            endIndent: 15,
            color: navy.withValues(alpha: 0.08),
          ),
      ],
    );
  }

  // =========================================================
  // SECTION TITLE
  // =========================================================

  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: navy,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Container(
          height: 4,
          width: 38,
          decoration: BoxDecoration(
            color: orange,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: navy.withValues(alpha: 0.10),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(index: 0, icon: Icons.home_rounded, label: 'Home'),

            _navItem(index: 1, icon: Icons.groups_rounded, label: 'Students'),

            _navItem(index: 2, icon: Icons.bar_chart_rounded, label: 'Records'),

            _navItem(index: 3, icon: Icons.person_rounded, label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool selected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 18 : 13,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected ? navy : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : const Color(0xFF7890B0),
              size: 23,
            ),

            const SizedBox(height: 3),

            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF7890B0),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // MENU
  // =========================================================

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                _menuItem(Icons.dashboard_outlined, 'Dashboard'),

                _menuItem(Icons.people_outline, 'Manage Students'),

                _menuItem(Icons.assessment_outlined, 'Records'),

                _menuItem(Icons.settings_outlined, 'Settings'),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: navy),
      title: Text(
        title,
        style: const TextStyle(color: navy, fontWeight: FontWeight.w600),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
