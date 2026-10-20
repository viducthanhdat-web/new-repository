import 'package:flutter/material.dart';

void main() {
  runApp(const JetpackComposeTutorialApp());
}

class JetpackComposeTutorialApp extends StatelessWidget {
  const JetpackComposeTutorialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jetpack Compose Tutorial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/list': (context) => const ComponentListScreen(),
        '/text': (context) => const TextDetailScreen(),
        '/images': (context) => const ImagesScreen(),
        '/textfield': (context) => const TextFieldScreen(),
        '/column': (context) => const ColumnLayoutScreen(),
        '/row': (context) => const RowLayoutScreen(),
      },
    );
  }
}

// --- Welcome Screen ---
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Nguyễn Văn A', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('2342312323', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.greenAccent, Colors.blue, Colors.indigo],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white.withOpacity(0.8), width: 4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Jetpack Compose',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Jetpack Compose is a modern UI toolkit for building native Android applications using a declarative programming approach.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 14, height: 1.5),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/list'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 5,
                    shadowColor: Colors.blue.withOpacity(0.5),
                  ),
                  child: const Text("I'm ready", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Component List Screen ---
class ComponentListScreen extends StatelessWidget {
  const ComponentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('UI Components List', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[200], height: 1.0),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCategory('Display', [
            _buildItem(context, 'Text', 'Displays text', '/text'),
            _buildItem(context, 'Image', 'Displays an image', '/images'),
          ]),
          const SizedBox(height: 24),
          _buildCategory('Input', [
            _buildItem(context, 'TextField', 'Input field for text', '/textfield'),
          ]),
          const SizedBox(height: 24),
          _buildCategory('Layout', [
            _buildItem(context, 'Column', 'Arranges elements vertically', '/column'),
            _buildItem(context, 'Row', 'Arranges elements horizontally', '/row'),
          ]),
        ],
      ),
    );
  }

  Widget _buildCategory(String name, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
          child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
        ...items,
      ],
    );
  }

  Widget _buildItem(BuildContext context, String title, String description, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(description, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Text Detail Screen ---
class TextDetailScreen extends StatelessWidget {
  const TextDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Text Detail', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(fontSize: 32, color: Colors.black, height: 1.4),
              children: [
                const TextSpan(text: 'The '),
                const TextSpan(text: 'quick ', style: TextStyle(fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)),
                const TextSpan(text: 'Brown\n', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                const TextSpan(text: 'fox '),
                const TextSpan(text: 'jumps ', style: TextStyle(fontFamily: 'monospace', fontSize: 28)),
                const TextSpan(text: 'over\n', style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, decoration: TextDecoration.underline)),
                WidgetSpan(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 2.0, color: Colors.black))),
                    child: const Text('the', style: TextStyle(fontSize: 32)),
                  ),
                ),
                const TextSpan(text: ' '),
                const TextSpan(text: 'lazy ', style: TextStyle(fontFamily: 'serif', fontStyle: FontStyle.italic, fontSize: 28)),
                const TextSpan(text: 'dog.', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Images Screen ---
class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Images', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 48, color: Colors.grey),
                          Text('Network Image Placeholder', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'https://example.com/logo.png',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo_library, size: 48, color: Colors.grey),
                          Text('Asset Image Placeholder', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text('In app', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- TextField Screen ---
class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  String _value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('TextField', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text('Normal Text Field', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
              ),
            ),
            TextField(
              onChanged: (val) => setState(() => _value = val),
              decoration: InputDecoration(
                hintText: 'Thông tin nhập',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Tự động cập nhật dữ liệu theo textfield: ${_value.isEmpty ? '...' : _value}',
              style: const TextStyle(color: Colors.red, fontStyle: FontStyle.italic, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Column Layout Screen ---
class ColumnLayoutScreen extends StatelessWidget {
  const ColumnLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Column Layout', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Container(height: 120, width: double.infinity, decoration: BoxDecoration(color: Colors.green[200], borderRadius: BorderRadius.circular(16))),
            const SizedBox(height: 24),
            Container(height: 120, width: double.infinity, decoration: BoxDecoration(color: Colors.green[500], borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 5))])),
            const SizedBox(height: 24),
            Container(height: 120, width: double.infinity, decoration: BoxDecoration(color: Colors.green[300], borderRadius: BorderRadius.circular(16))),
          ],
        ),
      ),
    );
  }
}

// --- Row Layout Screen ---
class RowLayoutScreen extends StatelessWidget {
  const RowLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Row Layout', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(32.0),
        itemCount: 4,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) => Row(
          children: [
            Expanded(child: AspectRatio(aspectRatio: 1, child: Container(decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(8))))),
            const SizedBox(width: 16),
            Expanded(child: AspectRatio(aspectRatio: 1, child: Container(decoration: BoxDecoration(color: Colors.blue[500], borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: const Offset(0, 2))])))),
            const SizedBox(width: 16),
            Expanded(child: AspectRatio(aspectRatio: 1, child: Container(decoration: BoxDecoration(color: Colors.blue[200], borderRadius: BorderRadius.circular(8))))),
          ],
        ),
      ),
    );
  }
}
