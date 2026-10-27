import 'package:flutter/material.dart';

import 'discover_page.dart';
import 'home_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          HomePage(loadFeed: widget.loadFeed),
          const DiscoverPage(),
          KeyedSubtree(
            key: ValueKey<String>('notifications-$_epoch'),
            child: const NotificationsPage(),
          ),
          KeyedSubtree(
            key: ValueKey<String>('profile-$_epoch'),
            child: const ProfilePage(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() {
          _index = index;
          // Refresh login-dependent tabs when they are entered.
          _epoch += 1;
        }),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: '首页',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: '发现',
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
        ],
      ),
    );
  }
}
