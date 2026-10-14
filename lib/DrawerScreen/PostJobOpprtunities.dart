import 'package:flutter/material.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';
import 'package:track_loved/DrawerScreen/AddNetworkScreen/AddNetWorkScreen.dart';
import 'package:track_loved/DrawerScreen/ExpandYourBusiness.dart';
import 'package:track_loved/DrawerScreen/ExploreBusinessScreen.dart';
import 'package:track_loved/DrawerScreen/Feedback_And_Google_Rating.dart';
import 'package:track_loved/DrawerScreen/NetworkLocationpermissions.dart';
import 'package:track_loved/DrawerScreen/NetworkRequestScreen/NetworkingRequest.dart';
import 'package:track_loved/DrawerScreen/SearchLovedOnseScreen.dart';
import 'package:track_loved/HomeScreen/DashboardScreen.dart';


class PostJobOpportunitiesScreen extends StatefulWidget {
  const PostJobOpportunitiesScreen({super.key});

  @override
  State<PostJobOpportunitiesScreen> createState() =>
      _PostJobOpportunitiesScreenState();
}

class _PostJobOpportunitiesScreenState
    extends State<PostJobOpportunitiesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _employerController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();

  String _selectedJobType = 'Full-Time';
  bool _isHindi = false;

  final List<String> _jobTypes = [
    'Full-Time',
    'Part-Time',
    'Contract / Project-Based',
    'Remote / Work from Home',
    'Internship',
  ];

  @override
  void dispose() {
    _jobTitleController.dispose();
    _employerController.dispose();
    _locationController.dispose();
    _salaryController.dispose();
    _descriptionController.dispose();
    _contactEmailController.dispose();
    super.dispose();
  }

  void _submitJob() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(_isHindi ? 'सफलता!' : 'Job Posted Successfully!'),
          content: Text(
            _isHindi
                ? 'आपका नौकरी का अवसर लाइव कर दिया गया है।'
                : 'Your job opportunity listing has been posted. Local applicants can now view and apply.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushReplacementNamed(
                  context,
                  '/business-opportunities',
                );
              },
              child: const Text(
                'Back to Home',
                style: TextStyle(color: Color(0xFF0B4F4A)),
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
      backgroundColor: Color(0xFF002E29),
      key: _scaffoldKey,
      drawer: AppDrawer(isHindi: _isHindi),
      appBar: AppBarScreen(
        titleEn: 'Post Job Opportunities',
        titleHi: 'नौकरी के अवसर पोस्ट करें',
        isHindi: _isHindi,
        notificationCount: 2,
        onLanguageChanged: (value) {
          setState(() {
            _isHindi = value;
          });
        },
        onNotificationPressed: () {
          
        },
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2F1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF0B4F4A).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.card_membership,
                            color: Color(0xFF0B4F4A),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _isHindi
                                  ? 'यह एक सशुल्क सदस्यता सुविधा है, जो सीमित समय के लिए पूरी तरह से निःशुल्क उपलब्ध है।'
                                  : 'Paid Subscription Feature — Currently Available FREE for a Limited Period!',
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B4F4A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Create a Job Listing',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Post job openings to connect with qualified professionals in your network area.',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _jobTitleController,
                      label: 'Job Title / Designation *',
                      hint:
                          'e.g., Senior Operations Manager / Delivery Executive',
                      validatorMsg: 'Please enter a job title',
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _employerController,
                      label: 'Company / Employer Name *',
                      hint: 'e.g., SwiftLogistics Express',
                      validatorMsg: 'Please enter company name',
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedJobType,

                      decoration: InputDecoration(
                        labelText: 'Employment Type *',
                        labelStyle: const TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFC5A038),
                          ),
                        ),
                      ),

                      dropdownColor: const Color(0xFF141A19),

                      style: const TextStyle(color: Colors.white, fontSize: 14),

                      iconEnabledColor: Colors.white,

                      items: _jobTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        );
                      }).toList(),

                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _selectedJobType = val);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _locationController,
                            label: 'Job Location *',
                            hint: 'e.g., Faridabad / Remote',
                            validatorMsg: 'Enter location',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _salaryController,
                            label: 'Salary / Compensation *',
                            hint: 'e.g., ₹25,000 - ₹40,000 / month',
                            validatorMsg: 'Enter compensation details',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'Job Description & Requirements *',
                      hint:
                          'Outline key responsibilities, shift timing, and skills required...',
                      validatorMsg: 'Please provide description',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      controller: _contactEmailController,
                      label: 'Application Email or Phone *',
                      hint: 'hr@company.com or +91 98765 43210',
                      validatorMsg: 'Enter contact channel',
                      keyboardType: TextInputType.emailAddress,
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
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String validatorMsg,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: const TextStyle(color: Colors.white60),
        prefixIcon: const Icon(Icons.email_outlined, color: Colors.white60),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFC5A038)),
        ),
      ),
    );
  }
}
