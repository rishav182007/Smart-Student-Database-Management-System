import 'package:flutter/material.dart';
import 'home_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController adminIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;

  @override
  void dispose() {
    adminIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void adminLogin() {
    if (adminIdController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Admin ID and Password')),
      );
      return;
    }

    // Navigate to Home Screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF123E83)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Logo
              _logo(),

              const SizedBox(height: 22),

              // Title
              const Text(
                'Admin Login',
                style: TextStyle(
                  color: Color(0xFF123E83),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Login to manage student records',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 38),

              // Admin ID
              _label('Admin ID'),

              const SizedBox(height: 8),

              TextField(
                controller: adminIdController,
                decoration: _inputDecoration(
                  hint: 'Enter Admin ID',
                  icon: Icons.admin_panel_settings_outlined,
                ),
              ),

              const SizedBox(height: 20),

              // Password
              _label('Password'),

              const SizedBox(height: 8),

              TextField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: _inputDecoration(
                  hint: 'Enter Password',
                  icon: Icons.lock_outline,
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF123E83),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Login Button
              _loginButton(),

              const SizedBox(height: 30),

              const Text(
                'Admin Portal',
                style: TextStyle(
                  color: Color(0xFFFF9F1C),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Container(
      height: 95,
      width: 95,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF123E83).withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
    );
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF123E83),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF123E83)),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFFF9F1C), width: 1.5),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: adminLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF123E83),
          foregroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login),
            SizedBox(width: 10),
            Text(
              'Login as Admin',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
