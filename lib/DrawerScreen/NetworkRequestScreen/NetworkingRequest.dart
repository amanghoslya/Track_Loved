import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';
import 'package:track_loved/DrawerScreen/AddNetworkScreen/AddNetWorkScreen.dart';
import 'package:track_loved/DrawerScreen/ExploreBusinessScreen.dart';
import 'package:track_loved/DrawerScreen/NetworkLocationpermissions.dart'
    hide AppDrawer;
import 'package:track_loved/DrawerScreen/NetworkRequestScreen/Provider/NetworkRequestProvider.dart';
import 'package:track_loved/DrawerScreen/SearchLovedOnseScreen.dart';
import 'package:track_loved/HomeScreen/DashboardScreen.dart';

class NetworkingRequestScreen extends ConsumerStatefulWidget {
  const NetworkingRequestScreen({super.key});

  @override
  ConsumerState<NetworkingRequestScreen> createState() =>
      NetworkingRequestScreenState();
}

class NetworkingRequestScreenState
    extends ConsumerState<NetworkingRequestScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isHindi = false;

  final List<Member> _members = [
    Member(
      id: '1',
      nameEn: 'Vikram Singh',
      nameHi: 'विक्रम सिंह',
      roleEn: 'Backend Developer',
      roleHi: 'बैकएंड डेवलपर',
      currentAddress: 'Sector 62, Noida, UP - 201301',
      permanentAddress: 'Sector 16, Faridabad, HR - 121002',
      initials: 'VS',
      status: ConnectionStatus.pendingReceived,
    ),
    Member(
      id: '2',
      nameEn: 'Neha Gupta',
      nameHi: 'नेहा गुप्ता',
      roleEn: 'UI/UX Designer',
      roleHi: 'यूआई/यूएक्स डिजाइनर',
      currentAddress: 'HSR Layout, Bengaluru, KA - 560102',
      permanentAddress: 'Sainipura, Faridabad, HR - 121001',
      initials: 'NG',
      status: ConnectionStatus.pendingReceived,
    ),
    Member(
      id: '3',
      nameEn: 'Ramesh Sharma',
      nameHi: 'रमेश शर्मा',
      roleEn: 'Senior Software Engineer',
      roleHi: 'सीनियर सॉफ्टवेयर इंजीनियर',
      currentAddress: 'Indiranagar, Bengaluru, KA - 560038',
      permanentAddress: 'Sainipura, Faridabad, HR - 121001',
      initials: 'RS',
      status: ConnectionStatus.none,
    ),
    Member(
      id: '4',
      nameEn: 'Amit Kumar',
      nameHi: 'अमित कुमार',
      roleEn: 'Product Manager',
      roleHi: 'उत्पाद प्रबंधक',
      currentAddress: 'Whitefield, Bengaluru, KA - 560066',
      permanentAddress: 'Sector 21, Faridabad, HR - 121001',
      initials: 'AK',
      status: ConnectionStatus.pendingSent,
    ),
  ];

  int get _pendingRequestsCount => _members
      .where((m) => m.status == ConnectionStatus.pendingReceived)
      .length;

  void _acceptRequest(Member member) {
    setState(() {
      member.status = ConnectionStatus.connected;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isHindi
              ? 'अब आप ${member.nameHi} से जुड़े हैं'
              : 'You are now connected with ${member.nameEn}',
        ),
        backgroundColor: const Color(0xFF2E7D32),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _rejectRequest(Member member) {
    setState(() {
      member.status = ConnectionStatus.none;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isHindi
              ? '${member.nameHi} का कनेक्शन अनुरोध अस्वीकार कर दिया गया'
              : 'Connection request from ${member.nameEn} rejected',
        ),
        backgroundColor: const Color(0xFFD32F2F),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final networkRequest = ref.watch(networkRequestProvider);
    final incomingRequests = _members
        .where((m) => m.status == ConnectionStatus.pendingReceived)
        .toList();
    final otherMembers = _members
        .where((m) => m.status != ConnectionStatus.pendingReceived)
        .toList();

    return Scaffold(
      drawer: AppDrawer(isHindi: _isHindi),
      backgroundColor: const Color(0xFF002E29),
      key: _scaffoldKey,
      appBar: AppBarScreen(
        titleEn: 'Networking requests',
        titleHi: 'नेटवर्किंग अनुरोध',
        isHindi: _isHindi,
        notificationCount: 2,
        onLanguageChanged: (value) {
          setState(() {
            _isHindi = value;
          });
        },
      ),
      body: networkRequest.when(
        data: (data) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (incomingRequests.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isHindi ? 'आने वाले अनुरोध' : 'Incoming Requests',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B4F4A),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${incomingRequests.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: incomingRequests.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _buildIncomingRequestCard(incomingRequests[index]);
                    },
                  ),
                ],
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(
              _isHindi ? 'डेटा लोड करने में त्रुटि आई' : 'Error loading data',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        loading: () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIncomingRequestCard(Member member) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCDFE4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFF0B4F4A),
                child: Text(
                  member.initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isHindi ? member.nameHi : member.nameEn,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      _isHindi ? member.roleHi : member.roleEn,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, color: Colors.redAccent, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${_isHindi ? 'वर्तमान: ' : 'Current: '}${member.currentAddress}',
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _acceptRequest(member),
                  icon: const Icon(Icons.check, size: 16, color: Colors.white),
                  label: Text(
                    _isHindi ? 'स्वीकार करें' : 'Accept',
                    style: const TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _rejectRequest(member),
                  icon: const Icon(
                    Icons.close,
                    size: 16,
                    color: Color(0xFFD32F2F),
                  ),
                  label: Text(
                    _isHindi ? 'अस्वीकार करें' : 'Reject',
                    style: const TextStyle(color: Color(0xFFD32F2F)),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFD32F2F)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(Member member) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCDFE4)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF0B4F4A),
            child: Text(
              member.initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isHindi ? member.nameHi : member.nameEn,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  _isHindi ? member.roleHi : member.roleEn,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          _buildActionButton(member),
        ],
      ),
    );
  }

  Widget _buildActionButton(Member member) {
    switch (member.status) {
      case ConnectionStatus.connected:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            _isHindi ? 'जुड़े हुए' : 'Connected',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
            ),
          ),
        );

      case ConnectionStatus.pendingSent:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF4FA),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFB0BEC5)),
          ),
          child: Text(
            _isHindi ? '⏳ लंबित' : '⏳ Pending',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF0B4F4A),
              fontWeight: FontWeight.bold,
            ),
          ),
        );

      case ConnectionStatus.none:
      default:
        return ElevatedButton(
          onPressed: () {
            setState(() {
              member.status = ConnectionStatus.pendingSent;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0B4F4A),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            _isHindi ? '+ जोड़ें' : '+ Connect',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        );
    }
  }
}

enum ConnectionStatus { none, pendingSent, pendingReceived, connected }

class Member {
  final String id;
  final String nameEn;
  final String nameHi;
  final String roleEn;
  final String roleHi;
  final String currentAddress;
  final String permanentAddress;
  final String initials;
  ConnectionStatus status;

  Member({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.roleEn,
    required this.roleHi,
    required this.currentAddress,
    required this.permanentAddress,
    required this.initials,
    this.status = ConnectionStatus.none,
  });
}
