// import 'package:flutter/material.dart';
// import 'package:track_loved/CustomScreen/CustomScreen.dart';

// class LegalAwarenessApp extends StatefulWidget {
//   const LegalAwarenessApp({super.key});

//   @override
//   State<LegalAwarenessApp> createState() => _LegalAwarenessAppState();
// }

// class _LegalAwarenessAppState extends State<LegalAwarenessApp> {
//   bool _isHindi = false;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Legal Awareness India',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F4C81)),
//         scaffoldBackgroundColor: const Color(0xFFF4F7FA),
//         fontFamily: 'Roboto',
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const LegalThemesScreen(),
//         '/admin-upload': (context) => const AdminVideoUploadScreen(),
//       },
//     );
//   }
// }

// // Data Models
// class LegalSectionDetail {
//   final String sectionTitle;
//   final String explanation;
//   final String youtubeVideoUrl;

//   LegalSectionDetail({
//     required this.sectionTitle,
//     required this.explanation,
//     required this.youtubeVideoUrl,
//   });
// }

// class LandmarkCaseDetail {
//   final String caseName;
//   final String summary;
//   final String youtubeVideoUrl;

//   LandmarkCaseDetail({
//     required this.caseName,
//     required this.summary,
//     required this.youtubeVideoUrl,
//   });
// }

// class LegalActDetail {
//   final String actName;
//   final String englishPdfUrl;
//   final String hindiPdfUrl;
//   final List<LegalSectionDetail> sections;
//   final List<LandmarkCaseDetail> landmarkCases;

//   LegalActDetail({
//     required this.actName,
//     required this.englishPdfUrl,
//     required this.hindiPdfUrl,
//     required this.sections,
//     required this.landmarkCases,
//   });
// }

// class LegalTopic {
//   final String titleEn;
//   final String titleHi;
//   final String description;
//   final IconData icon;
//   final String youtubeUrl;
//   final List<LegalActDetail> acts;

//   LegalTopic({
//     required this.titleEn,
//     required this.titleHi,
//     required this.description,
//     required this.icon,
//     required this.youtubeUrl,
//     required this.acts,
//   });
// }

// class LegalThemesScreen extends StatefulWidget {
//   const LegalThemesScreen({super.key});

//   @override
//   State<LegalThemesScreen> createState() => _LegalThemesScreenState();
// }

// class _LegalThemesScreenState extends State<LegalThemesScreen> {
//   bool _isHindi = false;
//   List<LegalTopic> getTopics() {
//     return [
//       LegalTopic(
//         titleEn: 'Everyday Citizen Rights',
//         titleHi: 'दैनिक नागरिक अधिकार',
//         description:
//             'Know your rights during police checks, traffic fines, FIR filing, and cybercrime reporting.',
//         icon: Icons.gavel,
//         youtubeUrl: 'https://www.youtube.com/@YourChannelName',
//         acts: [
//           LegalActDetail(
//             actName: 'Bharatiya Nyaya Sanhita (BNS)',
//             englishPdfUrl:
//                 'https://www.mha.gov.in/sites/default/files/250882_english_01042024.pdf',
//             hindiPdfUrl:
//                 'https://www.mha.gov.in/sites/default/files/250882_hindi_ubah_01042024.pdf',
//             sections: [
//               LegalSectionDetail(
//                 sectionTitle: 'Section 35: General Exceptions',
//                 explanation:
//                     'Acts done in good faith or under mistake of fact.',
//                 youtubeVideoUrl:
//                     'https://www.youtube.com/watch?v=ExampleSection35',
//               ),
//               LegalSectionDetail(
//                 sectionTitle: 'Section 103: Punishment for Murder',
//                 explanation:
//                     'Death sentence or imprisonment for life with fine.',
//                 youtubeVideoUrl:
//                     'https://www.youtube.com/watch?v=ExampleSection103',
//               ),
//             ],
//             landmarkCases: [
//               LandmarkCaseDetail(
//                 caseName: 'D.K. Basu v. State of West Bengal',
//                 summary:
//                     'Set mandatory guidelines for police during arrests and detentions.',
//                 youtubeVideoUrl:
//                     'https://www.youtube.com/watch?v=ExampleDKBasuCase',
//               ),
//             ],
//           ),
//         ],
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final topics = getTopics();

