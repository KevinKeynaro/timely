import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timely/pages/login_page.dart';

const Color _inactive = Color(0xFF9E9E9E);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<String> _titles = ['Home', 'Today', 'Inbox', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: (_selectedIndex == 0 || _selectedIndex == 3)
          ? null
          : AppBar(
              backgroundColor: const Color(0xFFFAF9F6),
              elevation: 0,
              centerTitle: true,
              title: Text(
                _titles[_selectedIndex],
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
      body: _selectedIndex == 0
          ? const _HomePage()
          : _selectedIndex == 2
          ? const _InboxPage()
          : _selectedIndex == 3
          ? const ProfilePage()
          : Center(
              child: Text(
                _titles[_selectedIndex],
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
      floatingActionButton: (_selectedIndex == 0 || _selectedIndex == 2)
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: secondary,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.black),
            )
          : null,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: secondary.withValues(alpha: 0.12),
          labelTextStyle: WidgetStateProperty.resolveWith(
            (states) => GoogleFonts.roboto(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: states.contains(WidgetState.selected)
                  ? secondary
                  : _inactive,
            ),
          ),
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? secondary
                  : _inactive,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          height: 68,
          onDestinationSelected: (index) {
            setState(() => _selectedIndex = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today_outlined),
              selectedIcon: Icon(Icons.calendar_today),
              label: 'Today',
            ),
            NavigationDestination(
              icon: Icon(Icons.inbox_outlined),
              selectedIcon: Icon(Icons.inbox),
              label: 'Inbox',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _Task {
  const _Task(this.title, this.time, this.accent);

  final String title;
  final String time;
  final Color accent;
}

const List<_Task> _todayTasks = [
  _Task('Design Wireframe', 'Friday 08:00 AM - 09:00 AM', Color(0xFFE57373)),
  _Task('Meet with client', 'Friday 10:00 AM - 11:00 AM', Color(0xFF64B5F6)),
];

const List<_Task> _aprilTasks = [
  _Task(
    'Brainstorming session - ideas',
    'Saturday 08:00 AM - 17:00 PM',
    Color(0xFF81C784),
  ),
];

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).colorScheme.secondary;

    return Container(
      color: const Color(0xFFFAF9F6),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Welcome, Kevin!',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'April 27, 2026',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: const Color(0xFF9E9E9E),
              ),
            ),
            const SizedBox(height: 20),
            const _SearchBar(),
            const SizedBox(height: 20),
            const _SectionHeader('Today (3)'),
            const SizedBox(height: 12),
            for (final task in _todayTasks) ...[
              _TaskCard(task: task),
              const SizedBox(height: 12),
            ],
            _NoteCard(
              title: "April's content selection",
              subtitle: "In april's content selection...",
              tint: secondary.withValues(alpha: 0.12),
            ),
            const SizedBox(height: 24),
            const _SectionHeader('30 Apr (1)'),
            const SizedBox(height: 12),
            for (final task in _aprilTasks) ...[
              _TaskCard(task: task),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(Radius.circular(14));
    return TextField(
      enabled: true,
      readOnly: true,
      decoration: const InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 16),
        prefixIcon: Icon(Icons.search),
        prefixIconColor: Color(0xFF9E9E9E),
        filled: true,
        fillColor: Color(0xFFF3F1EC),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black87),
      ],
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task});

  final _Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: task.accent, width: 2),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Color(0xFF8D6E63),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        task.time,
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          color: const Color(0xFF8D6E63),
                        ),
                      ),
                    ),
                    const Icon(Icons.alarm, size: 16, color: Color(0xFF9E9E9E)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.title, required this.subtitle, this.tint});

  final String title;
  final String subtitle;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            tint ??
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.menu_book, size: 22, color: Colors.black87),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    color: const Color(0xFF9E9E9E),
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

const List<Widget> _inboxItems = [
  _TaskCard(
    task: _Task(
      'Design Wireframe',
      'Friday 08:00 AM - 09:00 AM',
      Color(0xFFE57373),
    ),
  ),
  _TaskCard(
    task: _Task(
      'Meet with client',
      'Friday 10:00 AM - 11:00 AM',
      Color(0xFF64B5F6),
    ),
  ),
  _NoteCard(
    title: "April's content selection",
    subtitle: "In april's content selection...",
  ),
  _TaskCard(
    task: _Task(
      'Design Wireframe',
      'Friday 08:00 AM - 09:00 AM',
      Color(0xFFE57373),
    ),
  ),
  _TaskCard(
    task: _Task(
      'Meet with client',
      'Friday 10:00 AM - 11:00 AM',
      Color(0xFF64B5F6),
    ),
  ),
  _TaskCard(
    task: _Task(
      'Brainstorming session - ideas',
      'Saturday 08:00 AM - 17:00 PM',
      Color(0xFF81C784),
    ),
  ),
];

class _InboxPage extends StatelessWidget {
  const _InboxPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F6),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const _SearchBar(),
            const SizedBox(height: 20),
            for (final item in _inboxItems) ...[
              item,
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Avatar(),
            const SizedBox(height: 16),
            const Text(
              'Kevin',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            const _InfoCard(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: '+1 234567',
            ),
            const SizedBox(height: 12),
            const _InfoCard(
              icon: Icons.email_outlined,
              label: 'Email',
              value: 'email@example.com',
            ),
            const SizedBox(height: 12),
            const _InfoCard(
              icon: Icons.location_on_outlined,
              label: 'Address',
              value: 'London, United Kingdom',
            ),
            const SizedBox(height: 32),
            const _LogoutButton(),
          ],
        ),
      ),
    );
  }
}

/// Circular avatar (icon) with a small white edit badge on its bottom-right.
class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 56,
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, size: 64, color: Colors.grey.shade600),
          ),
          Positioned(
            right: 4,
            bottom: 4,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Icon(Icons.edit, size: 18, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

/// A rounded rectangle showing an icon, a small label and a value.
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}

/// A small, minimalist logout button with a hover effect.
class _LogoutButton extends StatefulWidget {
  const _LogoutButton();

  @override
  State<_LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<_LogoutButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovering
                ? const Color(0xFFFEE2E2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovering
                  ? const Color(0xFFFCA5A5)
                  : const Color(0xFFE5E7EB),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_rounded,
                size: 18,
                color: _hovering
                    ? const Color(0xFFDC2626)
                    : const Color(0xFF6B7280),
              ),
              const SizedBox(width: 8),
              Text(
                'Log out',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _hovering
                      ? const Color(0xFFDC2626)
                      : const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}