import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: _selectedIndex == 0
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
