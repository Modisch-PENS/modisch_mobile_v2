import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modisch/features/main/models/menu_models.dart';
import 'package:modisch/features/main/constants/model_data.dart';
import 'package:modisch/features/main/widget/menu/popup_menu.dart';
import 'package:modisch/features/main/widget/fab/animated_fab.dart';
import 'package:modisch/features/main/controller/animated_menu_controller.dart';
import 'package:modisch/features/main/widget/bottom_bar/stylish_bottom_bar_wrapper.dart';
import 'package:modisch/features/main/widget/menu/menu_overlay.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AnimatedMenuController _menuController = AnimatedMenuController();
  late List<MenuSection> _menuSections;

  @override
  void initState() {
    super.initState();
    _initializeMenuSections();
    _menuController.addListener(_handleMenuUpdates);
  }

  @override
  void dispose() {
    _menuController.removeListener(_handleMenuUpdates);
    _menuController.dispose();
    super.dispose();
  }

  void _handleMenuUpdates() {
    if (mounted) {
      setState(() {});
    }
  }

  void _closeMenuIfOpen() {
    if (_menuController.isVisible) {
      _menuController.close();
    }
  }

  void _initializeMenuSections() {
    _menuSections = MenuData.getMenuSections(() => _menuController.close());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: Stack(
        children: [
          widget.navigationShell,

          MenuOverlay(
            isVisible: _menuController.isVisible,
            onTap: () => _menuController.close(),
          ),

          PopupMenu(
            isVisible: _menuController.isVisible,
            menuSections: _menuSections,
          ),
        ],
      ),
      bottomNavigationBar: StylishBottomBarWrapper(
        navigationShell: widget.navigationShell,
        onBeforeNavigation: _closeMenuIfOpen,
      ),
      floatingActionButton: AnimatedFAB(
        isMenuVisible: _menuController.isVisible,
        onPressed: () => _menuController.toggle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
