import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'local_account_store.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;
  bool isSaving = false;

  String get collectionName => 'students';

  String get idLabel => 'Student ID';

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ============================================================
  // REGISTER ACCOUNT
  // ============================================================

  Future<void> registerAccount() async {
    final String id = idController.text.trim();
    final String password = passwordController.text.trim();

    // Check empty fields
    if (id.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an ID and password')),
      );
      return;
    }

    // Check existing account
    if (LocalAccountStore.accountExists(category: collectionName, id: id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This ID is already registered')),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    // Small delay for loading effect
    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    // Save account
    LocalAccountStore.saveAccount(
      category: collectionName,
      id: id,
      password: password,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created successfully')),
    );

    // Navigate to HomeScreen
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF123E83)),
        ),

        title: const Text(
          'Create Account',
          style: TextStyle(
            color: Color(0xFF123E83),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

          padding: const EdgeInsets.symmetric(horizontal: 25),

          child: Column(
            children: [
              const SizedBox(height: 10),

              // ==================================================
              // LOGO
              // ==================================================
              Container(
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

                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // TITLE
              // ==================================================
              const Text(
                'Create Account',
                style: TextStyle(
                  color: Color(0xFF123E83),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Register to access Smart Student',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              const SizedBox(height: 30),

              const SizedBox(height: 25),

              // ==================================================
              // ID LABEL
              // ==================================================
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  idLabel,
                  style: const TextStyle(
                    color: Color(0xFF123E83),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ==================================================
              // ID FIELD
              // ==================================================
              TextField(
                controller: idController,

                decoration: InputDecoration(
                  hintText: 'Enter Student ID',

                  prefixIcon: const Icon(
                    Icons.school_outlined,
                    color: Color(0xFF123E83),
                  ),

                  filled: true,
                  fillColor: Colors.white,

                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 15,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFFFF9F1C),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // PASSWORD LABEL
              // ==================================================
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: Color(0xFF123E83),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ==================================================
              // PASSWORD FIELD
              // ==================================================
              TextField(
                controller: passwordController,
                obscureText: hidePassword,

                decoration: InputDecoration(
                  hintText: 'Create a password',

                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF123E83),
                  ),

                  suffixIcon: IconButton(
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

                  filled: true,
                  fillColor: Colors.white,

                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 17,
                    horizontal: 15,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xFFFF9F1C),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // REGISTER BUTTON
              // ==================================================
              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton(
                  onPressed: isSaving ? null : registerAccount,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF123E83),

                    foregroundColor: Colors.white,

                    disabledBackgroundColor: const Color(0xFF9AAAC2),

                    elevation: 3,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Icon(
                        isSaving
                            ? Icons.hourglass_top
                            : Icons.person_add_outlined,
                      ),

                      const SizedBox(width: 10),

                      Text(
                        isSaving ? 'Registering...' : 'Register as Student',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ==================================================
              // BOTTOM TEXT
              // ==================================================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Text(
                    'Smart Student',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  const SizedBox(width: 6),

                  const Icon(Icons.school, size: 15, color: Color(0xFFFF9F1C)),

                  const SizedBox(width: 6),

                  const Text(
                    'Student Portal',
                    style: TextStyle(
                      color: Color(0xFF123E83),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
