import 'package:auto_route/auto_route.dart';
import 'package:portal/presentations/pages/all_documents_screen.dart';
import 'package:portal/presentations/pages/calendar_screen.dart';
 import 'package:portal/presentations/pages/home_screen.dart';
import 'package:portal/presentations/pages/main_screen.dart';
 
//TODO: launch following command to auto-generate route file: flutter packages pub run build_runner build
//TODO: launch following command if white screen appear on start: flutter pub cache repair
@AdaptiveAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(
      initial: true,
      page: MainScreen,
      name: 'MainRoute',
      path: '/',
      children: [
        AutoRoute(
          page: HomeScreen,
          name: 'HomeRoute',
          path: 'home',
        ),
        AutoRoute(
          page: CalendarScreen,
          name: 'CalendarRoute',
          path: 'calendar',
        ),
       
         // AutoRoute(
        //   page: DashboardScreen,
        //   name: 'DashboardRoute',
        //   path: 'dashboard'
        // ),
       
     

         RedirectRoute(path: "*", redirectTo: "")
      ]
    ),
    AutoRoute(
          page: AllDocumentsScreen,
          name: "AllDocumentsRoute",
          path: "/allDocument/:listDocument",
        ),
        
    
    
  ]
)
class $AppRouter{}
