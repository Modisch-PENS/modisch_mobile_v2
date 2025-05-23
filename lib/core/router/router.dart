import 'package:go_router/go_router.dart';
import 'package:modisch/features/main/page/home/page/home_page.dart';
import 'package:modisch/features/main/page/main_page.dart';
import 'package:modisch/features/main/page/planner/page/planner_page.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
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
                  path: '/wardrobe',
                  name: 'wardrobe',
                  builder: (context, state) => const HomePage(), 
                ),
                GoRoute(
                  path: '/outfit',
                  
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
              builder: (context, state) => const PlannerPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
