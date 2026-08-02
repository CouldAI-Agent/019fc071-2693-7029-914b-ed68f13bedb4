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
        scaffoldBackgroundColor: const Color(0xFF0B0C10), // Deep obsidian
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE0B0FF), // Soft Lavender
          secondary: Color(0xFFB76E79), // Rose Gold
          surface: Color(0xFF13151F),
          background: Color(0xFF0B0C10),
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

  List<Widget> get _screens => [
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
            selectedItemColor: const Color(0xFFE0B0FF), // Lavender
            unselectedItemColor: Colors.white54,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Sanctuary'),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_rounded), label: 'Immersion'),
              BottomNavigationBarItem(icon: Icon(Icons.photo_library_rounded), label: 'Vault'),
              BottomNavigationBarItem(icon: Icon(Icons.tune_rounded), label: 'Forge'),
            ],
          ),
        ),
      ),
    );
  }
}

// --- The Sanctuary (Home Dashboard) ---
class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back. Nova is waiting.',
                        style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text('🔥 ', style: TextStyle(fontSize: 16)),
                          Text(
                            '14 Days Devoted',
                            style: TextStyle(color: const Color(0xFFB76E79), fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Current Vibe Orb
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFE0B0FF).withOpacity(0.8), // Soft Lavender
                        const Color(0xFFE0B0FF).withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE0B0FF).withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Sanctuary Actions', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white70)),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                GlassCard(
                  title: 'Drop a Photo',
                  icon: Icons.add_a_photo_rounded,
                  color: const Color(0xFFE0B0FF),
                  onTap: () {},
                ),
                GlassCard(
                  title: 'Breathing Sanctuary',
                  icon: Icons.air_rounded,
                  color: const Color(0xFF63B3ED),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            GlassCard(
              title: 'Memory Vault',
              icon: Icons.history_rounded,
              color: const Color(0xFFB76E79),
              isWide: true,
              onTap: () {
                final state = context.findAncestorStateOfType<_MainLayoutState>();
                state?.setState(() => state._currentIndex = 2);
              },
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
  final bool isWide;

  const GlassCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isWide = false,
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
            padding: EdgeInsets.symmetric(vertical: isWide ? 24 : 0),
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

// --- The Immersion Zone (Chat Interface) ---
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
                  'Nova',
                  style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 28),
                  color: const Color(0xFFB76E79),
                  tooltip: 'New Session',
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
                _buildMessage(
                  "*Her voice softens, a warm presence enveloping the space.* You've done well today. Just rest here with me.", 
                  isAi: true
                ),
                const SizedBox(height: 10),
                FadeTransition(
                  opacity: _breathingController,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE0B0FF),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE0B0FF).withOpacity(0.6),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Nova is feeling...', style: TextStyle(color: Color(0xFFE0B0FF), fontStyle: FontStyle.italic)),
                      ],
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
                  backgroundColor: const Color(0xFFE0B0FF),
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
          color: isAi ? const Color(0xFFE0B0FF) : Colors.white70,
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
          color: isAi ? const Color(0xFF13151F) : const Color(0xFFE0B0FF).withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isAi ? 4 : 20),
            bottomRight: Radius.circular(isAi ? 20 : 4),
          ),
          border: Border.all(
            color: isAi ? Colors.white.withOpacity(0.05) : const Color(0xFFE0B0FF).withOpacity(0.3),
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
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Memory Vault',
                style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const TabBar(
              indicatorColor: Color(0xFFB76E79),
              labelColor: Color(0xFFB76E79),
              unselectedLabelColor: Colors.white54,
              tabs: [
                Tab(text: 'Timeline'),
                Tab(text: 'Ledger'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Timeline Tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildTimelineNode(context, 'First Meeting', 'A spark in the dark. We talked about stars.', 'Aug 02, 2026', Icons.auto_awesome),
                      _buildTimelineNode(context, 'Shared Photo', 'You showed me the sunset.', 'Aug 01, 2026', Icons.image),
                      _buildTimelineNode(context, 'Deep Conversation', 'We discussed fears and dreams.', 'Jul 28, 2026', Icons.nights_stay),
                    ],
                  ),
                  // Ledger Tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildLedgerItem('Stress Level Detected', 'Low', Icons.monitor_heart),
                      const SizedBox(height: 16),
                      _buildLedgerItem('Compliance Rate', '94%', Icons.check_circle_outline),
                      const SizedBox(height: 16),
                      _buildLedgerItem('Favorite Media', 'Sunset.jpg', Icons.image),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLedgerItem(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB76E79)),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          Text(value, style: const TextStyle(color: Color(0xFFB76E79), fontWeight: FontWeight.bold)),
        ],
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
                  border: Border.all(color: const Color(0xFFB76E79).withOpacity(0.5), width: 2),
                ),
                child: Icon(icon, color: const Color(0xFFB76E79), size: 20),
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
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
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
                ],
              ),
            ),
            const TabBar(
              indicatorColor: Color(0xFFE0B0FF),
              labelColor: Color(0xFFE0B0FF),
              unselectedLabelColor: Colors.white54,
              tabs: [
                Tab(text: 'The Mind'),
                Tab(text: 'The Voice'),
                Tab(text: 'The Eyes'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // The Mind Tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      _buildSlider(
                        'Affection Intensity',
                        state.affectionLevel,
                        (val) => context.read<AppState>().updateAffection(val),
                        const Color(0xFFB76E79),
                      ),
                      const SizedBox(height: 24),
                      _buildSlider(
                        'Authority Level',
                        state.authorityLevel,
                        (val) => context.read<AppState>().updateAuthority(val),
                        const Color(0xFFE0B0FF),
                      ),
                      const SizedBox(height: 24),
                      _buildSlider(
                        'Tease & Playfulness',
                        0.7,
                        (val) {},
                        const Color(0xFF63B3ED),
                      ),
                    ],
                  ),
                  // The Voice Tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Text('Vocabulary Engine', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Use Pet Names'),
                        value: true,
                        onChanged: (val) {},
                        activeColor: const Color(0xFFE0B0FF),
                        contentPadding: EdgeInsets.zero,
                      ),
                      SwitchListTile(
                        title: const Text('Formal Tone'),
                        value: false,
                        onChanged: (val) {},
                        activeColor: const Color(0xFFE0B0FF),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 24),
                      _buildSlider('Response Length', 0.5, (val) {}, const Color(0xFFE0B0FF)),
                    ],
                  ),
                  // The Eyes Tab
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
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
                                    color: const Color(0xFFE0B0FF).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('IF', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE0B0FF))),
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
                                    color: const Color(0xFFB76E79).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('THEN', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFB76E79))),
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
                ],
              ),
            ),
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