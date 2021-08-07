import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:web_antrean_babatan/blocLayer/navbar/navbar_bloc.dart';
import 'package:web_antrean_babatan/utils/responsiveScaffold.dart';
import 'components/sideMenu.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NavbarBloc _navbarBloc = NavbarBloc();

  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat("dd/MM/yyyy HH:mm:ss").format(now);
  }

  @override
  void initState() {
    _navbarBloc.add(NavbarEventGetRole());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _navbarBloc,
      child: Scaffold(
        body: BlocBuilder<NavbarBloc, NavbarState>(
          builder: (context, state) {
            return ResponsiveScaffold(
              drawer: SideMenu(
                navbarBloc: _navbarBloc,
              ),
              body: (state is NavbarStateSuccessGetRole)
                  ? state.page
                  : SizedBox.shrink(),
              title: (state is NavbarStateSuccessGetRole)
                  ? Text(
                      state.title,
                      style: GoogleFonts.notoSans(),
                    )
                  : SizedBox.shrink(),
              trailing: Container(
                padding: EdgeInsets.all(16.0),
                child: TimerBuilder.periodic(
                  Duration(seconds: 1),
                  builder: (context) {
                    return Text(
                      getSystemTime(),
                      style: GoogleFonts.notoSans(
                        fontSize: 18,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
