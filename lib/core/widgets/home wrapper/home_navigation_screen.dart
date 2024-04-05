import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fruit_market/core/constants/colors.dart';
import 'package:fruit_market/core/constants/icons.dart';
import 'package:go_router/go_router.dart';

class HomeNavigationScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const HomeNavigationScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goToBranch,
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(homeIcon),
              selectedIcon: SvgPicture.asset(
                homeIcon,
                colorFilter: const ColorFilter.mode(primary, BlendMode.srcIn),
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(cartIcon),
              selectedIcon: SvgPicture.asset(
                cartIcon,
                colorFilter: const ColorFilter.mode(primary, BlendMode.srcIn),
              ),
              label: 'Shopping Cart',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(favouriteIcon),
              selectedIcon: SvgPicture.asset(
                favouriteIcon,
                colorFilter: const ColorFilter.mode(primary, BlendMode.srcIn),
              ),
              label: 'Favourites',
            ),
            NavigationDestination(
              icon: SvgPicture.asset(accountIcon),
              selectedIcon: SvgPicture.asset(
                accountIcon,
                colorFilter: const ColorFilter.mode(primary, BlendMode.srcIn),
              ),
              label: 'My Account',
            ),
          ]),
    );
  }

  void _goToBranch(int value) {
    navigationShell.goBranch(value);
  }
}
