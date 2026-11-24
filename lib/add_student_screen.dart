import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  // Colors matching Admin Dashboard
  static const Color navy = Color(0xFF194487);
  static const Color background = Color(0xFFF5F9FF);
  static const Color orange = Color(0xFFFFA629);
  static const Color textColor = Color(0xFF29466F);

  final nameController = TextEditingController();
  final boardRollController = TextEditingController();
  final collegeRollController = TextEditingController();
  final fatherController = TextEditingController();
  final motherController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  String? gender;
  String? branch;
  String? batch;
  String? semester;
  String? section;
  String? admissionYear;

  DateTime? selectedDate;

  @override
  void dispose() {
    nameController.dispose();
    boardRollController.dispose();
    collegeRollController.dispose();
    fatherController.dispose();
    motherController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  // Date Picker
  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1990),
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
      setState(() => selectedDate = date);
    }
  }

  // Section Heading
  Widget sectionHeading(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 16),
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
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: navy,
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

  // Text Field
  Widget inputField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.blueGrey, fontSize: 13),
          prefixIcon: Icon(icon, color: navy, size: 20),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 16,
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
      ),
    );
  }

  // Dropdown
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
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }

  // Date of Birth Field
  Widget dateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: pickDate,
        borderRadius: BorderRadius.circular(14),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Date of Birth',
            prefixIcon: const Icon(
              Icons.calendar_month_outlined,
              color: navy,
              size: 20,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.blueGrey.shade100),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.blueGrey.shade100),
            ),
          ),
          child: Text(
            selectedDate == null
                ? 'Select Date of Birth'
                : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
            style: TextStyle(
              color: selectedDate == null ? Colors.blueGrey : textColor,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // Reset Form
  void resetForm() {
    _formKey.currentState?.reset();

    nameController.clear();
    boardRollController.clear();
    collegeRollController.clear();
    fatherController.clear();
    motherController.clear();
    mobileController.clear();
    emailController.clear();
    addressController.clear();

    setState(() {
      gender = null;
      branch = null;
      batch = null;
      semester = null;
      section = null;
      admissionYear = null;
      selectedDate = null;
    });
  }

  // Save Student (UI only)
  void saveStudent() {
    if (!_formKey.currentState!.validate()) return;

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select Date of Birth')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form completed! Firebase will be connected later.'),
        backgroundColor: navy,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // AppBar matching Admin Dashboard
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
            'Add Student',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Card
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
                          Icons.person_add_alt_1,
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
                              'New Student',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Enter student registration details',
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

                // Personal Details
                sectionHeading('Personal Information', Icons.person_outline),

                inputField(
                  'Student Name',
                  nameController,
                  Icons.person_outline,
                ),

                inputField(
                  'Board Roll Number',
                  boardRollController,
                  Icons.badge_outlined,
                  keyboardType: TextInputType.number,
                ),

                inputField(
                  'College Roll Number',
                  collegeRollController,
                  Icons.confirmation_number_outlined,
                  keyboardType: TextInputType.number,
                ),

                inputField(
                  "Father's Name",
                  fatherController,
                  Icons.person_outline,
                ),

                inputField(
                  "Mother's Name",
                  motherController,
                  Icons.person_outline,
                ),

                dateField(),

                dropdownField(
                  'Gender',
                  gender,
                  ['Male', 'Female', 'Other'],
                  Icons.people_outline,
                  (value) => setState(() => gender = value),
                ),

                inputField(
                  'Mobile Number',
                  mobileController,
                  Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                inputField(
                  'Email Address',
                  emailController,
                  Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                inputField(
                  'Address',
                  addressController,
                  Icons.location_on_outlined,
                  maxLines: 3,
                ),

                // Academic Details
                sectionHeading('Academic Information', Icons.school_outlined),

                dropdownField(
                  'Branch',
                  branch,
                  [
                    'Computer Engineering',
                    'Mechanical Engineering',
                    'Civil Engineering',
                    'Electrical Engineering',
                    'Electronics Engineering',
                  ],
                  Icons.account_tree_outlined,
                  (value) => setState(() => branch = value),
                ),

                dropdownField(
                  'Batch',
                  batch,
                  ['2024 - 2027', '2025 - 2028', '2026 - 2029'],
                  Icons.groups_outlined,
                  (value) => setState(() => batch = value),
                ),

                dropdownField(
                  'Admission Year',
                  admissionYear,
                  ['2024', '2025', '2026'],
                  Icons.calendar_today_outlined,
                  (value) => setState(() => admissionYear = value),
                ),

                dropdownField(
                  'Current Semester',
                  semester,
                  ['1', '2', '3', '4', '5', '6'],
                  Icons.menu_book_outlined,
                  (value) => setState(() => semester = value),
                ),

                dropdownField(
                  'Section',
                  section,
                  ['A', 'B', 'C'],
                  Icons.class_outlined,
                  (value) => setState(() => section = value),
                ),

                const SizedBox(height: 15),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: saveStudent,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text(
                      'Save Student',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
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

                const SizedBox(height: 12),

                // Reset Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: resetForm,
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      'Reset Form',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: navy,
                      side: const BorderSide(color: navy, width: 1.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
