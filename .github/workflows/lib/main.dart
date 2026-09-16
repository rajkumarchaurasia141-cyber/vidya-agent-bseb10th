import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const VidyaAgentApp());
}

class VidyaAgentApp extends StatelessWidget {
  const VidyaAgentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vidya Agent: Bihar Board 10th',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const MainDashboardScreen(),
    );
  }
}

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const NotesSection(),
    const NcertSolutionsSection(),
    const PyqSection(),
    const TestSeriesSection(),
    const VidyaAiAgentSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.school, color: Colors.amber),
            SizedBox(width: 8),
            Text(
              'Vidya Agent: BSEB 10th',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        elevation: 2,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'नोट्स'),
          NavigationDestination(icon: Icon(Icons.assignment), label: 'NCERT हल'),
          NavigationDestination(icon: Icon(Icons.history_edu), label: 'PYQ (10 Yr)'),
          NavigationDestination(icon: Icon(Icons.quiz), label: 'टेस्ट'),
          NavigationDestination(icon: Icon(Icons.smart_toy), label: 'AI एजेंट'),
        ],
      ),
    );
  }
}

// ---------------- 1. स्मार्ट नोट्स सेक्शन ----------------
class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  final List<Map<String, String>> notes = const [
    {
      'title': 'अध्याय 1: वास्तविक संख्याएँ',
      'subject': 'गणित (Maths)',
      'content': '• यूक्लिड विभाजन प्रमेयिका: a = bq + r, जहाँ 0 ≤ r < b\n• अंकगणित की आधारभूत प्रमेय: प्रत्येक भाज्य संख्या को अभाज्य संख्याओं के गुणनफल के रूप में व्यक्त किया जा सकता है।\n• HCF(a, b) × LCM(a, b) = a × b\n• परिमेय और अपरिमेय संख्याओं की पहचान (जैसे √2, √3, √5 अपरिमेय संख्याएँ हैं)।'
    },
    {
      'title': 'अध्याय 8: त्रिकोणमिति का परिचय',
      'subject': 'गणित (Maths)',
      'content': '• sin θ = लम्ब / कर्ण\n• cos θ = आधार / कर्ण\n• tan θ = लम्ब / आधार\n• सर्वसमिकाएँ:\n  1. sin²θ + cos²θ = 1\n  2. 1 + tan²θ = sec²θ\n  3. 1 + cot²θ = cosec²θ'
    },
    {
      'title': 'अध्याय 1: रासायनिक अभिक्रियाएँ एवं समीकरण',
      'subject': 'विज्ञान (Science)',
      'content': '• संयोजन अभिक्रिया: जब दो या दो से अधिक पदार्थ मिलकर एकल उत्पाद बनाते हैं।\n• वियोजन अभिक्रिया: एकल अभिकर्मक टूटकर छोटे-छोटे उत्पाद बनाता है।\n• विस्थापन एवं द्विविस्थापन अभिक्रियाएँ।\n• उपचयन (ऑक्सीजन की वृद्धि) एवं अपचयन (ऑक्सीजन का ह्रास)।'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final item = notes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Icon(Icons.book, color: Colors.white, size: 20),
            ),
            title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['subject']!, style: const TextStyle(color: Colors.deepPurpleAccent)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText(
                  item['content']!,
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------- 2. NCERT संपूर्ण हल सेक्शन ----------------
class NcertSolutionsSection extends StatelessWidget {
  const NcertSolutionsSection({super.key});

  final List<Map<String, String>> solutions = const [
    {
      'ex': 'प्रश्नावली 1.1 - प्रश्न 1',
      'q': 'यूक्लिड विभाजन एल्गोरिथ्म से 135 और 225 का HCF ज्ञात कीजिए।',
      'sol': 'चरण 1: 225 > 135\n225 = 135 × 1 + 90 (शेषफल 90 ≠ 0)\n\nचरण 2: 135 और 90 के लिए:\n135 = 90 × 1 + 45 (शेषफल 45 ≠ 0)\n\nचरण 3: 90 और 45 के लिए:\n90 = 45 × 2 + 0 (शेषफल = 0)\n\nअतः, अंतिम भाजक 45 है।\nउत्तर: HCF(135, 225) = 45'
    },
    {
      'ex': 'प्रश्नावली 1.3 - प्रश्न 1',
      'q': 'सिद्ध कीजिए कि √5 एक अपरिमेय संख्या है।',
      'sol': 'माना √5 एक परिमेय संख्या है।\n√5 = a/b (जहाँ a और b सह-अभाज्य पूर्णांक हैं, b ≠ 0)\n\nदोनों पक्षों का वर्ग करने पर:\n5 = a² / b²  => a² = 5b²\nअतः a², 5 से विभाज्य है, इसलिए a भी 5 से विभाज्य होगा।\nमान लेते हैं a = 5c\n(5c)² = 5b² => 25c² = 5b² => b² = 5c²\nअतः b भी 5 से विभाज्य होगा।\n\nपरन्तु यह हमारी इस मान्यता का विरोध करता है कि a और b सह-अभाज्य हैं।\nअतः √5 एक अपरिमेय संख्या है।'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: solutions.length,
      itemBuilder: (context, index) {
        final item = solutions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(50),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(item['ex']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                ),
                const SizedBox(height: 8),
                Text('प्रश्न: ${item['q']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Divider(height: 24),
                const Text('समाधान (हल):', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                const SizedBox(height: 6),
                SelectableText(
                  item['sol']!,
                  style: const TextStyle(fontSize: 15, height: 1.4),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------- 3. पिछले 10 वर्ष PYQ सेक्शन ----------------
class PyqSection extends StatelessWidget {
  const PyqSection({super.key});

  final List<Map<String, String>> pyqList = const [
    {
      'year': 'BSEB 2024 (वार्षिक)',
      'subject': 'गणित (Maths)',
      'q': 'द्विघात समीकरण 2x² - 4x + 3 = 0 का विविक्तकर (Discriminant) क्या होगा?',
      'ans': 'उत्तर: D = b² - 4ac = (-4)² - 4(2)(3) = 16 - 24 = -8 (वास्तविक मूल नहीं हैं)'
    },
    {
      'year': 'BSEB 2023 (वार्षिक)',
      'subject': 'विज्ञान (Science)',
      'q': 'अवतल दर्पण के मुख्य फोकस की परिभाषा लिखिए।',
      'ans': 'उत्तर: मुख्य अक्ष के समांतर आने वाली प्रकाश की किरणें अवतल दर्पण से परावर्तन के पश्चात मुख्य अक्ष के जिस बिन्दु पर मिलती हैं, उसे अवतल दर्पण का मुख्य फोकस कहते हैं।'
    },
    {
      'year': 'BSEB 2022 (वार्षिक)',
      'subject': 'गणित (Maths)',
      'q': 'बिन्दुओं (2, 3) और (4, 1) के बीच की दूरी ज्ञात कीजिए।',
      'ans': 'उत्तर: d = √[(4-2)² + (1-3)²] = √[2² + (-2)²] = √[4 + 4] = √8 = 2√2 मात्रक'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: pyqList.length,
      itemBuilder: (context, index) {
        final item = pyqList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['year']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                    Text(item['subject']!, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(item['q']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(item['ans']!, style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ---------------- 4. ऑनलाइन टेस्ट सीरीज़ सेक्शन ----------------
class TestSeriesSection extends StatefulWidget {
  const TestSeriesSection({super.key});

  @override
  State<TestSeriesSection> createState() => _TestSeriesSectionState();
}

class _TestSeriesSectionState extends State<TestSeriesSection> {
  final List<Map<String, dynamic>> questions = [
    {
      'q': 'π (पाई) एक संख्या है:',
      'options': ['परिमेय', 'अपरिमेय', 'पूर्णांक', 'इनमें से कोई नहीं'],
      'correct': 1
    },
    {
      'q': 'द्विघात बहुपद के शून्यकों की अधिकतम संख्या कितनी होती है?',
      'options': ['1', '2', '3', 'अनंत'],
      'correct': 1
    },
    {
      'q': 'sin² 45° + cos² 45° का मान क्या होगा?',
      'options': ['0', '1', '2', '1/2'],
      'correct': 1
    },
  ];

  final Map<int, int> selectedAnswers = {};
  int? score;

  void _calculateScore() {
    int total = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]['correct']) {
        total++;
      }
    }
    setState(() {
      score = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withAlpha(30),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.timer, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text('बिहार बोर्ड 10th मॉडल टेस्ट - 01', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(questions.length, (qIndex) {
            final q = questions[qIndex];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('प्र. ${qIndex + 1}: ${q['q']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 8),
                    ...List.generate(q['options'].length, (optIndex) {
                      return RadioListTile<int>(
                        value: optIndex,
                        groupValue: selectedAnswers[qIndex],
                        title: Text(q['options'][optIndex]),
                        onChanged: (val) {
                          setState(() {
                            selectedAnswers[qIndex] = val!;
                          });
                        },
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _calculateScore,
            icon: const Icon(Icons.check_circle),
            label: const Text('टेस्ट सबमिट करें और रिजल्ट देखें'),
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
          ),
          if (score != null) ...[
            const SizedBox(height: 16),
            Card(
              color: Colors.green.withAlpha(40),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '🎉 आपका स्कोर: $score / ${questions.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ---------------- 5. विद्या AI एजेंट (डाउट सॉल्वर + कैमरा विज़न) ----------------
class VidyaAiAgentSection extends StatefulWidget {
  const VidyaAiAgentSection({super.key});

  @override
  State<VidyaAiAgentSection> createState() => _VidyaAiAgentSectionState();
}

class _VidyaAiAgentSectionState extends State<VidyaAiAgentSection> {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  // Active Gemini API Key
  final String _apiKey = 'AQ.Ab8RN6IA1m4s9fIKAcMVV0t3GQ6Q' + 'VtARTT-cmmZ9ti1jurd4dw';

  String _result = '';
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source, imageQuality: 85);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('फ़ोटो चुनने में त्रुटि: $e')),
      );
    }
  }

  Future<void> _askVidyaAgent() async {
    final text = _controller.text.trim();
    if (text.isEmpty && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('कृपया अपना सवाल लिखें या किताब की फ़ोटो खींचें!')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final model = GenerativeModel(
        model: 'gemini-3.6-flash',
        apiKey: _apiKey,
      );

      final List<Part> parts = [];

      if (_selectedImage != null) {
        final bytes = await _selectedImage!.readAsBytes();
        parts.add(DataPart('image/jpeg', bytes));
      }

      String prompt = 'आप "विद्या एजेंट" हैं - बिहार बोर्ड कक्षा 10वीं के हिंदी माध्यम छात्रों के सर्वोत्तम शिक्षक और सहायक। '
          'छात्र के सवाल का उत्तर आसान, स्पष्ट और चरण-दर-चरण (Step-by-Step) हिंदी में समझाइए:\n\n$text';

      parts.add(TextPart(prompt));

      final response = await model.generateContent([Content.multi(parts)]);

      setState(() {
        _result = response.text ?? 'उत्तर प्राप्त नहीं हुआ। कृपया पुनः प्रयास करें।';
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'गणित या विज्ञान का कोई भी सवाल यहाँ लिखें...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isLoading ? null : () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('फ़ोटो खींचें'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _isLoading ? null : () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo),
                  label: const Text('गैलरी से लें'),
                ),
              ),
            ],
          ),
          if (_selectedImage != null) ...[
            const SizedBox(height: 12),
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_selectedImage!, height: 160, width: double.infinity, fit: BoxFit.cover),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red, size: 26),
                  onPressed: () {
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          ElevatedButton.icon(
            onPressed: _isLoading ? null : _askVidyaAgent,
            icon: const Icon(Icons.auto_awesome),
            label: const Text('विद्या एजेंट से पूछें (हल पाएं)'),
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
          ),
          const SizedBox(height: 20),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_result.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SelectableText(
                _result,
                style: const TextStyle(fontSize: 15, height: 1.5),
              ),
            ),
        ],
      ),
    );
  }
}
