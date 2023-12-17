import 'package:crudapiproject/screens/home/home_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [MaterialRoute(page: HomeView, initial: true)],
  dependencies: [
    Singleton(classType: NavigationService),
  ],
)
class App {}
