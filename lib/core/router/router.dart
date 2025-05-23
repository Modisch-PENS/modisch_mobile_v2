import 'package:go_router/go_router.dart';
import 'package:modisch/features/addition/item/page/add_item_page.dart';
import 'package:modisch/features/addition/outfit/page/add_outfit_page.dart';
import 'package:modisch/features/main/page/home/page/home_page.dart';
import 'package:modisch/features/main/page/main_page.dart';
import 'package:modisch/features/main/page/planner/page/planner_page.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              MainPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'wardrobe',
                  name: 'wardrobe',
                  builder: (context, state) => const HomePage(),
                ),
                GoRoute(
                  path: 'model',
                  name: 'model',
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/planner',
              name: 'planner',
              builder: (context, state) => const PlannerPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/add',
      name: 'add',
      redirect: (context, state) => '/home/wardrobe', // Safety redirect
      routes: [
        GoRoute(
          path: 'item',
          name: 'item',
          redirect: (context, state) => '/home/wardrobe', // Safety redirect
          routes: [
            GoRoute(
              path: 'image_picker',
              name: 'image_picker',
              builder: (context, state) => const AddItemPage(),
            ),
          ]
        ),
        GoRoute(
          path: 'outfit',
          name: 'outfit',
          redirect: (context, state) => '/home/wardrobe', // Safety redirect
          routes: [
            GoRoute(
              path: 'canvas',
              name: 'canvas',
              builder: (context, state) => const AddOutfitPage(),
            ),
            GoRoute(
              path: 'tagging',
              name: 'tagging',
              builder: (context, state) => const AddOutfitPage(),
            ),
          ]
        ),
      ],
    ),
  ],
);