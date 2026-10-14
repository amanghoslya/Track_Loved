import 'package:flutter/material.dart';
import 'package:track_loved/CustomScreen/CustomScreen.dart';

class ExploreBusinessScreen extends StatefulWidget {
  const ExploreBusinessScreen({super.key});

  @override
  State<ExploreBusinessScreen> createState() => _ExploreBusinessScreenState();
}

class _ExploreBusinessScreenState extends State<ExploreBusinessScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _isHindi = false;

  final List<Map<String, dynamic>> _opportunities = [
    {
      'company': 'SwiftLogistics Express',
      'type': 'Start Courier Business / Franchise',
      'title': 'Looking for City Distributors for Fast Courier Service',
      'location': 'Faridabad / Delhi NCR',
      'pincode': '121001',
      'investment': '₹2 Lakhs - ₹5 Lakhs',
      'area': '150 - 300 Sq. Ft.',
      'returns': '20-25% ROI or Payback within 6 Months',
      'description':
          'Full technology platform, sorting software, uniform kits, and initial branding support provided. Great scope for local last-mile delivery growth.',
      'contactPerson': 'Rajesh Verma (Director)',
      'phone': '+91 98765 43210',
      'email': 'partners@swiftlogistics.com',
    },
    {
      'company': 'Apex Organic Retail Chain',
      'type': 'Retail Franchise Store',
      'title': 'Super Stockist & Retail Partner for Organic Grocery Products',
      'location': 'Gurugram / Haryana',
      'pincode': '122001',
      'investment': '₹5 Lakhs - ₹10 Lakhs',
      'area': '400 - 600 Sq. Ft.',
      'returns': '25-30% Margin with Guaranteed Buyback Support',
      'description':
          'Exclusive regional stockist rights for high-margin healthy snack lines and organic staple goods. Complete store setup and marketing material included.',
      'contactPerson': 'Sunil Malhotra',
      'phone': '+91 91234 56789',
      'email': 'expansion@apexorganic.in',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(isHindi: _isHindi),
      backgroundColor: const Color(0xFF002E29),
      key: _scaffoldKey,
      appBar: AppBarScreen(
        titleEn: 'Explore Business Opportunities',
        titleHi: 'व्यापार के अवसर खोजें',
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
      //     _isHindi ? 'व्यापार के अवसर खोजें' : 'Explore Business Opportunities',
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
            constraints: const BoxConstraints(maxWidth: 700),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by city, pincode, or business type...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF0B4F4A),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFDCDFE4)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFDCDFE4)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Active Expansion Listings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Post Opportunity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: _opportunities.length,
                    itemBuilder: (context, index) {
                      final item = _opportunities[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF0B4F4A,
                                      ).withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      item['type'],
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    item['location'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['company'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _infoBadge(
                                    Icons.account_balance_wallet,
                                    'Investment',
                                    item['investment'],
                                  ),
                                  const SizedBox(width: 8),
                                  _infoBadge(
                                    Icons.aspect_ratio,
                                    'Area',
                                    item['area'],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _infoBadge(
                                    Icons.trending_up,
                                    'Returns',
                                    item['returns'],
                                  ),
                                  const SizedBox(width: 8),
                                  _infoBadge(
                                    Icons.pin_drop,
                                    'Pincode',
                                    item['pincode'],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item['description'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0B4F4A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    _showContactDialog(context, item);
                                  },
                                  icon: const Icon(
                                    Icons.phone,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Contact Business Partner',
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

  Widget _infoBadge(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          item['company'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get in touch with the representative for this expansion opportunity:',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            Text(
              'Contact Person: ${item['contactPerson']}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              'Phone / WhatsApp: ${item['phone']}',
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              'Email: ${item['email']}',
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