//     return Scaffold(
//       drawer: AppDrawer(isHindi: _isHindi),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0F4C81),
//         title: const Text(
//           'Know Your Laws / कानून जानें',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
//             tooltip: 'Admin Portal',
//             onPressed: () => Navigator.pushNamed(context, '/admin-upload'),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: topics.length,
//           itemBuilder: (context, index) {
//             final topic = topics[index];
//             return Card(
//               elevation: 2,
//               margin: const EdgeInsets.only(bottom: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: const Color(0xFFE0ECF8),
//                           child: Icon(
//                             topic.icon,
//                             color: const Color(0xFF0F4C81),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 topic.titleEn,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 topic.titleHi,
//                                 style: const TextStyle(
//                                   fontSize: 13,
//                                   color: Colors.black54,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       topic.description,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'Applicable Acts (Tap for Section-by-Section Explanations):',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF0F4C81),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     ...topic.acts.map(
//                       (act) => Container(
//                         margin: const EdgeInsets.only(bottom: 6),
//                         child: InkWell(
//                           onTap: () {
//                             showModalBottomSheet(
//                               context: context,
//                               isScrollControlled: true,
//                               backgroundColor: Colors.transparent,
//                               builder: (context) =>
//                                   ActDetailBottomSheet(act: act),
//                             );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFF0F4F8),
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(
//                                 color: const Color(0xFFD0E1F9),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     act.actName,
//                                     style: const TextStyle(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xFF0F4C81),
//                                     ),
//                                   ),
//                                 ),
//                                 const Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 14,
//                                   color: Color(0xFF0F4C81),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // Bottom Sheet displaying PDFs, Sections with individual YouTube links, and Case laws with videos
// class ActDetailBottomSheet extends StatelessWidget {
//   final LegalActDetail act;
//   const ActDetailBottomSheet({super.key, required this.act});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(
//         maxHeight: MediaQuery.of(context).size.height * 0.85,
//       ),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       padding: const EdgeInsets.all(20.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Center(
//               child: Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               act.actName,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF0F4C81),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Download Official Act PDF',
//               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF0F4C81),
//                     ),
//                     icon: const Icon(
//                       Icons.picture_as_pdf,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                     label: const Text(
//                       'English PDF',
//                       style: TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                     onPressed: () {},
//                     // launchExternalUrl(context, act.englishPdfUrl),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1B4332),
//                     ),
//                     icon: const Icon(
//                       Icons.picture_as_pdf,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                     label: const Text(
//                       'हिंदी पीडीएफ (Hindi)',
//                       style: TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                     onPressed: () {},
//                     // launchExternalUrl(context, act.hindiPdfUrl),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Key Sections & Video Explanations',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF0F4C81),
//               ),
//             ),
//             const SizedBox(height: 6),
//             ...act.sections.map(
//               (sec) => Card(
//                 elevation: 1,
//                 margin: const EdgeInsets.only(bottom: 8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ListTile(
//                   title: Text(
//                     sec.sectionTitle,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     sec.explanation,
//                     style: const TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(
//                       Icons.play_circle_fill,
//                       color: Color(0xFFCC0000),
//                       size: 30,
//                     ),
//                     tooltip: 'Watch Section Video',
//                     onPressed: () {},
//                     // launchExternalUrl(context, sec.youtubeVideoUrl),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Landmark Cases & Video Explanations',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF0F4C81),
//               ),
//             ),
//             const SizedBox(height: 6),
//             ...act.landmarkCases.map(
//               (c) => Card(
//                 elevation: 1,
//                 margin: const EdgeInsets.only(bottom: 8),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ListTile(
//                   title: Text(
//                     c.caseName,
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                   subtitle: Text(
//                     c.summary,
//                     style: const TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(
//                       Icons.play_circle_fill,
//                       color: Color(0xFFCC0000),
//                       size: 30,
//                     ),
//                     tooltip: 'Watch Case Video',
//                     onPressed: () {},
//                     // launchExternalUrl(context, c.youtubeVideoUrl),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               height: 44,
//               child: OutlinedButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text(
//                   'Close',
//                   style: TextStyle(
//                     color: Color(0xFF0F4C81),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // -------------------------------------------------------------------------
// // ADMIN PORTAL SCREEN: Map YouTube Explainer URLs to Specific Sections & Cases
// // -------------------------------------------------------------------------
// class AdminVideoUploadScreen extends StatefulWidget {
//   const AdminVideoUploadScreen({super.key});

//   @override
//   State<AdminVideoUploadScreen> createState() => _AdminVideoUploadScreenState();
// }

// class _AdminVideoUploadScreenState extends State<AdminVideoUploadScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _actController = TextEditingController();
//   final TextEditingController _sectionController = TextEditingController();
//   final TextEditingController _youtubeUrlController = TextEditingController();

//   String? _selectedTargetType = 'Section';

//   void _saveVideoMapping() {
//     if (_formKey.currentState!.validate()) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Success!'),
//           content: Text(
//             'YouTube video linked successfully for $_selectedTargetType: ${_sectionController.text} under ${_actController.text}.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 _actController.clear();
//                 _sectionController.clear();
//                 _youtubeUrlController.clear();
//                 setState(() {
//                   _selectedTargetType = 'Section';
//                 });
//               },
//               child: const Text(
//                 'OK',
//                 style: TextStyle(color: Color(0xFF0F4C81)),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0F4C81),
//         title: const Text(
//           'Admin Portal: Link YouTube Videos',
//           style: TextStyle(color: Colors.white, fontSize: 16),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Upload / Map Section Explainer Video',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF0F4C81),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               const Text(
//                 'Enter the target Act and Section/Case details along with your YouTube video link.',
//                 style: TextStyle(fontSize: 13, color: Colors.black54),
//               ),
//               const SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 initialValue: _selectedTargetType,
//                 decoration: const InputDecoration(
//                   labelText: 'Target Type',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Section', 'Landmark Case'].map((type) {
//                   return DropdownMenuItem(value: type, child: Text(type));
//                 }).toList(),
//                 onChanged: (val) {
//                   setState(() {
//                     _selectedTargetType = val;
//                   });
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _actController,
//                 decoration: const InputDecoration(
//                   labelText: 'Act Name (e.g. Bharatiya Nyaya Sanhita)',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (val) =>
//                     val == null || val.isEmpty ? 'Please enter Act name' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _sectionController,
//                 decoration: InputDecoration(
//                   labelText: _selectedTargetType == 'Section'
//                       ? 'Section Title (e.g. Section 103)'
//                       : 'Case Name (e.g. D.K. Basu v. State)',
//                   border: const OutlineInputBorder(),
//                 ),
//                 validator: (val) =>
//                     val == null || val.isEmpty ? 'Please enter title' : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _youtubeUrlController,
//                 decoration: const InputDecoration(
//                   labelText: 'YouTube Video URL',
//                   border: OutlineInputBorder(),
//                   hintText: 'https://www.youtube.com/watch?v=...',
//                 ),
//                 validator: (val) {
//                   if (val == null ||
//                       val.isEmpty ||
//                       !val.contains('youtube.com')) {
//                     return 'Please enter a valid YouTube link';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//               SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF0F4C81),
//                   ),
//                   onPressed: _saveVideoMapping,
//                   child: const Text(
//                     'Save & Publish Video Link',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';

class LegalSectionDetail {
  final String sectionTitle;
  final String explanation;
  final String youtubeVideoUrl;

  LegalSectionDetail({
    required this.sectionTitle,
    required this.explanation,
    required this.youtubeVideoUrl,
  });
}

class LandmarkCaseDetail {
  final String caseName;
  final String summary;
  final String youtubeVideoUrl;

  LandmarkCaseDetail({
    required this.caseName,
    required this.summary,
    required this.youtubeVideoUrl,
  });
}

class LegalActDetail {
  final String actName;
  final String jurisdiction; // 'Central' or 'State'
  final String englishPdfUrl;
  final String hindiPdfUrl;
  final List<LegalSectionDetail> sections;
  final List<LandmarkCaseDetail> landmarkCases;

  LegalActDetail({
    required this.actName,
    required this.jurisdiction,
    required this.englishPdfUrl,
    required this.hindiPdfUrl,
    required this.sections,
    required this.landmarkCases,
  });
}

class LegalTopic {
  final String titleEn;
  final String titleHi;
  final String description;
  final IconData icon;
  final String youtubeUrl;
  final List<LegalActDetail> acts;

  LegalTopic({
    required this.titleEn,
    required this.titleHi,
    required this.description,
    required this.icon,
    required this.youtubeUrl,
    required this.acts,
  });
}

class LegalAwarenessApp extends StatefulWidget {
  const LegalAwarenessApp({super.key});

  @override
  State<LegalAwarenessApp> createState() => _LegalAwarenessAppState();
}

class _LegalAwarenessAppState extends State<LegalAwarenessApp> {
  bool _isHindi = false;
  String _searchQuery = '';
  String _selectedJurisdictionFilter = 'All'; // 'All', 'Central', 'State'

  List<LegalTopic> getTopics() {
    return [
      LegalTopic(
        titleEn: 'Everyday Citizen Rights',
        titleHi: 'दैनिक नागरिक अधिकार',
        description:
            'Know your rights during police checks, traffic fines, FIR filing, and cybercrime reporting.',
        icon: Icons.gavel,
        youtubeUrl: 'https://www.youtube.com/@YourChannelName',
        acts: [
          LegalActDetail(
            actName: 'Bharatiya Nyaya Sanhita (BNS)',
            jurisdiction: 'Central',
            englishPdfUrl:
                'https://www.mha.gov.in/sites/default/files/250882_english_01042024.pdf',
            hindiPdfUrl:
                'https://www.mha.gov.in/sites/default/files/250882_hindi_ubah_01042024.pdf',
            sections: [
              LegalSectionDetail(
                sectionTitle: 'Section 35: General Exceptions',
                explanation:
                    'Acts done in good faith or under mistake of fact.',
                youtubeVideoUrl:
                    'https://www.youtube.com/watch?v=ExampleSection35',
              ),
              LegalSectionDetail(
                sectionTitle: 'Section 103: Punishment for Murder',
                explanation:
                    'Death sentence or imprisonment for life with fine.',
                youtubeVideoUrl:
                    'https://www.youtube.com/watch?v=ExampleSection103',
              ),
            ],
            landmarkCases: [
              LandmarkCaseDetail(
                caseName: 'D.K. Basu v. State of West Bengal',
                summary:
                    'Set mandatory guidelines for police during arrests and detentions.',
                youtubeVideoUrl:
                    'https://www.youtube.com/watch?v=ExampleDKBasuCase',
              ),
            ],
          ),
          LegalActDetail(
            actName: 'State Police Act (Sample)',
            jurisdiction: 'State',
            englishPdfUrl: 'https://example.com/state_police_act.pdf',
            hindiPdfUrl: 'https://example.com/state_police_act_hi.pdf',
            sections: [
              LegalSectionDetail(
                sectionTitle: 'Section 12: Duties of Police Officers',
                explanation: 'State specific police operational guidelines.',
                youtubeVideoUrl:
                    'https://www.youtube.com/watch?v=StatePoliceSec',
              ),
            ],
            landmarkCases: [],
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final topics = getTopics();

    return Scaffold(
      backgroundColor: Color(0xFF002E29),
      drawer: AppDrawer(isHindi: _isHindi),
      appBar: AppBarScreen(
        titleEn: "Know Your Laws",
        titleHi: "कानून जानें",
        isHindi: _isHindi,
        onLanguageChanged: (value) {
          setState(() {
            _isHindi = value;
          });
        },
      ),
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF0F4C81),
      //   automaticallyImplyLeading:
      //       false, // Back button/default leading icon hatane ke liye
      //   title: const Text(
      //     'Know Your Laws / कानून जानें',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.admin_panel_settings, color: Colors.white),
      //       tooltip: 'Admin Portal',
      //       onPressed: () => Navigator.pushNamed(context, '/admin-upload'),
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter and Search Row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Acts or Sections...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF0F4C81),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD0E1F9)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFD0E1F9)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFD0E1F9)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedJurisdictionFilter,
                        isExpanded: true,
                        items: ['All', 'Central', 'State']
                            .map(
                              (val) => DropdownMenuItem(
                                value: val,
                                child: Text(
                                  val,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedJurisdictionFilter = val!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  final topic = topics[index];

                  final filteredActs = topic.acts.where((act) {
                    final matchesJurisdiction =
                        _selectedJurisdictionFilter == 'All' ||
                        act.jurisdiction.toLowerCase() ==
                            _selectedJurisdictionFilter.toLowerCase();

                    final matchesSearch =
                        act.actName.toLowerCase().contains(_searchQuery) ||
                        act.sections.any(
                          (sec) =>
                              sec.sectionTitle.toLowerCase().contains(
                                _searchQuery,
                              ) ||
                              sec.explanation.toLowerCase().contains(
                                _searchQuery,
                              ),
                        );

                    return matchesJurisdiction && matchesSearch;
                  }).toList();

                  if (filteredActs.isEmpty && _searchQuery.isNotEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Card(
                    color: Colors.white, // Card background white
                    surfaceTintColor: Colors.white,
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      color: Colors.white, // Inner background white
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFFE0ECF8),
                                child: Icon(
                                  topic.icon,
                                  color: const Color(0xFF0F4C81),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      topic.titleEn,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      topic.titleHi,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          Text(
                            topic.description,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text(
                            'Applicable Acts (Tap for Section-by-Section Explanations):',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F4C81),
                            ),
                          ),
                          const SizedBox(height: 6),

                          ...filteredActs.map(
                            (act) => Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                        ActDetailBottomSheet(act: act),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .white, // Act item background white
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFFD0E1F9),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                act.actName,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF0F4C81),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color:
                                                    act.jurisdiction ==
                                                        'Central'
                                                    ? const Color(0xFF0F4C81)
                                                    : const Color(0xFF1B4332),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                act.jurisdiction,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                        color: Color(0xFF0F4C81),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom Sheet displaying PDFs, Sections with individual YouTube links, and Case laws with videos
class ActDetailBottomSheet extends StatefulWidget {
  final LegalActDetail act;
  const ActDetailBottomSheet({super.key, required this.act});

  @override
  State<ActDetailBottomSheet> createState() => _ActDetailBottomSheetState();
}

class _ActDetailBottomSheetState extends State<ActDetailBottomSheet> {
  String _sectionSearchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredSections = widget.act.sections
        .where(
          (sec) =>
              sec.sectionTitle.toLowerCase().contains(_sectionSearchQuery) ||
              sec.explanation.toLowerCase().contains(_sectionSearchQuery),
        )
        .toList();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.act.actName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F4C81),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: widget.act.jurisdiction == 'Central'
                        ? const Color(0xFF0F4C81)
                        : const Color(0xFF1B4332),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    widget.act.jurisdiction,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Download Official Act PDF',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F4C81),
                    ),
                    icon: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      'English PDF',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B4332),
                    ),
                    icon: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      'हिंदी पीडीएफ (Hindi)',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Section Filter Search Bar Inside Bottom Sheet
            TextField(
              onChanged: (val) {
                setState(() {
                  _sectionSearchQuery = val.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Filter sections (e.g. Section 103)...',
                prefixIcon: const Icon(
                  Icons.filter_list,
                  color: Color(0xFF0F4C81),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16,
                ),
                filled: true,
                fillColor: const Color(0xFFF0F4F8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFD0E1F9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFD0E1F9)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Key Sections & Video Explanations',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F4C81),
              ),
            ),
            const SizedBox(height: 6),
            ...filteredSections.map(
              (sec) => Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    sec.sectionTitle,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    sec.explanation,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.play_circle_fill,
                      color: Color(0xFFCC0000),
                      size: 30,
                    ),
                    tooltip: 'Watch Section Video',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Landmark Cases & Video Explanations',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F4C81),
              ),
            ),
            const SizedBox(height: 6),
            ...widget.act.landmarkCases.map(
              (c) => Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    c.caseName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  subtitle: Text(
                    c.summary,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.play_circle_fill,
                      color: Color(0xFFCC0000),
                      size: 30,
                    ),
                    tooltip: 'Watch Case Video',
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Color(0xFF0F4C81),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------------------------------------------------------
// ADMIN PORTAL SCREEN: Map YouTube Explainer URLs to Specific Sections & Cases
// -------------------------------------------------------------------------
class AdminVideoUploadScreen extends StatefulWidget {
  const AdminVideoUploadScreen({super.key});

  @override
  State<AdminVideoUploadScreen> createState() => _AdminVideoUploadScreenState();
}

class _AdminVideoUploadScreenState extends State<AdminVideoUploadScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _actController = TextEditingController();
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _youtubeUrlController = TextEditingController();

  String? _selectedTargetType = 'Section';
  String _selectedJurisdiction =
      'Central'; // State or Central selection for admin

  void _saveVideoMapping() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success!'),
          content: Text(
            'YouTube video linked successfully for $_selectedTargetType: ${_sectionController.text} under [$_selectedJurisdiction] ${_actController.text}.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _actController.clear();
                _sectionController.clear();
                _youtubeUrlController.clear();
                setState(() {
                  _selectedTargetType = 'Section';
                  _selectedJurisdiction = 'Central';
                });
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF0F4C81)),
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F4C81),
        title: const Text(
          'Admin Portal: Link YouTube Videos',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload / Map Section Explainer Video',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F4C81),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Enter the target Act, Jurisdiction (Central/State) and Section/Case details along with your YouTube video link.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedJurisdiction,
                decoration: const InputDecoration(
                  labelText: 'Jurisdiction (Central or State)',
                  border: OutlineInputBorder(),
                ),
                items: ['Central', 'State'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedJurisdiction = val!;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedTargetType,
                decoration: const InputDecoration(
                  labelText: 'Target Type',
                  border: OutlineInputBorder(),
                ),
                items: ['Section', 'Landmark Case'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedTargetType = val;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _actController,
                decoration: const InputDecoration(
                  labelText: 'Act Name (e.g. Bharatiya Nyaya Sanhita)',
                  border: OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Please enter Act name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sectionController,
                decoration: InputDecoration(
                  labelText: _selectedTargetType == 'Section'
                      ? 'Section Title (e.g. Section 103)'
                      : 'Case Name (e.g. D.K. Basu v. State)',
                  border: const OutlineInputBorder(),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Please enter title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _youtubeUrlController,
                decoration: const InputDecoration(
                  labelText: 'YouTube Video URL',
                  border: OutlineInputBorder(),
                  hintText: 'https://www.youtube.com/watch?v=...',
                ),
                validator: (val) {
                  if (val == null ||
                      val.isEmpty ||
                      !val.contains('youtube.com')) {
                    return 'Please enter a valid YouTube link';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F4C81),
                  ),
                  onPressed: _saveVideoMapping,
                  child: const Text(
                    'Save & Publish Video Link',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
