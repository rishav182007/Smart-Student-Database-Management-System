import 'package:flutter/material.dart';
import 'admin_login_screen.dart';
import 'register_screen.dart';
import 'student_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 70),

              // Logo
              Container(
                height: 110,
                width: 110,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF123E83).withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 25),

              // App Name
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Smart ',
                      style: TextStyle(
                        color: Color(0xFF123E83),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Student',
                      style: TextStyle(
                        color: Color(0xFFFF9F1C),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Database Management',
                style: TextStyle(
                  color: Color(0xFF123E83),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 65),

              const Text(
                'Login As',
                style: TextStyle(
                  color: Color(0xFF123E83),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Choose your account type to continue',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 30),

              // Admin Login
              _loginOption(
                context: context,
                title: 'Admin Login',
                subtitle: 'Manage students and database',
                icon: Icons.admin_panel_settings_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminLoginScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 18),

              // Student Login
              _loginOption(
                context: context,
                title: 'Student Login',
                subtitle: 'Access your student account',
                icon: Icons.school_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentLoginScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Text(
                  'Smart Student • Simplify Education',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE1ECF8)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF123E83).withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              height: 58,
              width: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FF),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, size: 32, color: const Color(0xFF123E83)),
            ),

            const SizedBox(width: 16),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF123E83),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Arrow
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Color(0xFFFF9F1C),
            ),
          ],
        ),
      ),
    );
  }
}
