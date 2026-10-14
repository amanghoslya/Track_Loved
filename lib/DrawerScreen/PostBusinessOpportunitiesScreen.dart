import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';
import 'package:track_loved/HomeScreen/DashboardScreen.dart';

class PostBusinessOpportunitiesScreen extends StatefulWidget {
  const PostBusinessOpportunitiesScreen({super.key});

  @override
  State<PostBusinessOpportunitiesScreen> createState() =>
      PostBusinessOpportunitiesScreenState();
}

class PostBusinessOpportunitiesScreenState
    extends State<PostBusinessOpportunitiesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _pincodeInputController = TextEditingController();
  final TextEditingController _annualCtcController = TextEditingController();
  final TextEditingController _perksController = TextEditingController();
  final TextEditingController _reimbursementsController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  bool _isHindi = false;

  String _selectedJobType = 'Full-Time';
  String _selectedLevel = 'Mid-Level';

  final List<String> _jobTypes = [
    'Full-Time',
    'Part-Time',
    'Contract / Project-Based',
    'Remote / WFH',
    'Internship',
  ];

  final List<String> _jobLevels = ['Frontline', 'Mid-Level', 'Senior'];

  final List<String> _selectedPincodes = ['121001', '121003'];

  @override
  void dispose() {
    _jobTitleController.dispose();
    _locationController.dispose();
    _pincodeInputController.dispose();
    _annualCtcController.dispose();
    _perksController.dispose();
    _reimbursementsController.dispose();
    _descriptionController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _addPinCode() {
    final pin = _pincodeInputController.text.trim();

    if (pin.length == 6 && !_selectedPincodes.contains(pin)) {
      setState(() {
        _selectedPincodes.add(pin);
        _pincodeInputController.clear();
      });
    }
  }

  void _submitJob() {
    if (_formKey.currentState!.validate()) {
      if (_selectedPincodes.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select at least one target pin code.'),
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Job Opportunity Posted!'),
          content: Text(
            'Your listing targeting ${_selectedPincodes.length} pin code(s) is now active.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pushReplacementNamed(
                  context,
                  '/business-opportunities',
                );
              },
              child: const Text(
                'View Explore Feed',
                style: TextStyle(
                  color: Color(0xFF0B4F4A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002E29),
      key: _scaffoldKey,
      drawer: AppDrawer(isHindi: _isHindi),
      appBar: AppBarScreen(
        titleEn: 'Post Business Opportunities',
        titleHi: 'नौकरी का अवसर पोस्ट करें',
        isHindi: _isHindi,
        notificationCount: 2,
        onLanguageChanged: (value) {
          setState(() {
            _isHindi = value;
          });
        },
        onNotificationPressed: () {},
      ),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF0B4F4A),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.menu, color: Colors.white),
      //     onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      //   ),
      //   title: const Text(
      //     'Post Job Opportunity',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 16,
      //     ),
      //   ),
      // ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  const Text(
                    'Create Job Listing',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Define compensation, levels, and specific target areas.',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),

                  const SizedBox(height: 20),

                  _sectionHeader('1. Role & Seniority Level'),

                  const SizedBox(height: 10),

                  // Job Title
                  _buildTextField(
                    controller: _jobTitleController,
                    label: 'Job Title / Designation *',
                    hint: 'e.g., Senior Operations Manager',
                    validatorMsg: 'Enter job title',
                    icon: Icons.work_outline,
                  ),

                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    initialValue: _selectedJobType,
                    decoration: _inputDecoration(
                      'Employment Type *',
                      icon: Icons.business_center_outlined,
                    ),
                    dropdownColor: const Color(0xFF003A35),
                    items: _jobTypes.map((t) {
                      return DropdownMenuItem(
                        value: t,
                        child: Text(
                          t,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() {
                          _selectedJobType = v;
                        });
                      }
                    },
                  ),

                  const SizedBox(width: 10),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedLevel,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: _inputDecoration(
                      'Hierarchy Level *',
                      icon: Icons.leaderboard_outlined,
                    ),
                    dropdownColor: const Color(0xFF003A35),
                    items: _jobLevels.map((l) {
                      return DropdownMenuItem<String>(
                        value: l,
                        child: Text(
                          l,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (v) {
                      if (v != null) {
                        setState(() {
                          _selectedLevel = v;
                        });
                      }
                    },
                  ),

                  SizedBox(height: 20),

                  _sectionHeader('2. Location & Target Pin Codes'),

                  const SizedBox(height: 10),

                  // Location
                  _buildTextField(
                    controller: _locationController,
                    label: 'Base City / Location *',
                    hint: 'e.g., Faridabad, Haryana',
                    validatorMsg: 'Enter location',
                    icon: Icons.location_on_outlined,
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _pincodeInputController,
                          label: 'Add Target Pin Code',
                          hint: 'Enter 6-digit pin',
                          validatorMsg: 'Enter pin code',
                          keyboardType: TextInputType.number,
                          icon: Icons.pin_drop_outlined,
                        ),
                      ),

                      const SizedBox(width: 10),

                      SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0B4F4A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _addPinCode,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                          label: const Text(
                            'Add Pin',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Wrap(
                    spacing: 8,
                    children: _selectedPincodes.map((pin) {
                      return Chip(
                        label: Text(pin, style: const TextStyle(fontSize: 12)),
                        backgroundColor: const Color(0xFFE0F2F1),
                        deleteIcon: const Icon(Icons.close, size: 14),
                        onDeleted: () {
                          setState(() {
                            _selectedPincodes.remove(pin);
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  _sectionHeader('3. Annual CTC, Perks & Reimbursements'),

                  const SizedBox(height: 10),

                  // Annual CTC
                  _buildTextField(
                    controller: _annualCtcController,
                    label: 'Annual CTC Package *',
                    hint: 'e.g., ₹6,00,000 - ₹8,50,000 / annum',
                    validatorMsg: 'Enter CTC details',
                    icon: Icons.currency_rupee,
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _perksController,
                          label: 'Perks & Benefits',
                          hint: 'e.g., Health Insurance, Performance Bonus',
                          validatorMsg: 'Enter perks',
                          icon: Icons.card_giftcard_outlined,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _buildTextField(
                          controller: _reimbursementsController,
                          label: 'Reimbursements',
                          hint: 'e.g., Fuel, Mobile & Travel Allowance',
                          validatorMsg: 'Enter reimbursements',
                          icon: Icons.receipt_long_outlined,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _sectionHeader('4. Responsibilities & Application Details'),

                  const SizedBox(height: 10),

                  // Description
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Job Description & Requirements *',
                    hint: 'Outline day-to-day role responsibilities...',
                    validatorMsg: 'Enter job description',
                    maxLines: 4,
                    icon: Icons.description_outlined,
                  ),

                  const SizedBox(height: 12),

                  // Contact
                  _buildTextField(
                    controller: _contactController,
                    label: 'Application Contact (Email / Phone) *',
                    hint: 'careers@company.com or +91 9876543210',
                    validatorMsg: 'Enter application contact',
                    icon: Icons.contact_phone_outlined,
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B4F4A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: _submitJob,
                      child: const Text(
                        'Publish Job Listing',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // ============================================================
  // REUSABLE TEXT FIELD WIDGET
  // ============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String validatorMsg,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.white60),
        hintStyle: const TextStyle(color: Colors.white60, fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.white60),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC5A038)),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validatorMsg;
        }
        return null;
      },
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration(
    String label, {
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,

      labelStyle: const TextStyle(color: Colors.white60),

      hintStyle: const TextStyle(color: Colors.white60, fontSize: 13),

      prefixIcon: icon != null ? Icon(icon, color: Colors.white60) : null,

      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFC5A038)),
      ),
    );
  }
}
