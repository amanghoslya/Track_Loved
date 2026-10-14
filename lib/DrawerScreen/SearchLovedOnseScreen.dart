import 'package:flutter/material.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';
import 'package:track_loved/DrawerScreen/NetworkLocationpermissions.dart';
import 'package:track_loved/HomeScreen/DashboardScreen.dart';

class SearchLovedOnesScreen extends StatefulWidget {
  const SearchLovedOnesScreen({super.key});

  @override
  State<SearchLovedOnesScreen> createState() => _SearchLovedOnesScreenState();
}

class _SearchLovedOnesScreenState extends State<SearchLovedOnesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  final NetworkService _networkService = NetworkService();

  bool _isHindi = false;
  bool _isLoading = true;
  String _searchQuery = '';
  List<UserPermission> _users = [];

  @override
  void initState() {
    super.initState();
    _loadSharedConnections();
  }

  Future<void> _loadSharedConnections() async {
    setState(() => _isLoading = true);
    final fetchedUsers = await _networkService.fetchAcceptedConnections();
    setState(() {
      _users = fetchedUsers;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Function to send help alert to all connected members
  void _sendHelpAlertToMembers() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_isHindi ? 'मदद की चेतावनी भेजें' : 'Send Help Alert'),
          content: Text(
            _isHindi
                ? 'क्या आप सुनिश्चित हैं कि आप अपने सभी जुड़े हुए सदस्यों को यह संदेश भेजना चाहते हैं कि आपको मदद की आवश्यकता है?'
                : 'Are you sure you want to notify all connected members that you need help?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                _isHindi ? 'रद्द करें' : 'Cancel',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B4F4A),
              ),
              onPressed: () {
                Navigator.pop(context);
                // Yahan aap apna backend API ya FCM notification integration likh sakte hain
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isHindi
                          ? 'सभी जुड़े हुए सदस्यों को मदद का संदेश भेज दिया गया है!'
                          : 'Help alert sent to all connected members!',
                    ),
                    backgroundColor: const Color(0xFF0B4F4A),
                  ),
                );
              },
              child: Text(
                _isHindi ? 'हाँ, भेजें' : 'Yes, Send',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLocationDetails(UserPermission user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: user.avatarColor,
                    child: Text(
                      user.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isHindi ? user.nameHi : user.nameEn,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.mobileNumber,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(height: 30),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F8FB),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFDCDFE4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          user.isOnline
                              ? Icons.gps_fixed
                              : Icons.phone_android_outlined,
                          size: 16,
                          color: user.isOnline
                              ? const Color(0xFF0B4F4A)
                              : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          user.isOnline
                              ? 'Precise Live Location'
                              : 'Device Switched Off / Offline',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Status: ${user.lastUpdated}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Last Coordinates: 28.6139° N, 77.2090° E',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B4F4A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  icon: const Icon(Icons.map, color: Colors.white),
                  label: Text(
                    _isHindi
                        ? 'मानचित्र पर अंतिम स्थान देखें'
                        : 'View Last Known Location on Map',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Opening map view...')),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredLovedOnes = _users.where((u) {
      if (!u.isShared) return false;

      final name = _isHindi ? u.nameHi : u.nameEn;
      final query = _searchQuery.toLowerCase();

      final matchesName = name.toLowerCase().contains(query);
      final matchesMobile = u.mobileNumber
          .replaceAll(' ', '')
          .contains(query.replaceAll(' ', ''));

      return matchesName || matchesMobile;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF002E29),
      key: _scaffoldKey,
      drawer: AppDrawer(isHindi: _isHindi),

      // Floating Action Button for Help Alert
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _sendHelpAlertToMembers,
        backgroundColor: Colors.red.shade700,
        icon: const Icon(Icons.sos, color: Colors.white),
        label: Text(
          _isHindi ? 'मदद चाहिए' : 'Need Help',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      appBar: AppBarScreen(
        titleEn: 'Track Loved Ones',
        titleHi: 'प्रियजनों की खोज करें',
        isHindi: _isHindi,
        notificationCount: 2,
        onLanguageChanged: (value) {
          setState(() {
            _isHindi = value;
          });
        },
        onNotificationPressed: () {},
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isHindi
                      ? 'प्रियजनों का लाइव स्थान'
                      : 'Live Location of\nLoved Ones',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

                // Search Bar
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFDCDFE4)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: InputDecoration(
                      hintText: _isHindi
                          ? 'नाम या मोबाइल नंबर से खोजें'
                          : 'Search by name or mobile number',
                      hintStyle: const TextStyle(
                        color: Colors.black45,
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black45,
                        size: 20,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                size: 18,
                                color: Colors.black45,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF0B4F4A),
                          ),
                        )
                      : filteredLovedOnes.isEmpty
                      ? Center(
                          child: Text(
                            _isHindi
                                ? 'कोई साझा स्थान वाला कनेक्शन नहीं मिला'
                                : 'No connections sharing location found',
                            style: const TextStyle(color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredLovedOnes.length,
                          itemBuilder: (context, index) {
                            return _buildLovedOneCard(filteredLovedOnes[index]);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLovedOneCard(UserPermission user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCDFE4), width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: user.avatarColor,
            child: Text(
              user.initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isHindi ? user.nameHi : user.nameEn,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  user.mobileNumber,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: user.isOnline
                          ? const Color(0xFF2E7D32)
                          : Colors.orange,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      user.isOnline
                          ? 'Location Active (Live)'
                          : 'Phone Switched Off (Last Known)',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: user.isOnline
                            ? const Color(0xFF2E7D32)
                            : Colors.orange[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.location_on, color: Color(0xFF0B4F4A)),
            onPressed: () => _showLocationDetails(user),
          ),
        ],
      ),
    );
  }
}

class UserPermission {
  final String id;
  final String nameEn;
  final String nameHi;
  final String mobileNumber;
  final String initials;
  final Color avatarColor;
  bool isShared;
  bool isOnline;
  String lastUpdated;

  UserPermission({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.mobileNumber,
    required this.initials,
    required this.avatarColor,
    this.isShared = false,
    this.isOnline = true,
    this.lastUpdated = 'Just now',
  });
}

class NetworkService {
  Future<List<UserPermission>> fetchAcceptedConnections() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return [
      UserPermission(
        id: '1',
        nameEn: 'Vikram Singh',
        nameHi: 'विक्रम सिंह',
        mobileNumber: '+91 98765 43210',
        initials: 'VS',
        avatarColor: const Color(0xFF1E88E5),
        isShared: true,
        isOnline: true,
        lastUpdated: 'Just now (GPS Active)',
      ),
      UserPermission(
        id: '2',
        nameEn: 'Neha Gupta',
        nameHi: 'नेहा गुप्ता',
        mobileNumber: '+91 91234 56789',
        initials: 'NG',
        avatarColor: const Color(0xFF43A047),
        isShared: true,
        isOnline: false,
        lastUpdated: '2 hours ago (Last Known)',
      ),
      UserPermission(
        id: '3',
        nameEn: 'Ramesh Sharma',
        nameHi: 'रमेश शर्मा',
        mobileNumber: '+91 99887 76655',
        initials: 'RS',
        avatarColor: const Color(0xFF8E24AA),
        isShared: false,
        isOnline: true,
      ),
      UserPermission(
        id: '4',
        nameEn: 'Amit Kumar',
        nameHi: 'अमित कुमार',
        mobileNumber: '+91 95555 44433',
        initials: 'AK',
        avatarColor: const Color(0xFFE91E63),
        isShared: true,
        isOnline: true,
        lastUpdated: '5 mins ago',
      ),
    ];
  }
}
