import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatelessWidget {
  //! aşağıdaki değişkeni goroouter ile kullanabilmek için ekledik. buradaki yapıyı router.dart dosyasında kullanıyoruz.
  final StatefulNavigationShell navigationShell;
  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: navigationShell,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            labelTextStyle: WidgetStateTextStyle.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(color: Theme.of(context).colorScheme.primary);
            }
            return TextStyle(color: Theme.of(context).colorScheme.tertiary);
          },
        )),
        child: NavigationBar(
            selectedIndex: navigationShell
                .currentIndex, //! burada navigationShell.currentIndex ile seçili olan indexi alıyoruz.
            onDestinationSelected: (index) => navigationShell.goBranch(
                index), //! burada ise seçilen indexe gitmek için goBranch fonksiyonunu kullanıyoruz.
            indicatorColor: Colors.transparent,
            destinations: [
              _menuItem(
                context,
                index: 0,
                currentIndex: navigationShell.currentIndex,
                icon: Icons.person,
                label: 'Karakterler',
              ),
              _menuItem(
                context,
                index: 1,
                currentIndex: navigationShell.currentIndex,
                icon: Icons.favorite,
                label: 'Favoriler',
              ),
              _menuItem(
                context,
                index: 2,
                currentIndex: navigationShell.currentIndex,
                icon: Icons.location_on,
                label: 'Konumlar',
              ),
              _menuItem(
                context,
                index: 3,
                currentIndex: navigationShell.currentIndex,
                icon: Icons.menu,
                label: 'Bölümler',
              ),
            ]),
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required IconData icon,
    required String label,
  }) {
    return NavigationDestination(
      icon: Icon(icon,
          color: currentIndex == index
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.tertiary),
      label: label,
    );
  }

  
}