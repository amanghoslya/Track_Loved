import 'package:flutter/material.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';
import 'package:track_loved/DrawerScreen/AddNetworkScreen/AddNetWorkScreen.dart';
import 'package:track_loved/DrawerScreen/Feedback_And_Google_Rating.dart';
import 'package:track_loved/DrawerScreen/NetworkLocationpermissions.dart'
    hide AppDrawer;
import 'package:track_loved/DrawerScreen/NetworkRequestScreen/NetworkingRequest.dart' hide AppDrawer;
import 'package:track_loved/DrawerScreen/PostJobOpprtunities.dart'
    hide AppDrawer;
import 'package:track_loved/DrawerScreen/SearchLovedOnseScreen.dart';
import 'package:track_loved/HomeScreen/DashboardScreen.dart';

class ExpandYourBusiness extends StatefulWidget {
  const ExpandYourBusiness({super.key});

  @override
  State<ExpandYourBusiness> createState() => ExpandYourBusinessState();
}

class ExpandYourBusinessState extends State<ExpandYourBusiness> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _opportunityTitleController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _investmentController = TextEditingController();
  final TextEditingController _areaRequiredController = TextEditingController();
  final TextEditingController _returnsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactPersonController =
      TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _selectedOpportunityType = 'Become a Distributor';
  bool _isHindi = false;

  final List<String> _opportunityTypes = [
    'Become a Distributor',
    'Start Courier Business / Franchise',
    'Super Stockist / C&F Agency',
    'Retail Franchise Store',
    'Channel Partner / Dealership',
    'Other Business Expansion',
  ];

  @override
  void dispose() {
    _companyNameController.dispose();
    _opportunityTitleController.dispose();
    _locationController.dispose();
    _pincodeController.dispose();
    _investmentController.dispose();
    _areaRequiredController.dispose();
    _returnsController.dispose();
    _descriptionController.dispose();
    _contactPersonController.dispose();
    _contactPhoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitOpportunity() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(_isHindi ? 'सफलता!' : 'Opportunity Published!'),
          content: Text(
            _isHindi
                ? 'आपका व्यवसाय विस्तार अवसर सफलतापूर्वक लाइव कर दिया गया है।'
                : 'Your business expansion listing has been successfully posted. Interested partners in your specified pin codes can now reach out.',
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
                'View Listings',
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
        titleEn: 'Expand Your Business',
        titleHi: 'अपना व्यवसाय बढ़ाएं',
        isHindi: _isHindi,
        notificationCount: 2,
        onLanguageChanged: (value) {
          setState(() {
            _isHindi = value;
          });
        },
      ),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF0B4F4A),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.menu, color: Colors.white),
      //     onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      //   ),
      //   title: Text(
      //     _isHindi ? 'अपना व्यवसाय बढ़ाएं' : 'Expand Your Business',
      //     style: const TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 16,
      //     ),
      //   ),
      // ),
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
                      'Publish an Expansion Opportunity',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Invite verified distributors, partners, or franchisees for your business growth.',
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('1. Company & Opportunity Type'),
                    const SizedBox(height: 12),
                    _buildTextField(
                      icon: Icons.business,
                      controller: _companyNameController,
                      label: 'Company / Brand Name *',
                      hint: 'e.g., SwiftLogistics Express / Apex Retail',
                      validatorMsg: 'Please enter your company name',
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedOpportunityType,

                      style: const TextStyle(color: Colors.white, fontSize: 14),

                      dropdownColor: const Color(0xFF141A19),

                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,

                      decoration: _inputDecoration('Opportunity Type *'),

                      items: _opportunityTypes.map((String type) {
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
                          setState(() {
                            _selectedOpportunityType = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      icon: Icons.title,
                      controller: _opportunityTitleController,
                      label: 'Opportunity Headline / Title *',
                      hint:
                          'e.g., Looking for City Distributors for Fast Courier Service',
                      validatorMsg: 'Please enter a headline',
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('2. Target Location & Requirements'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildTextField(
                            icon: Icons.location_on,
                            controller: _locationController,
                            label: 'City / Region *',
                            hint: 'e.g., Faridabad / Delhi NCR',
                            validatorMsg: 'Enter city',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: _buildTextField(
                            icon: Icons.pin_drop,
                            controller: _pincodeController,
                            label: 'Pin Code(s) *',
                            hint: 'e.g., 121001',
                            validatorMsg: 'Enter pin code',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            icon: Icons.currency_rupee,
                            controller: _investmentController,
                            label: 'Required Invesment *',
                            hint: 'e.g., ₹2 Lakhs - ₹5 Lakhs',
                            validatorMsg: 'Enter investment range',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            icon: Icons.square_foot,
                            controller: _areaRequiredController,
                            label: 'Space / Area Required *',
                            hint: 'e.g., 150 - 300 Sq. Ft.',
                            validatorMsg: 'Enter area details',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('3. Financial Returns & Proposition'),
                    const SizedBox(height: 12),
                    _buildTextField(
                      icon: Icons.trending_up,
                      controller: _returnsController,
                      label: 'Expected Return / Profit Margin *',
                      hint: 'e.g., 20-25% ROI or Payback within 6 Months',
                      validatorMsg: 'Please specify returns',
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      icon: Icons.description,
                      controller: _descriptionController,
                      label: 'Detailed Company & Opportunity Description *',
                      hint:
                          'Explain what you provide (training, stock, software, marketing support, etc.)',
                      validatorMsg: 'Please provide description clarity',
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('4. Contact Information'),
                    const SizedBox(height: 12),
                    _buildTextField(
                      icon: Icons.person,
                      controller: _contactPersonController,
                      label: 'Contact Person Name *',
                      hint: 'e.g., Rajesh Verma (Director)',
                      validatorMsg: 'Enter contact person name',
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            icon: Icons.phone,
                            controller: _contactPhoneController,
                            label: 'Mobile / WhatsApp Number *',
                            hint: '+91 98765 43210',
                            validatorMsg: 'Enter phone number',
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _emailController,
                            icon: Icons.email,
                            label: 'Business Email *',
                            hint: 'partners@company.com',
                            validatorMsg: 'Enter email address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
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
                        onPressed: _submitOpportunity,
                        child: const Text(
                          'Publish Business Opportunity',
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

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
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validatorMsg;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.white60),
        hintStyle: const TextStyle(fontSize: 13, color: Colors.white60),
        prefixIcon: Icon(icon, color: Colors.white60),
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,

      labelStyle: const TextStyle(color: Colors.white60),

      hintText: hint,

      hintStyle: const TextStyle(fontSize: 13, color: Colors.white60),

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
    );
  }
}
