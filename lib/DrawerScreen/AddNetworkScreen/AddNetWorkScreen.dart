import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';
import 'package:track_loved/DrawerScreen/AddNetworkScreen/Provider/AddNetoworkserachProvider.dart';
import 'package:track_loved/core/Data/ResponseModel/AddNetworkSearchResModel.dart';

class AddNetworkSearchScreen extends ConsumerStatefulWidget {
  const AddNetworkSearchScreen({super.key});

  @override
  ConsumerState<AddNetworkSearchScreen> createState() =>
      _AddNetworkSearchScreenState();
}

class _AddNetworkSearchScreenState
    extends ConsumerState<AddNetworkSearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _memberSearchController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  String _searchQuery = '';
  String _activePincode = '';
  bool _isHindi = false;
  bool _isPincodeValid = true;
  String _validationMessage = '';
  Timer? _debounceTimer;

  void _validatePincode(String pincode) {
    final cleanPin = pincode.trim();
    if (cleanPin.isEmpty) {
      setState(() {
        _isPincodeValid = true;
        _validationMessage = '';
        _activePincode = '';
      });
      return;
    }

    final isNumeric = RegExp(r'^[0-9]+$').hasMatch(cleanPin);

    setState(() {
      _activePincode = cleanPin;
      if (!isNumeric) {
        _isPincodeValid = false;
        _validationMessage = _isHindi
            ? 'पिन कोड में केवल अंक होने चाहिए।'
            : 'Pincode should contain only digits.';
      } else if (cleanPin.length > 6) {
        _isPincodeValid = false;
        _validationMessage = _isHindi
            ? 'पिन कोड अधिकतम 6 अंकों का होना चाहिए।'
            : 'Pincode must be up to 6 digits.';
      } else {
        _isPincodeValid = true;
        _validationMessage = '';
      }
    });
  }

  void _onSearchChanged(String val) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _searchQuery = val.trim();
        });
      }
    });
  }

  void _onPincodeChanged(String pincode) {
    _validatePincode(pincode);
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _activePincode = pincode.trim();
        });
      }
    });
  }

  String get _effectiveQuery {
    if (_searchQuery.isNotEmpty) {
      return _searchQuery;
    }
    if (_activePincode.isNotEmpty) {
      return _activePincode;
    }
    return '';
  }

  void _showImportContactsModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _isHindi ? 'संपर्क आयात करें' : 'Import Contacts',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isHindi
                        ? 'चुनें कि आप अपने संपर्क कहाँ से सिंक करना चाहते हैं:'
                        : 'Choose where you want to sync your contacts from:',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  if (isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFF0B4F4A),
                        ),
                      ),
                    )
                  else ...[
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFEBF2FA),
                        child: Icon(
                          Icons.phone_android,
                          color: Color(0xFF0B4F4A),
                        ),
                      ),
                      title: Text(_isHindi ? 'फ़ोन संपर्क' : 'Phone Contacts'),
                      subtitle: Text(
                        _isHindi
                            ? 'स्थानीय डिवाइस संपर्क सिंक करें'
                            : 'Sync local device contacts',
                      ),
                      onTap: () async {
                        setModalState(() => isLoading = true);
                        await Future.delayed(const Duration(seconds: 1));
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isHindi
                                  ? 'फ़ोन से संपर्क सफलतापूर्वक आयात किए गए!'
                                  : 'Phone contacts imported successfully!',
                            ),
                            backgroundColor: const Color(0xFF4CAF50),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFEBF2FA),
                        child: Icon(
                          Icons.g_mobiledata,
                          color: Color(0xFF1565C0),
                          size: 32,
                        ),
                      ),
                      title: Text(_isHindi ? 'गूगल संपर्क' : 'Google Contacts'),
                      subtitle: Text(
                        _isHindi
                            ? 'Google खाते से संपर्क सिंक करें'
                            : 'Sync contacts from Google account',
                      ),
                      onTap: () async {
                        setModalState(() => isLoading = true);
                        await Future.delayed(const Duration(seconds: 1));
                        if (!context.mounted) return;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _isHindi
                                  ? 'गूगल से संपर्क सफलतापूर्वक आयात किए गए!'
                                  : 'Google contacts imported successfully!',
                            ),
                            backgroundColor: const Color(0xFF4CAF50),
                          ),
                        );
                      },
                    ),
                  ],
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _openChatScreen(NetworkMember member) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MemberChatScreen(member: member, isHindi: _isHindi),
      ),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _memberSearchController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addNetwork = ref.watch(addNetworkSerachProvider(_effectiveQuery));

    return Scaffold(
      backgroundColor: const Color(0xFF002E29),
      key: _scaffoldKey,
      drawer: AppDrawer(isHindi: _isHindi),
      appBar: AppBarScreen(
        titleEn: 'Add Network Search',
        titleHi: 'नेटवर्क खोज जोड़ें',
        isHindi: _isHindi,
        notificationCount: 2,
        onLanguageChanged: (value) {
          setState(() {
            _isHindi = value;
          });
        },
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: const Color(0xFFDCDFE4),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.black45),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: _memberSearchController,
                                onChanged: _onSearchChanged,
                                decoration: InputDecoration(
                                  hintText: _isHindi
                                      ? 'नाम, भूमिका, शहर या पिनकोड से खोजें...'
                                      : 'Search members by name, role, city, pincode...',
                                  hintStyle: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 13,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if (_memberSearchController.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  size: 18,
                                  color: Colors.black45,
                                ),
                                onPressed: () {
                                  _memberSearchController.clear();
                                  _onSearchChanged('');
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: _showImportContactsModal,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0B4F4A),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.contacts,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _isHindi ? 'संपर्क' : 'Contacts',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isPincodeValid
                        ? const Color(0xFFEBF2FA)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isPincodeValid
                          ? Colors.transparent
                          : Colors.red.shade200,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: _isPincodeValid
                                ? const Color(0xFF1967D2)
                                : Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _isHindi
                                      ? 'पिन कोड खोज मोड'
                                      : 'Pin Code Search Mode',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: _isPincodeValid
                                        ? const Color(0xFF1967D2)
                                        : Colors.red.shade700,
                                  ),
                                ),
                                Text(
                                  _activePincode.isEmpty
                                      ? (_isHindi
                                          ? 'सभी पिन कोड दिखाए जा रहे हैं'
                                          : 'Showing all pin codes')
                                      : (_isHindi
                                          ? 'पिन कोड से खोजा जा रहा है: $_activePincode'
                                          : 'Searching by pin code: $_activePincode'),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 105,
                            height: 38,
                            child: TextField(
                              controller: _pincodeController,
                              keyboardType: TextInputType.number,
                              maxLength: 6,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 0,
                                ),
                                hintText: _isHindi ? 'पिनकोड' : 'Pincode',
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: _pincodeController.text.isNotEmpty
                                    ? IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(
                                          Icons.clear,
                                          size: 16,
                                          color: Colors.black45,
                                        ),
                                        onPressed: () {
                                          _pincodeController.clear();
                                          _onPincodeChanged('');
                                        },
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: _onPincodeChanged,
                            ),
                          ),
                        ],
                      ),
                      if (_validationMessage.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          _validationMessage,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: addNetwork.when(
                    data: (data) {
                      final allUsers = data.data?.users ?? [];
                      final filteredMembers = allUsers.where((member) {
                        if (_activePincode.isEmpty) return true;
                        final memberPin = member.pincode ?? '';
                        if (memberPin.isNotEmpty) {
                          return memberPin.contains(_activePincode);
                        }
                        return true;
                      }).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDynamicFilterChips(filteredMembers),
                          const SizedBox(height: 12),
                          Expanded(
                            child: filteredMembers.isEmpty
                                ? Center(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.person_search_outlined,
                                            size: 48,
                                            color: Colors.white60,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            _isHindi
                                                ? 'आपकी खोज से मेल खाता कोई सदस्य नहीं मिला।'
                                                : 'No members found matching your search.',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: filteredMembers.length,
                                    itemBuilder: (context, index) {
                                      return _buildMemberCard(
                                        filteredMembers[index],
                                      );
                                    },
                                  ),
                          ),
                        ],
                      );
                    },
                    loading: () {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDynamicFilterChips([]),
                          const SizedBox(height: 12),
                          const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(
                        child: Text(
                          _isHindi
                              ? 'डेटा लोड करने में त्रुटि आई'
                              : 'Error loading data',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
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

  Widget _buildDynamicFilterChips(List<User> users) {
    final Set<String> states = {};
    final Set<String> cities = {};

    for (var u in users) {
      if (u.state != null && u.state!.trim().isNotEmpty) {
        states.add(u.state!.trim());
      }
      if (u.city != null && u.city!.trim().isNotEmpty) {
        cities.add(u.city!.trim());
      }
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildInfoChip(
          _isHindi ? 'पिन कोड' : 'Pin Code',
          _activePincode.isEmpty ? (_isHindi ? 'सभी' : 'All') : _activePincode,
        ),
        if (_searchQuery.isNotEmpty)
          _buildInfoChip(
            _isHindi ? 'खोज' : 'Search',
            _searchQuery,
          ),
        if (states.isNotEmpty)
          _buildInfoChip(
            _isHindi ? 'राज्य' : 'State',
            states.take(2).join(', '),
          ),
        if (cities.isNotEmpty)
          _buildInfoChip(
            _isHindi ? 'शहर' : 'City',
            cities.take(2).join(', '),
          ),
        _buildInfoChip(
          _isHindi ? 'सदस्य' : 'Members',
          '${users.length}',
        ),
      ],
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E7EE)),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: Colors.black87),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(color: Colors.black54),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard(User member) {
    final String name = member.name ?? 'Unknown User';
    final String profession = member.profession ?? '';
    final String bio = member.bio ?? '';
    final String city = member.city ?? '';
    final String state = member.state ?? '';
    final String country = member.country ?? '';
    final String memberPincode = member.pincode ?? '';
    final String profileImage = member.profileImage ?? '';

    final String location = [
      city,
      state,
      country,
      if (memberPincode.isNotEmpty) 'PIN: $memberPincode',
    ].where((value) => value.isNotEmpty).join(', ');

    final String initials = name.trim().isEmpty
        ? '?'
        : name
              .trim()
              .split(RegExp(r'\s+'))
              .take(2)
              .map((word) => word[0])
              .join()
              .toUpperCase();

    // final bool isPending = _pendingUserIds.contains(userId);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDCDFE4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFF0B4F4A),
                backgroundImage: profileImage.isNotEmpty
                    ? NetworkImage(profileImage)
                    : null,
                child: profileImage.isEmpty
                    ? Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (member.isVerified == true)
                          const Icon(
                            Icons.verified,
                            color: Color(0xFF0B8F68),
                            size: 17,
                          ),
                      ],
                    ),
                    if (profession.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        profession,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                    if (bio.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        bio,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B4F4A),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      (_isHindi ? 'लंबित' : 'Pending'),
                      // : (_isHindi ? '+ जोड़ें' : '+ Connect'),,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // _openChatScreen(member);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006B63),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.chat, size: 16),
                    label: Text(
                      _isHindi ? 'चैट' : 'Chat',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (location.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.redAccent,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: _isHindi ? 'स्थान: ' : 'Location: ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: location),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class MemberChatScreen extends StatefulWidget {
  final NetworkMember member;
  final bool isHindi;

  const MemberChatScreen({
    super.key,
    required this.member,
    required this.isHindi,
  });

  @override
  State<MemberChatScreen> createState() => _MemberChatScreenState();
}

class _MemberChatScreenState extends State<MemberChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Hello! Glad to connect.', isMe: false, time: '10:00 AM'),
    ChatMessage(
      text: 'Hi, thanks for connecting!',
      isMe: true,
      time: '10:02 AM',
    ),
  ];

  void _sendMessage() {
    if (_msgController.text.trim().isEmpty) return;
    setState(() {
      _messages.add(
        ChatMessage(
          text: _msgController.text.trim(),
          isMe: true,
          time: TimeOfDay.now().format(context),
        ),
      );
      _msgController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final memberName = widget.isHindi
        ? widget.member.nameHi
        : widget.member.nameEn;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4F4A),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Text(
                widget.member.initials,
                style: const TextStyle(
                  color: Color(0xFF0B4F4A),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  memberName,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  widget.isHindi ? 'ऑनलाइन' : 'Online',
                  style: const TextStyle(fontSize: 10, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: msg.isMe
                          ? const Color(0xFF0B4F4A)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          msg.text,
                          style: TextStyle(
                            color: msg.isMe ? Colors.white : Colors.black87,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          msg.time,
                          style: TextStyle(
                            color: msg.isMe ? Colors.white70 : Colors.black54,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: InputDecoration(
                      hintText: widget.isHindi
                          ? 'संदेश लिखें...'
                          : 'Type a message...',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF0B4F4A),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 18),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({required this.text, required this.isMe, required this.time});
}

enum ConnectionStatus { none, pendingSent, pendingReceived, connected }

class Member {
  final String id;
  final String name;
  final String initials;
  ConnectionStatus status;

  Member({
    required this.id,
    required this.name,
    required this.initials,
    this.status = ConnectionStatus.none,
  });
}

class ActivityLog {
  final String title;
  final DateTime timestamp;

  ActivityLog({required this.title, required this.timestamp});
}

class NetworkMember {
  final String id;
  final String nameEn;
  final String nameHi;
  final String roleEn;
  final String roleHi;
  final String initials;
  final String currentLocation;
  final String permanentLocation;
  final String pincode;
  bool isPending;

  NetworkMember({
    required this.id,
    required this.nameEn,
    required this.nameHi,
    required this.roleEn,
    required this.roleHi,
    required this.initials,
    required this.currentLocation,
    required this.permanentLocation,
    required this.pincode,
    this.isPending = false,
  });
}
