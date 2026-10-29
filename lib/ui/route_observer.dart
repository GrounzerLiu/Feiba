import 'package:material_ui/material_ui.dart';

/// Shared observer used to avoid reordering a list while its route is covered.
final RouteObserver<ModalRoute<void>> appRouteObserver =
    RouteObserver<ModalRoute<void>>();
