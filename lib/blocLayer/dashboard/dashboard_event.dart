part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  const DashboardEvent();
}

class EventDashboardGetPoli extends DashboardEvent {}

class EventDashboardGetPoliSilent extends DashboardEvent {}

class EventDashboardBukaPortal extends DashboardEvent {}

class EventDashboardTutupPortal extends DashboardEvent {}

class EventDashboardChangeStatusPoli extends DashboardEvent {
  final int indexPoli;
  EventDashboardChangeStatusPoli({@required this.indexPoli});
}
