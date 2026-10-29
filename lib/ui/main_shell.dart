import 'package:material_ui/material_ui.dart';

import 'discover_page.dart';
import 'home_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';

/// Material 3 window-size breakpoints used by the shell.
const double kCompactBreakpoint = 600;
const double kExpandedBreakpoint = 1200;

/// The maximum readable width for a page body on large windows.
const double kContentMaxWidth = 1200;

class MainShell extends StatefulWidget {
  const MainShell({super.key, this.loadFeed = true});

  /// Allows tests to disable the live homepage feed.
  final bool loadFeed;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  int _epoch = 0;

  static const List<NavigationDestination> _destinations =
      <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.people_outline_rounded),
          selectedIcon: Icon(Icons.people_rounded),
          label: '关注',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore_rounded),
          label: '广场',
        ),
        NavigationDestination(
          icon: Icon(Icons.notifications_none_rounded),
          selectedIcon: Icon(Icons.notifications_rounded),
          label: '消息',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: '我的',
        ),
      ];

  static const List<NavigationRailDestination> _railDestinations =
      <NavigationRailDestination>[
        NavigationRailDestination(
          icon: Icon(Icons.people_outline_rounded),
          selectedIcon: Icon(Icons.people_rounded),
          label: Text('关注'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore_rounded),
          label: Text('广场'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.notifications_none_rounded),
          selectedIcon: Icon(Icons.notifications_rounded),
          label: Text('消息'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: Text('我的'),
        ),
      ];

  void _select(int index) {
    setState(() {
      _index = index;
      // Refresh login-dependent tabs when they are entered.
      _epoch += 1;
    });
  }

  List<Widget> _pageList() {
    return <Widget>[
      HomePage(loadFeed: widget.loadFeed, onExplore: () => _select(1)),
      DiscoverPage(loadFeed: widget.loadFeed),
      KeyedSubtree(
        key: ValueKey<String>('notifications-$_epoch'),
        child: const NotificationsPage(),
      ),
      KeyedSubtree(
        key: ValueKey<String>('profile-$_epoch'),
        child: const ProfilePage(),
      ),
    ];
  }

  Widget _pages() {
    final pages = _pageList();
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          for (var i = 0; i < pages.length; i++)
            AnimatedOpacity(
              opacity: _index == i ? 1 : 0,
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              child: IgnorePointer(
                ignoring: _index != i,
                child: ExcludeSemantics(
                  excluding: _index != i,
                  child: TickerMode(
                    enabled: _index == i,
                    child: AnimatedSlide(
                      offset: _index == i
                          ? Offset.zero
                          : i < _index
                          ? const Offset(-0.018, 0)
                          : const Offset(0.018, 0),
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      child: pages[i],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _content(BoxConstraints constraints) {
    final width = constraints.maxWidth.clamp(0.0, kContentMaxWidth);
    return Center(
      child: SizedBox(
        width: width,
        height: constraints.maxHeight,
        child: _pages(),
      ),
    );
  }

  Widget _brand(ThemeData theme, {required bool extended}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(extended ? 20 : 12, 18, 12, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.forum_rounded,
              color: theme.colorScheme.onPrimaryContainer,
              size: 21,
            ),
          ),
          if (extended) ...<Widget>[
            const SizedBox(width: 12),
            Text(
              'Feiba',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < kCompactBreakpoint;
        final extended = constraints.maxWidth >= kExpandedBreakpoint;
        if (compact) {
          return Scaffold(
            body: _content(constraints),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _index,
              onDestinationSelected: _select,
              destinations: _destinations,
            ),
          );
        }

        return Scaffold(
          body: Row(
            children: <Widget>[
              SafeArea(
                right: false,
                bottom: false,
                child: NavigationRail(
                  selectedIndex: _index,
                  onDestinationSelected: _select,
                  extended: extended,
                  minExtendedWidth: 220,
                  labelType: extended
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  groupAlignment: -0.55,
                  backgroundColor: theme.colorScheme.surface,
                  leading: _brand(theme, extended: extended),
                  destinations: _railDestinations,
                ),
              ),
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              Expanded(child: _content(constraints)),
            ],
          ),
        );
      },
    );
  }
}