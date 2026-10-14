import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackRatingScreen extends StatefulWidget {
  const FeedbackRatingScreen({super.key});

  @override
  State<FeedbackRatingScreen> createState() => _FeedbackRatingScreenState();
}

class _FeedbackRatingScreenState extends State<FeedbackRatingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _feedbackController = TextEditingController();

  int _rating = 0;
  String? _selectedIssue;
  bool _isHindi = false;

  final List<String> _issues = [
    'Location tracking delay (Lag)',
    'Inaccurate GPS coordinates',
    'High battery consumption',
    'App crashing or freezing',
    'Difficult to use / UI confusion',
    'Other issue',
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a star rating first!')),
      );
      return;
    }

    if (_rating < 5 &&
        _selectedIssue == null &&
        _feedbackController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select or specify what did not work for you.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_isHindi ? 'धन्यवाद!' : 'Thank You!'),
        content: Text(
          _rating == 5
              ? (_isHindi
                    ? 'Google Play पर रेट करने के लिए रीडायरेक्ट किया जा रहा है...'
                    : 'Redirecting to Google Play Store rating...')
              : (_isHindi
                    ? 'आपका फीडबैक दर्ज कर लिया गया है। हम इसे सुधारने पर काम कर रहे हैं।'
                    : 'Your feedback has been recorded. We appreciate your insights to improve the app.'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close Dialog
              Navigator.pop(context); // Return to Search Loved Ones Screen
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF0B4F4A))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF002E29),

      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B4F4A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Text(
          _isHindi ? 'फीडबैक और रेटिंग' : 'Feedback & Rating',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450),
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 64,
                    color: Color(0xFFFBC02D),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _isHindi
                        ? 'आप हमारे अनुभव को कैसे रेट करेंगे?'
                        : 'How was your location tracking experience?',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Help us serve you better with your honest feedback.',
                    style: TextStyle(fontSize: 13, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      int starValue = index + 1;
                      return IconButton(
                        iconSize: 40,
                        icon: Icon(
                          starValue <= _rating ? Icons.star : Icons.star_border,
                          color: const Color(0xFFFBC02D),
                        ),
                        onPressed: () {
                          setState(() {
                            _rating = starValue;
                            if (_rating == 5) _selectedIssue = null;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _rating == 0
                        ? 'Tap a star to rate'
                        : '$_rating out of 5 stars',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_rating > 0 && _rating < 5) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFDCDFE4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'What did not work well for you?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Please select the primary reason so we can fix it:',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ..._issues.map((issue) {
                            return RadioListTile<String>(
                              title: Text(
                                issue,
                                style: const TextStyle(fontSize: 13),
                              ),
                              value: issue,
                              groupValue: _selectedIssue,
                              activeColor: const Color(0xFF0B4F4A),
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              onChanged: (val) {
                                setState(() {
                                  _selectedIssue = val;
                                });
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  // TextField(
                  //   controller: _feedbackController,
                  //   obscureText: true,
                  //   style: const TextStyle(color: Colors.white),
                  //   decoration: InputDecoration(
                  //     labelText: 'Password',
                  //     labelStyle: const TextStyle(color: Colors.white60),
                  //     prefixIcon: const Icon(
                  //       Icons.lock_outline,
                  //       color: Colors.white60,
                  //     ),
                  //     filled: true,
                  //     fillColor: Colors.white.withValues(alpha: 0.05),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: const BorderSide(color: Colors.white24),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: const BorderSide(color: Colors.white24),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //       borderSide: const BorderSide(color: Color(0xFFC5A038)),
                  //     ),
                  //   ),
                  // ),
                  TextField(
                    controller: _feedbackController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: _rating < 5 && _rating > 0
                          ? 'Please provide any additional details...'
                          : 'Write your comments or suggestions here...',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Colors.black45,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      // border: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(12),
                      //   borderSide: const BorderSide(color: Color(0xFFDCDFE4)),
                      // ),
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
                        borderSide: const BorderSide(
                          color: Color(0xFFC5A038),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B4F4A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: _submitFeedback,
                      child: Text(
                        _rating == 5
                            ? 'Rate on Google Play Store'
                            : 'Submit Feedback',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
