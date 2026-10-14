import 'package:flutter/material.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';
import 'package:track_loved/DrawerScreen/AddNetworkScreen/AddNetWorkScreen.dart';
import 'package:track_loved/DrawerScreen/ExploreBusinessScreen.dart';
import 'package:track_loved/DrawerScreen/NetworkRequestScreen/NetworkingRequest.dart';
import 'package:track_loved/DrawerScreen/SearchLovedOnseScreen.dart';
import 'package:track_loved/HomeScreen/DashboardScreen.dart';

class NetworkLocationPermissionsScreen extends StatefulWidget {
  const NetworkLocationPermissionsScreen({super.key});

  @override
  State<NetworkLocationPermissionsScreen> createState() =>
      _NetworkLocationPermissionsScreenState();
}

class _NetworkLocationPermissionsScreenState
    extends State<NetworkLocationPermissionsScreen> {
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
    _loadAcceptedConnections();
  }

  Future<void> _loadAcceptedConnections() async {
    setState(() {
      _isLoading = true;
    });

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

  @override
  Widget build(BuildContext context) {
    final activeCount = _users.where((u) => u.isShared).length;

    // Filter list based on search query matching either English or Hindi names
    final filteredUsers = _users.where((u) {
      final name = _isHindi ? u.nameHi : u.nameEn;
      return name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
    return Scaffold(
      backgroundColor: const Color(0xFF002E29),
      key: _scaffoldKey,
      drawer: AppDrawer(isHindi: _isHindi),
      appBar: AppBarScreen(
        titleEn: "Network Location Permissions",
        titleHi: "नेटवर्क स्थान अनुमतियाँ",
        isHindi: _isHindi,
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
      //   title: Text(
      //     _isHindi ? 'नेटवर्क स्थान अनुमतियाँ' : 'Network Location Permissions',
      //     style: const TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 16,
      //     ),
      //   ),
      //   actions: [
      //     // Language Switcher Toggle Buttons (En / हिं)
      //     Container(
      //       margin: const EdgeInsets.symmetric(vertical: 8),
      //       decoration: BoxDecoration(
      //         color: Colors.white.withValues(alpha: 0.15),
      //         borderRadius: BorderRadius.circular(15),
      //       ),
      //       child: ToggleButtons(
      //         constraints: const BoxConstraints(minHeight: 28, minWidth: 45),
      //         borderRadius: BorderRadius.circular(15),
      //         selectedColor: Colors.white,
      //         fillColor: const Color(0xFF1565C0),
      //         color: Colors.white60,
      //         isSelected: [!_isHindi, _isHindi],
      //         onPressed: (int index) {
      //           setState(() {
      //             _isHindi = index == 1;
      //           });
      //         },
      //         children: const [
      //           Text(
      //             'En',
      //             style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      //           ),
      //           Text(
      //             'हिं',
      //             style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      //           ),
      //         ],
      //       ),
      //     ),
      //     const SizedBox(width: 8),
      //     IconButton(
      //       icon: const Icon(Icons.share_outlined, color: Colors.white),
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: const Icon(Icons.more_vert, color: Colors.white),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
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
                // Header Title inside body
                Text(
                  _isHindi
                      ? 'नेटवर्क स्थान\nअनुमतियाँ'
                      : 'Network Location\nPermissions',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),

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
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: _isHindi ? 'नाम खोजें' : 'Search Name',
                      hintStyle: const TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
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

                // User Cards List or Loader
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF0B4F4A),
                          ),
                        )
                      : filteredUsers.isEmpty
                      ? Center(
                          child: Text(
                            _isHindi
                                ? 'कोई स्वीकृत कनेक्शन नहीं मिला'
                                : 'No accepted connections found',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            return _buildUserCard(filteredUsers[index]);
                          },
                        ),
                ),

                // Active Connections Count
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _isHindi ? 'सक्रिय कनेक्शन' : 'ACTIVE CONNECTIONS',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$activeCount',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Save Permissions Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isHindi
                                  ? 'अनुमतियाँ सफलतापूर्वक सहेजी गईं!'
                                  : 'Permissions saved successfully!',
                            ),
                            backgroundColor: const Color(0xFF0B4F4A),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B4F4A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        _isHindi ? 'अनुमतियाँ सहेजें' : 'Save Permissions',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
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

  Widget _buildUserCard(UserPermission user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCDFE4), width: 1),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: user.avatarColor,
            child: Text(
              user.initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
                const SizedBox(height: 2),
                Text(
                  user.isShared
                      ? (_isHindi
                            ? 'ट्रैक नेटवर्क पर स्थान साझा किया गया'
                            : 'Location shared on Track Network')
                      : (_isHindi
                            ? 'ट्रैक नेटवर्क पर स्थान छिपा हुआ है'
                            : 'Location hidden on Track Network'),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: user.isShared
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFC62828),
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: user.isShared,
              activeTrackColor: const Color(0xFF0B4F4A),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFB0BEC5),
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              onChanged: (bool value) {
                setState(() {
                  user.isShared = value;
                });
              },
            ),
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
  final String initials;
  final Color avatarColor;
  bool isShared;

  UserPermission({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.initials,
    required this.avatarColor,
    this.isShared = false,
  });
}

class NetworkService {
  Future<List<UserPermission>> fetchAcceptedConnections() async {
    // Simulate network delay for backend / database retrieval
    await Future.delayed(const Duration(milliseconds: 600));

    return [
      UserPermission(
        id: '1',
        nameEn: 'Vikram Singh',
        nameHi: 'विक्रम सिंह',
        initials: 'VS',
        avatarColor: const Color(0xFF1E88E5),
        isShared: false,
      ),
      UserPermission(
        id: '2',
        nameEn: 'Neha Gupta',
        nameHi: 'नेहा गुप्ता',
        initials: 'NG',
        avatarColor: const Color(0xFF43A047),
        isShared: false,
      ),
      UserPermission(
        id: '3',
        nameEn: 'Ramesh Sharma',
        nameHi: 'रमेश शर्मा',
        initials: 'RS',
        avatarColor: const Color(0xFF8E24AA),
        isShared: false,
      ),
      UserPermission(
        id: '4',
        nameEn: 'Amit Kumar',
        nameHi: 'अमित कुमार',
        initials: 'AK',
        avatarColor: const Color(0xFFE91E63),
        isShared: false,
      ),
    ];
  }
}
