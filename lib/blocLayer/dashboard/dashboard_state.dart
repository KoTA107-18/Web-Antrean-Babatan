part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {
  const DashboardState();
}

class StateDashboardLoading extends DashboardState {}

class StateDashboardSuccess extends DashboardState {
  final List<InfoPoliklinik> daftarPoli;
  StateDashboardSuccess({@required this.daftarPoli});
}

class StateDashboardFailed extends DashboardState {
  final String messageFailed;
  StateDashboardFailed({@required this.messageFailed});
}
