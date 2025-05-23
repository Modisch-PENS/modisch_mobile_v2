import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modisch/features/main/models/menu_models.dart';
import 'package:modisch/features/main/constants/model_data.dart';
import 'package:modisch/features/main/widget/menu/popup_menu.dart';
import 'package:modisch/features/main/widget/fab/animated_fab.dart';
import 'package:modisch/features/main/widget/bottom_bar/stylish_bottom_bar_wrapper.dart';
import 'package:modisch/features/main/widget/menu/menu_overlay.dart';
import 'package:modisch/shared/widget/overlay/overlay_controller.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final OverlayController _menuController = OverlayController();
  late List<MenuSection> _menuSections;

  @override
  void initState() {
    super.initState();
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
      _menuController.hide();
    }
  }

  List<MenuSection> _getMenuSections() {
    return MenuData.getMenuSections(context, () => _menuController.hide());
  }

  @override
  Widget build(BuildContext context) {
    _menuSections = _getMenuSections();
    
    return Scaffold(
      // extendBody: true,
      body: Stack(
        children: [
          widget.navigationShell,

          MenuOverlay(
            isVisible: _menuController.isVisible,
            onTap: () => _menuController.hide(),
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
