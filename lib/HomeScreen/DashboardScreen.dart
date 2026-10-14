import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';
// class BottomNavigationBarScreen extends StatefulWidget {
//   const BottomNavigationBarScreen({super.key});

//   @override
//   State<BottomNavigationBarScreen> createState() =>
//       _BottomNavigationBarScreenState();
// }

// class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int selectedBottomIndex = 0;
//   List<Widget> get pages => [
//     DynamicDashboardScreen(),
//     ProfileScreen(),
//     Messagescreen(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (selectedBottomIndex != 0) {
//           setState(() {
//             selectedBottomIndex = 0;
//           });
//           return false;
//         }
//         return true;
//       },
//       child: Scaffold(
//         key: _scaffoldKey,

//         // Drawer
//         drawer: const AppDrawer(isHindi: false),
//         body: pages[selectedBottomIndex],
//         bottomNavigationBar: Container(
//           width: double.infinity,
//           height: 70,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withValues(alpha: 0.10),
//                 blurRadius: 10,
//                 spreadRadius: 1,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: _bottomItem(index: 0, icon: Icons.home, title: 'Home'),
//               ),
//               Expanded(
//                 child: _bottomItem(
//                   index: 1,
//                   icon: Icons.person_outline,
//                   title: 'Profile',
//                 ),
//               ),
//               Expanded(
//                 child: _bottomItem(
//                   index: 2,
//                   icon: Icons.chat_bubble_outline,
//                   title: 'Messages',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _bottomItem({
//     required IconData icon,
//     required String title,
//     required int index,
//   }) {
//     final bool isSelected = selectedBottomIndex == index;

//     return InkWell(
//       onTap: () {
//         setState(() {
//           selectedBottomIndex = index;
//         });
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 52,
//             height: 28,
//             decoration: BoxDecoration(
//               color: isSelected ? const Color(0xFFB9E3DE) : Colors.transparent,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Icon(
//               icon,
//               size: 18,
//               color: isSelected ? const Color(0xFF0B4F4A) : Colors.black54,
//             ),
//           ),

//           const SizedBox(height: 2),

//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 10,
//               fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
//               color: isSelected ? const Color(0xFF0B4F4A) : Colors.black54,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DynamicDashboardScreen extends StatefulWidget {
  const DynamicDashboardScreen({super.key});

  @override
  State<DynamicDashboardScreen> createState() => _DynamicDashboardScreenState();
}

class _DynamicDashboardScreenState extends State<DynamicDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: const AppDrawer(isHindi: false),

      // AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4F4A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: const Text(
          'My Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          const Icon(Icons.tune, color: Colors.white, size: 20),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            tooltip: '',
            onPressed: () {},
          ),
        ],
      ),

      // Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 58,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: const Color(0xFF0B4F4A),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      decoration: InputDecoration(
                        hintText: 'Add network...',
                        hintStyle: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white70,
                          size: 18,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        contentPadding: const EdgeInsets.only(bottom: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.tune, color: Colors.white, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      // =====================================================
                      // ALERTS & TASKS
                      // =====================================================
                      Expanded(
                        child: Container(
                          height: 165,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Alerts & Tasks Card',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Center(
                                child: Text(
                                  '12',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xffE5F0EF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.people_outline,
                                      size: 17,
                                      color: Color(0xff0B4F4A),
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Connection',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          'Requests (5)',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xffE5F0EF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: 17,
                                      color: Color(0xff0B4F4A),
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'System',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          'Alerts (7)',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // =====================================================
                      // RECENT TIMELINE
                      // =====================================================
                      Expanded(
                        child: Container(
                          height: 165,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Timeline',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 7,
                                    color: Color(0xff0B4F4A),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'New request from Sarah J. (just now)',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 7,
                                    color: Color(0xff0B4F4A),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'Address updated (3 hours ago)',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 7,
                                    color: Color(0xff0B4F4A),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'Address updated (3 hours ago)',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // =====================================================
                      // NETWORK OVERVIEW
                      // =====================================================
                      Expanded(
                        child: Container(
                          height: 165,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Network',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Overview Card',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                '548',
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                'Total Connections: 548',
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 32,
                                width: 115,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.brown.shade300,
                                        child: const Icon(
                                          Icons.person,
                                          size: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 17,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey.shade500,
                                        child: const Icon(
                                          Icons.person,
                                          size: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 34,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.brown.shade400,
                                        child: const Icon(
                                          Icons.person,
                                          size: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 51,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey.shade600,
                                        child: const Icon(
                                          Icons.person,
                                          size: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 68,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          color: Color(0xff0B4F4A),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '+34',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // =====================================================
                      // PERFORMANCE
                      // =====================================================
                      Expanded(
                        child: Container(
                          height: 165,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Performance',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Text(
                                'Insights Card',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 12,
                                      height: 35,
                                      color: const Color(0xff3B8C84),
                                    ),
                                    Container(
                                      width: 12,
                                      height: 60,
                                      color: const Color(0xff3B8C84),
                                    ),
                                    Container(
                                      width: 12,
                                      height: 45,
                                      color: const Color(0xff3B8C84),
                                    ),
                                    Container(
                                      width: 12,
                                      height: 28,
                                      color: const Color(0xff3B8C84),
                                    ),
                                    Container(
                                      width: 12,
                                      height: 52,
                                      color: const Color(0xff3B8C84),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Mo', style: TextStyle(fontSize: 11)),
                                  Text('Tu', style: TextStyle(fontSize: 11)),
                                  Text('We', style: TextStyle(fontSize: 11)),
                                  Text('Th', style: TextStyle(fontSize: 11)),
                                  Text('Fr', style: TextStyle(fontSize: 11)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
