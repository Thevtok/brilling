class Paket {
  final String? idpaket;
  final String? namapaket;
  final String? kecepatan;
  final String? idippool;
  final String? rangesippool;
  final String? idonmikrotik;
  final String? hargapaket;

  Paket({
    this.idpaket,
    this.namapaket,
    this.kecepatan,
    this.idippool,
    this.rangesippool,
    this.idonmikrotik,
    this.hargapaket,
  });

  factory Paket.fromJson(Map<String, dynamic> json) {
    return Paket(
      idpaket: json['idpaket'] as String?,
      namapaket: json['namapaket'] as String?,
      kecepatan: json['kecepatan'] as String?,
      idippool: json['idippool'] as String?,
      rangesippool: json['rangesippool'] as String?,
      idonmikrotik: json['idonmikrotik'] as String?,
      hargapaket: json['hargapaket'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idpaket': idpaket,
      'namapaket': namapaket,
      'kecepatan': kecepatan,
      'idippool': idippool,
      'rangesippool': rangesippool,
      'idonmikrotik': idonmikrotik,
      'hargapaket': hargapaket,
    };
  }
}
