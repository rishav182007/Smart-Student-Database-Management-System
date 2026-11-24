import 'package:flutter/material.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  static const Color primaryColor = Color(0xFF194487);
  static const Color backgroundColor = Color(0xFFF5F9FF);
  static const Color orangeColor = Color(0xFFFFA629);

  final String adminName = 'Admin';
  final String adminId = 'ADMIN001';
  final String email = 'admin@gmail.com';
  final String phone = '9876543210';
  final String college = 'Govt. Polytechnic Hamirpur';
  final String role = 'Administrator';

  Widget informationCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8EFF8)),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryColor, size: 22),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
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

      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Admin Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Admin Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: orangeColor, width: 3),
                      ),
                      child: const CircleAvatar(
                        radius: 43,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.admin_panel_settings,
                          color: primaryColor,
                          size: 48,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      adminName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      role,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 13),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: orangeColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Admin ID: $adminId',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Personal Information Heading
              const Text(
                'Admin Information',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              const SizedBox(height: 14),

              // Information Cards
              informationCard(
                icon: Icons.person_outline,
                title: 'Full Name',
                value: adminName,
              ),

              informationCard(
                icon: Icons.badge_outlined,
                title: 'Admin ID',
                value: adminId,
              ),

              informationCard(
                icon: Icons.email_outlined,
                title: 'Email Address',
                value: email,
              ),

              informationCard(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                value: phone,
              ),

              informationCard(
                icon: Icons.school_outlined,
                title: 'College Name',
                value: college,
              ),

              informationCard(
                icon: Icons.admin_panel_settings_outlined,
                title: 'Account Role',
                value: role,
              ),

              const SizedBox(height: 10),

              // Footer
              Center(
                child: Text(
                  'Smart Student Database Management System',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
