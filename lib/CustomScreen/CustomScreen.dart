import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:track_loved/DrawerScreen/AddNetworkScreen/AddNetWorkScreen.dart';
import 'package:track_loved/DrawerScreen/ExpandYourBusiness.dart';
import 'package:track_loved/DrawerScreen/ExploreBusinessScreen.dart';
import 'package:track_loved/DrawerScreen/Feedback_And_Google_Rating.dart';
import 'package:track_loved/DrawerScreen/KnowYourLawScreen.dart';
import 'package:track_loved/DrawerScreen/NetworkLocationpermissions.dart';
import 'package:track_loved/DrawerScreen/NetworkRequestScreen/NetworkingRequest.dart';
import 'package:track_loved/DrawerScreen/PostBusinessOpportunitiesScreen.dart';
import 'package:track_loved/DrawerScreen/PostJobOpprtunities.dart';
import 'package:track_loved/DrawerScreen/SearchLovedOnseScreen.dart';
import 'package:track_loved/HomeScreen/NotificationScreen.dart';
import 'package:track_loved/LoginScreen/LoginScreen.dart';

class AppDrawer extends StatelessWidget {
  final bool isHindi;
  const AppDrawer({super.key, required this.isHindi});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF0B4F4A)),
            accountName: const Text(
              'Ramesh Sharma',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text('ramesh.sharma@example.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'RS',
                style: TextStyle(
                  color: Color(0xFF0B4F4A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.dashboard, color: Color(0xFF0B4F4A)),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.person_add, color: Color(0xFF0B4F4A)),
            title: const Text('Add Network'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AddNetworkSearchScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.location_pin, color: Color(0xFF0B4F4A)),
            title: const Text('Network Location Permissions'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => NetworkLocationPermissionsScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.people_alt, color: Color(0xFF0B4F4A)),
            title: const Text('Networking Requests'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const NetworkingRequestScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.favorite, color: Color(0xFF0B4F4A)),
            title: const Text('Track Loved Ones'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => SearchLovedOnesScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.business_center,
              color: Color(0xFF0B4F4A),
            ),
            title: const Text('Explore Business Opportunities'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ExploreBusinessScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.add_business, color: Color(0xFF0B4F4A)),
            title: const Text('Post Business Opportunities'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostBusinessOpportunitiesScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.work, color: Color(0xFF0B4F4A)),
            title: const Text('Expand Your Business'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => ExpandYourBusiness()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.gavel, color: Color(0xFF0B4F4A)),
            title: const Text('Know Your Law'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => LegalAwarenessApp()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add, color: Color(0xFF0B4F4A)),
            title: const Text('Post Job Opportunities'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => PostJobOpportunitiesScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.feedback, color: Color(0xFF0B4F4A)),
            title: const Text('Google Feedback'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackRatingScreen()),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF0B4F4A)),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFF0B4F4A)),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text(
                      'Sign Out',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text('Are you sure you want to sign out?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(dialogContext);

                          if (!context.mounted) return;
                          var box = Hive.box("userdata");
                          await box.clear();

                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class AppBarScreen extends StatefulWidget implements PreferredSizeWidget {
  final String titleEn;
  final String titleHi;
  final bool isHindi;
  final ValueChanged<bool> onLanguageChanged;
  final VoidCallback? onNotificationPressed;
  final int notificationCount;

  const AppBarScreen({
    super.key,
    required this.titleEn,
    required this.titleHi,
    required this.isHindi,
    required this.onLanguageChanged,
    this.onNotificationPressed,
    this.notificationCount = 0,
  });

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarScreenState extends State<AppBarScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0B4F4A),

      elevation: 0,
      centerTitle: false, // Title ko start (left) align karne ke liye
      titleSpacing: 0, // Icon aur Title ke beech extra gap khatam karne ke liye
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text(
        widget.isHindi ? widget.titleHi : widget.titleEn,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),

      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ToggleButtons(
            constraints: const BoxConstraints(minHeight: 28, minWidth: 45),
            borderRadius: BorderRadius.circular(15),
            selectedColor: Colors.white,
            fillColor: const Color(0xFF1565C0),
            color: Colors.white60,
            isSelected: [!widget.isHindi, widget.isHindi],
            onPressed: (int index) {
              widget.onLanguageChanged(index == 1);
            },
            children: const [
              Text(
                'En',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              Text(
                'हिं',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),

        // Notification Badge Icon
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NotificationScreen(isHindi: widget.isHindi),
              ),
            );
          },
        ),
      ],
    );
  }
}
