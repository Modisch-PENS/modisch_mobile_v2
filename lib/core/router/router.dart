import 'package:go_router/go_router.dart';
import 'package:modisch/core/router/route_constants.dart';
import 'package:modisch/features/addition/item/page/add_item_page.dart';
import 'package:modisch/features/addition/outfit/page/add_outfit_page.dart';
import 'package:modisch/features/main/page/home/page/home_page.dart';
import 'package:modisch/features/main/page/main_page.dart';
import 'package:modisch/features/main/page/planner/page/planner_page.dart';

final router = GoRouter(
  initialLocation: RouteConstants.homePath,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainPage(navigationShell: navigationShell),
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteConstants.homePath,
              name: RouteConstants.home,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: RouteConstants.wardrobePath,
                  name: RouteConstants.wardrobe,
                  builder: (context, state) => const HomePage(),
                ),
                GoRoute(
                  path: RouteConstants.modelPath,
                  name: RouteConstants.model,
                  builder: (context, state) => const HomePage(),
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
    GoRoute(
      path: RouteConstants.addItemImagePickerPath,
      name: RouteConstants.addItemImagePicker,
      builder: (context, state) => const AddItemPage(),
    ),
    GoRoute(
      path: RouteConstants.addOutfitCanvasPath,
      name: RouteConstants.addOutfitCanvas,
      builder: (context, state) => const AddOutfitPage(),
    ),
    GoRoute(
      path: RouteConstants.addOutfitTaggingPath,
      name: RouteConstants.addOutfitTagging,
      builder: (context, state) => const AddOutfitPage(),
    ),
  ],
);