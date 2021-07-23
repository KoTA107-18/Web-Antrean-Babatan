class InfoPoliklinik {
  String idPoli;
  String namaPoli;
  String statusPoli;
  List<TotalAntrean> totalAntrean;
  List<AntreanSementara> antreanSementara;
  List<NomorAntrean> nomorAntrean;

  InfoPoliklinik(
      {this.idPoli,
        this.namaPoli,
        this.statusPoli,
        this.totalAntrean,
        this.antreanSementara,
        this.nomorAntrean});

  InfoPoliklinik.fromJson(Map<String, dynamic> json) {
    idPoli = json['id_poli'];
    namaPoli = json['nama_poli'];
    statusPoli = json['status_poli'];
    if (json['total_antrean'] != null) {
      totalAntrean = new List<TotalAntrean>();
      json['total_antrean'].forEach((v) {
        totalAntrean.add(new TotalAntrean.fromJson(v));
      });
    }
    if (json['antrean_sementara'] != null) {
      antreanSementara = new List<AntreanSementara>();
      json['antrean_sementara'].forEach((v) {
        antreanSementara.add(new AntreanSementara.fromJson(v));
      });
    }
    if (json['nomor_antrean'] != null) {
      nomorAntrean = new List<NomorAntrean>();
      json['nomor_antrean'].forEach((v) {
        nomorAntrean.add(new NomorAntrean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_poli'] = this.idPoli;
    data['nama_poli'] = this.namaPoli;
    data['status_poli'] = this.statusPoli;
    if (this.totalAntrean != null) {
      data['total_antrean'] = this.totalAntrean.map((v) => v.toJson()).toList();
    }
    if (this.antreanSementara != null) {
      data['antrean_sementara'] =
          this.antreanSementara.map((v) => v.toJson()).toList();
    }
    if (this.nomorAntrean != null) {
      data['nomor_antrean'] = this.nomorAntrean.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalAntrean {
  String result;
  String laravelThroughKey;

  TotalAntrean({this.result, this.laravelThroughKey});

  TotalAntrean.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    laravelThroughKey = json['laravel_through_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['laravel_through_key'] = this.laravelThroughKey;
    return data;
  }
}

class AntreanSementara {
  String result;
  String laravelThroughKey;

  AntreanSementara({this.result, this.laravelThroughKey});

  AntreanSementara.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    laravelThroughKey = json['laravel_through_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['laravel_through_key'] = this.laravelThroughKey;
    return data;
  }
}

class NomorAntrean {
  String result;
  String laravelThroughKey;

  NomorAntrean({this.result, this.laravelThroughKey});

  NomorAntrean.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    laravelThroughKey = json['laravel_through_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['laravel_through_key'] = this.laravelThroughKey;
    return data;
  }
}