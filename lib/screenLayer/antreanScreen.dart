import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_antrean_babatan/blocLayer/antrean/antrean_bloc.dart';
import 'package:web_antrean_babatan/dataLayer/model/poliklinik.dart';

class AntreanScreen extends StatefulWidget {
  @override
  _AntreanScreenState createState() => _AntreanScreenState();
}

class _AntreanScreenState extends State<AntreanScreen> {
  AntreanBloc _antreanBloc = AntreanBloc();

  @override
  void initState() {
    _antreanBloc.add(EventAntreanGetPoli());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _antreanBloc,
      child: BlocBuilder<AntreanBloc, AntreanState>(
        bloc: _antreanBloc,
        builder: (context, state) {
          if (state is StateAntreanGetPoliSuccess) {
            return successScreen(state.daftarPoli);
          }
          if (state is StateAntreanGetPoliFailed) {
            return failedScreen(state.messageFailed);
          } else {
            return loadingScreen();
          }
        },
      ),
    );
  }

  DefaultTabController successScreen(List<Poliklinik> daftarPoli) {
    return DefaultTabController(
      length: daftarPoli.length,
      child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.people),
            title: Text("Daftar Antrean"),
            bottom: TabBar(
              isScrollable: true,
              tabs: List<Widget>.generate(daftarPoli.length, (int index) {
                return Tab(text: daftarPoli[index].namaPoli);
              }),
            ),
          ),
          body: TabBarView(
            children: List<Widget>.generate(daftarPoli.length, (int index) {
              return Container(
                  color: Colors.teal[50],
                  child: Center(
                      child: Text(daftarPoli[index].namaPoli +
                          " " +
                          daftarPoli[index].idPoli.toString())));
            }),
          )),
    );
  }

  Scaffold failedScreen(String messageFailed) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.people),
          title: Text("Daftar Antrean"),
        ),
        body: Container(
          color: Colors.teal[50],
          child: Center(
            child: Text(messageFailed),
          ),
        ));
  }

  Scaffold loadingScreen() {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.people),
          title: Text("Daftar Antrean"),
        ),
        body: Container(
          color: Colors.teal[50],
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

/*
class AntreanScreen extends StatefulWidget {
  @override
  _AntreanScreenState createState() => _AntreanScreenState();
}

class _AntreanScreenState extends State<AntreanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: Icon(Icons.people),
        title: Text("Daftar Antrean"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(children: <Widget>[
          DataTable(
            showBottomBorder: true,
            columns: [
              DataColumn(
                  label: Text('Antrean',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Nama Pasien',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Tanggal Lahir',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Kepala Keluarga',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Jenis',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text('Aksi',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('Andi Fauzy')),
                DataCell(Text('15 Januari 2000')),
                DataCell(Text('Yoga Saputra')),
                DataCell(Text('Umum')),
                DataCell(Row(
                  children: [
                    Icon(Icons.access_time),
                    Icon(Icons.edit),
                    Icon(Icons.delete)
                  ],
                )),
              ]),
            ],
          ),
        ]),
      ),
    );
  }
}
*/