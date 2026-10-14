import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_loved/LoginScreen/LoginScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isHindi = false;

  String _selectedAvatarUrl =
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80';
  bool _isGoogleAvatar = true;

  final List<String> _googlePhotos = [
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=300&q=80',
    'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?auto=format&fit=crop&w=300&q=80',
  ];

  final TextEditingController _schoolController = TextEditingController(
    text: 'Stanford University',
  );
  final TextEditingController _locationController = TextEditingController(
    text: 'Stanford, California, USA',
  );
  final TextEditingController _yearController = TextEditingController(
    text: '2024',
  );

  final TextEditingController _mobileController = TextEditingController(
    text: '+1 (555) 019-2834',
  );
  bool _isMobileVerified = false;

  final TextEditingController _currentAddressController = TextEditingController(
    text: '123 Maple St, Apt 4B, New York, NY 10001',
  );
  final TextEditingController _permanentAddressController =
      TextEditingController(
        text: '789 Oak Ave, Suite 12, San Francisco, CA 94102',
      );

  bool _sameAsCurrentAddress = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _schoolController.addListener(_validateForm);
    _locationController.addListener(_validateForm);
    _yearController.addListener(_validateForm);
    _mobileController.addListener(_validateForm);
    _currentAddressController.addListener(_validateForm);
    _permanentAddressController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid =
        _schoolController.text.trim().isNotEmpty &&
        _locationController.text.trim().isNotEmpty &&
        _yearController.text.trim().isNotEmpty &&
        _mobileController.text.trim().isNotEmpty &&
        _currentAddressController.text.trim().isNotEmpty &&
        _permanentAddressController.text.trim().isNotEmpty &&
        _isMobileVerified;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    _schoolController.dispose();
    _locationController.dispose();
    _yearController.dispose();
    _mobileController.dispose();
    _currentAddressController.dispose();
    _permanentAddressController.dispose();
    super.dispose();
  }

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0F3D38),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _isHindi ? 'प्रोफ़ाइल विकल्प' : 'Profile Options',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF072420),
                    child: Icon(
                      Icons.dashboard_outlined,
                      color: Color(0xFFD4AF37),
                      size: 22,
                    ),
                  ),
                  title: Text(
                    _isHindi ? 'डैशबोर्ड पर जाएं' : 'Go to Dashboard',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    _isHindi
                        ? 'मुख्य डैशबोर्ड दृश्य पर लौटें'
                        : 'Return to the main dashboard view',
                    style: const TextStyle(color: Colors.white60),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                ),
                const Divider(color: Colors.white12, height: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF072420),
                    child: Icon(
                      Icons.g_mobiledata,
                      color: Colors.blue,
                      size: 28,
                    ),
                  ),
                  title: Text(
                    _isHindi
                        ? 'गूगल खाते से चुनें'
                        : 'Pick from Google Account',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    _isHindi
                        ? 'अपनी सिंक की गई गूगल तस्वीरों में से चुनें'
                        : 'Choose from your synced Google photos',
                    style: const TextStyle(color: Colors.white60),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showGooglePhotoSelector();
                  },
                ),
                const Divider(color: Colors.white12, height: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF072420),
                    child: Icon(
                      Icons.upload_file,
                      color: Colors.brown,
                      size: 22,
                    ),
                  ),
                  title: Text(
                    _isHindi ? 'डिवाइस से अपलोड करें' : 'Upload from Device',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    _isHindi
                        ? 'गैलरी या फ़ाइलों से चुनें'
                        : 'Choose from Gallery or Files',
                    style: const TextStyle(color: Colors.white60),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _selectedAvatarUrl =
                          'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=300&q=80';
                      _isGoogleAvatar = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _isHindi
                              ? 'डिवाइस से फोटो अपलोड हो गई!'
                              : 'Photo uploaded from device!',
                        ),
                      ),
                    );
                  },
                ),
                const Divider(color: Colors.white12, height: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF072420),
                    child: Icon(
                      Icons.logout,
                      color: Colors.deepOrange,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    _isHindi ? 'लॉग आउट' : 'Log Out',
                    style: const TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    _isHindi
                        ? 'अपने खाते से साइन आउट करें'
                        : 'Sign out of your account',
                    style: const TextStyle(color: Colors.white60),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showGooglePhotoSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: const Color(0xFF0F3D38),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.g_mobiledata,
                    color: Color(0xFFD4AF37),
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isHindi
                        ? 'गूगल खाता फोटो चुनें'
                        : 'Select Google Account Photo',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                itemCount: _googlePhotos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final photoUrl = _googlePhotos[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatarUrl = photoUrl;
                        _isGoogleAvatar = true;
                      });
                      Navigator.pop(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(photoUrl, fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOtpVerificationDialog() {
    final TextEditingController otpController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0F3D38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            _isHindi ? 'मोबाइल नंबर सत्यापित करें' : 'Verify Mobile Number',
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isHindi
                    ? '${_mobileController.text} पर भेजा गया 4-अंकों का OTP दर्ज करें'
                    : 'Enter the 4-digit OTP sent to ${_mobileController.text}',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: _isHindi ? 'OTP कोड' : 'OTP Code',
                  labelStyle: const TextStyle(color: Colors.white60),
                  border: const OutlineInputBorder(),
                  counterText: '',
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                _isHindi ? 'रद्द करें' : 'Cancel',
                style: const TextStyle(color: Colors.white60),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
              ),
              onPressed: () {
                if (otpController.text.length == 4) {
                  setState(() {
                    _isMobileVerified = true;
                  });
                  _validateForm();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _isHindi
                            ? 'मोबाइल नंबर सफलतापूर्वक सत्यापित हुआ!'
                            : 'Mobile number verified successfully!',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _isHindi
                            ? 'कृपया वैध 4-अंकों का OTP दर्ज करें।'
                            : 'Please enter a valid 4-digit OTP.',
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              child: Text(
                _isHindi ? 'सत्यापित करें' : 'Verify',
                style: const TextStyle(
                  color: Color(0xFF072420),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F3D38), Color(0xFF072420), Color(0xFF031210)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: ToggleButtons(
                        constraints: const BoxConstraints(
                          minHeight: 32,
                          minWidth: 60,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        selectedColor: Color(0xFF072420),
                        fillColor: const Color(0xFFD4AF37),
                        color: Colors.white,
                        isSelected: [!_isHindi, _isHindi],
                        onPressed: (int index) {
                          setState(() {
                            _isHindi = index == 1;
                          });
                        },
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Eng',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'हिंदी',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _isHindi ? 'प्रोफ़ाइल पेज' : 'Profile Page',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 60),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 35),
                      _buildHeaderProfileCard(),
                      const SizedBox(height: 16),
                      _buildMandatoryInfoCard(),
                      const SizedBox(height: 16),
                      _buildContactInfoCard(),
                      const SizedBox(height: 16),
                      _buildAddressCard(),
                      const SizedBox(height: 24),
                      _buildSaveButtonAndLogout(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderProfileCard() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ramesh Sharma',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.verified,
                    color: Color(0xFFD4AF37),
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'ramesh.sharma@example.com',
                style: TextStyle(fontSize: 13, color: Colors.white60),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isGoogleAvatar ? Icons.g_mobiledata : Icons.upload_file,
                    color: _isGoogleAvatar ? Colors.redAccent : Colors.white70,
                    size: 20,
                  ),
                  Text(
                    _isGoogleAvatar
                        ? (_isHindi ? 'गूगल से जुड़ा है' : 'Linked to Google')
                        : (_isHindi
                              ? 'कस्टम अपलोड की गई फोटो'
                              : 'Custom Uploaded Photo'),
                    style: TextStyle(
                      fontSize: 12,
                      color: _isGoogleAvatar
                          ? const Color(0xFFD4AF37)
                          : Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: GestureDetector(
            onTap: _showImagePickerModal,
            child: Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(_selectedAvatarUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD4AF37),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Color(0xFF072420),
                      size: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMandatoryInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isHindi ? 'शैक्षणिक विवरण' : 'Academic Details',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _isHindi ? 'आवश्यक *' : 'Required *',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: Icons.school_outlined,
            title: _isHindi
                ? 'स्कूल / विश्वविद्यालय का नाम *'
                : 'School / University Name *',
            controller: _schoolController,
          ),
          const Divider(color: Colors.white12, height: 20),
          _buildDetailRow(
            icon: Icons.location_on_outlined,
            title: _isHindi ? 'परिसर का स्थान *' : 'Campus Location *',
            controller: _locationController,
          ),
          const Divider(color: Colors.white12, height: 20),
          _buildDetailRow(
            icon: Icons.calendar_today_outlined,
            title: _isHindi
                ? 'स्नातक / बैच वर्ष *'
                : 'Graduation / Batch Year *',
            controller: _yearController,
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isHindi ? 'संपर्क जानकारी' : 'Contact Information',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _isHindi ? 'आवश्यक *' : 'Required *',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.phone_outlined, color: Colors.white70, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isHindi
                          ? 'मोबाइल नंबर (OTP सत्यापित) *'
                          : 'Mobile Number (OTP Verified) *',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white60,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      onChanged: (val) {
                        setState(() {
                          _isMobileVerified = false;
                        });
                        _validateForm();
                      },
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  if (_mobileController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _isHindi
                              ? 'कृपया पहले मोबाइल नंबर दर्ज करें।'
                              : 'Please enter a mobile number first.',
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }
                  _showOtpVerificationDialog();
                },
                style: TextButton.styleFrom(
                  backgroundColor: _isMobileVerified
                      ? Colors.green.withValues(alpha: 0.2)
                      : const Color(0xFFD4AF37).withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                ),
                child: Text(
                  _isMobileVerified
                      ? (_isHindi ? 'सत्यापित ✓' : 'Verified ✓')
                      : (_isHindi ? 'OTP सत्यापित करें' : 'Verify OTP'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _isMobileVerified
                        ? Colors.greenAccent
                        : const Color(0xFFD4AF37),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isHindi ? 'पते की जानकारी' : 'Address Information',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _isHindi ? 'आवश्यक *' : 'Required *',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: Icons.home_outlined,
            title: _isHindi ? 'वर्तमान पता *' : 'Current Address *',
            controller: _currentAddressController,
            maxLines: 2,
            onChanged: (val) {
              if (_sameAsCurrentAddress) {
                setState(() {
                  _permanentAddressController.text = val;
                });
              }
            },
          ),
          const Divider(color: Colors.white12, height: 20),
          Row(
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  value: _sameAsCurrentAddress,
                  activeColor: const Color(0xFFD4AF37),
                  checkColor: const Color(0xFF072420),
                  onChanged: (bool? value) {
                    setState(() {
                      _sameAsCurrentAddress = value ?? false;
                      if (_sameAsCurrentAddress) {
                        _permanentAddressController.text =
                            _currentAddressController.text;
                      }
                    });
                    _validateForm();
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isHindi
                      ? 'स्थाई पता वर्तमान पता जैसा ही है'
                      : 'Permanent address same as current address',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow(
            icon: Icons.location_city_outlined,
            title: _isHindi ? 'स्थाई पता *' : 'Permanent Address *',
            controller: _permanentAddressController,
            maxLines: 2,
            readOnly: _sameAsCurrentAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white70, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white60,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              TextField(
                controller: controller,
                maxLines: maxLines,
                readOnly: readOnly,
                onChanged: onChanged,
                style: TextStyle(
                  fontSize: 14,
                  color: readOnly ? Colors.white38 : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
        if (!readOnly)
          const Icon(Icons.edit_outlined, color: Colors.white38, size: 18),
      ],
    );
  }

  Widget _buildSaveButtonAndLogout() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _isFormValid
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _isHindi
                              ? 'प्रोफ़ाइल सफलतापूर्वक सहेजी गई!'
                              : 'Profile saved successfully!',
                        ),
                        backgroundColor: const Color(0xFF4CAF50),
                      ),
                    );
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              disabledBackgroundColor: Colors.white12,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              _isHindi ? 'प्रोफ़ाइल सहेजें' : 'Save Profile',
              style: TextStyle(
                color: _isFormValid ? const Color(0xFF072420) : Colors.white38,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.deepOrange, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              _isHindi ? 'लॉग आउट' : 'Log Out',
              style: const TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
