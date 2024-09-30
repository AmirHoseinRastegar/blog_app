
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/profile/presentation/screens/profile_screen.dart';
import 'features/blog/presentation/screens/home_screen.dart';

class MainWrapper2 extends StatefulWidget {
  static rout() => MaterialPageRoute(builder: (context) => const MainWrapper2());

  const MainWrapper2({super.key});

  @override
  State<MainWrapper2> createState() => _MainWrapper2State();
}

const homeIndex = 0;
const profileIndex = 1;

class _MainWrapper2State extends State<MainWrapper2> {
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    homeKey,
    profileKey,
  ];
  Future<bool> onPopInvoked(bool didPop) {
    if (_navigatorKeys[selectedIndex].currentState!.canPop()) {
      _navigatorKeys[selectedIndex]
          .currentState!
          .pop(_navigatorKeys[selectedIndex].currentContext);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
    return Future.value(false);
  }

  int selectedIndex = homeIndex;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked:onPopInvoked ,
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: const [
             HomeScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          selectedItemColor: Colors.red,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
