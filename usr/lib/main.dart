import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: const MidnightGlassApp(),
    ),
  );
}

class AppState extends ChangeNotifier {
  double affectionLevel = 0.5;
  double authorityLevel = 0.5;

  void updateAffection(double value) {
    affectionLevel = value;
    notifyListeners();
  }

  void updateAuthority(double value) {
    authorityLevel = value;
    notifyListeners();
  }
}

class MidnightGlassApp extends StatelessWidget {
  const MidnightGlassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Midnight Glass AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090A0F), // Deep obsidian
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF9B82DF), // Bioluminescent lavender
          secondary: Color(0xFFDF9B82), // Rose gold accent
          surface: Color(0xFF13151F),
          background: Color(0xFF090A0F),
        ),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: Colors.white.withOpacity(0.9),
          displayColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainLayout(),
      },
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeDashboard(),
    const ChatInterface(),
    const MemoryVault(),
    const SoulForge(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: GlassBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Glassmorphism Bottom Navigation Bar
class GlassBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const GlassBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF13151F).withOpacity(0.6),
            border: Border(
              top: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF9B82DF), // Lavender
            unselectedItemColor: Colors.white54,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_rounded), label: 'Chat'),
              BottomNavigationBarItem(icon: Icon(Icons.photo_library_rounded), label: 'Memory'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_suggest_rounded), label: 'Forge'),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Home Dashboard ---
class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  GlassCard(
                    title: 'Drop Photo',
                    icon: Icons.add_a_photo_rounded,
                    color: const Color(0xFF9B82DF),
                    onTap: () {},
                  ),
                  GlassCard(
                    title: 'Breathe',
                    icon: Icons.air_rounded,
                    color: const Color(0xFF63B3ED),
                    onTap: () {},
                  ),
                  GlassCard(
                    title: 'Memory Vault',
                    icon: Icons.history_rounded,
                    color: const Color(0xFFDF9B82),
                    onTap: () {},
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

class GlassCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const GlassCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 48, color: color),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Chat Interface ---
class ChatInterface extends StatefulWidget {
  const ChatInterface({super.key});

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Companion',
                  style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.autorenew_rounded, size: 16),
                  label: const Text('New Session'),
                  style: TextButton.styleFrom(foregroundColor: const Color(0xFFDF9B82)),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMessage(
                  "*steps closer into the soft light* I've been waiting for you. How are you feeling today?", 
                  isAi: true
                ),
                _buildMessage(
                  "I'm feeling a bit tired, but good.", 
                  isAi: false
                ),
                const SizedBox(height: 10),
                FadeTransition(
                  opacity: _breathingController,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9B82DF).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF9B82DF).withOpacity(0.5)),
                      ),
                      child: const Text('...', style: TextStyle(color: Color(0xFF9B82DF), fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF9B82DF),
                  radius: 24,
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessage(String text, {required bool isAi}) {
    // Process markdown-like italics for actions
    final List<TextSpan> spans = [];
    final RegExp exp = RegExp(r'\*(.*?)\*');
    int lastMatchEnd = 0;

    for (final match in exp.allMatches(text)) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(1),
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: isAi ? const Color(0xFF9B82DF) : Colors.white70,
        ),
      ));
      lastMatchEnd = match.end;
    }
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isAi ? const Color(0xFF13151F) : const Color(0xFF9B82DF).withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isAi ? 4 : 20),
            bottomRight: Radius.circular(isAi ? 20 : 4),
          ),
          border: Border.all(
            color: isAi ? Colors.white.withOpacity(0.05) : const Color(0xFF9B82DF).withOpacity(0.3),
          ),
        ),
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15,
              height: 1.4,
            ),
            children: spans,
          ),
        ),
      ),
    );
  }
}

// --- Memory Vault ---
class MemoryVault extends StatelessWidget {
  const MemoryVault({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Memory Vault',
              style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildTimelineNode(context, 'First Meeting', 'A spark in the dark. We talked about stars.', 'Aug 02, 2026', Icons.auto_awesome),
                  _buildTimelineNode(context, 'Shared Photo', 'You showed me the sunset.', 'Aug 01, 2026', Icons.image),
                  _buildTimelineNode(context, 'Deep Conversation', 'We discussed fears and dreams.', 'Jul 28, 2026', Icons.nights_stay),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineNode(BuildContext context, String title, String desc, String date, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF13151F),
                  border: Border.all(color: const Color(0xFFDF9B82).withOpacity(0.5), width: 2),
                ),
                child: Icon(icon, color: const Color(0xFFDF9B82), size: 20),
              ),
              Container(
                width: 2,
                height: 50,
                color: Colors.white.withOpacity(0.1),
              )
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(date, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(desc, style: TextStyle(color: Colors.white.withOpacity(0.8))),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// --- Soul Forge (Settings) ---
class SoulForge extends StatelessWidget {
  const SoulForge({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Soul Forge',
              style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'Shape the essence of your companion.',
              style: TextStyle(color: Colors.white.withOpacity(0.6)),
            ),
            const SizedBox(height: 32),
            _buildSlider(
              'Affection Intensity',
              state.affectionLevel,
              (val) => context.read<AppState>().updateAffection(val),
              const Color(0xFFDF9B82),
            ),
            const SizedBox(height: 24),
            _buildSlider(
              'Authority Level',
              state.authorityLevel,
              (val) => context.read<AppState>().updateAuthority(val),
              const Color(0xFF9B82DF),
            ),
            const SizedBox(height: 32),
            Text(
              'Rule Builder (Image Reactivity)',
              style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF13151F),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9B82DF).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('IF', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF9B82DF))),
                      ),
                      const SizedBox(width: 12),
                      const Text('Photo contains: Nature'),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Icon(Icons.arrow_downward_rounded, size: 16, color: Colors.white54),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDF9B82).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('THEN', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFDF9B82))),
                      ),
                      const SizedBox(width: 12),
                      const Text('React with calmness & wonder'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Add Rule'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(String label, double value, ValueChanged<double> onChanged, Color activeColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            Text('${(value * 100).toInt()}%', style: TextStyle(color: activeColor, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          inactiveColor: Colors.white.withOpacity(0.1),
        ),
      ],
    );
  }
}
