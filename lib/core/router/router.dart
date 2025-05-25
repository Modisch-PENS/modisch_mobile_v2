import 'package:go_router/go_router.dart';
import 'package:modisch/core/router/route_constants.dart';
import 'package:modisch/features/addition/item/page/add_items_page.dart';
import 'package:modisch/features/addition/item/page/confirm_item_page.dart';
import 'package:modisch/features/addition/outfit/page/add_outfit_page.dart';
import 'package:modisch/features/main/page/home/page/home_page.dart';
import 'package:modisch/features/main/page/main_page.dart';
import 'package:modisch/features/main/page/planner/page/planner_page.dart';

final router = GoRouter(
  initialLocation: RouteConstants.homePath,
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              MainPage(navigationShell: navigationShell),
      branches: [
        // Home Branch dengan nested tab (wardrobe & model)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteConstants.homePath,
              name: RouteConstants.home,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'add-items',
                  name: RouteConstants.addItems,
                  builder: (context, state) => const AddItemsPage(),
                  routes: [
                    GoRoute(
                      path: 'confirm-item',
                      name: RouteConstants.confirmItem,
                      builder: (context, state) {
                        final extra = state.extra as Map<String, dynamic>?;
                        return ConfirmItemPage(
                          imagePath: extra?['imagePath'] as String?,
                          isFromSample:
                              extra?['isFromSample'] as bool? ?? false,
                        );
                      },
                    ),
                  ],
                ),

                GoRoute(
                  path: 'add-outfit-canvas',
                  name: RouteConstants.addOutfitCanvas,
                  builder: (context, state) => const AddOutfitPage(),
                ),
                GoRoute(
                  path: 'add-outfit-tagging',
                  name: RouteConstants.addOutfitTagging,
                  builder: (context, state) => const AddOutfitPage(),
                ),
              ],
            ),
          ],
        ),
        // Planner Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteConstants.plannerPath,
              name: RouteConstants.planner,
              builder: (context, state) => const PlannerPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
