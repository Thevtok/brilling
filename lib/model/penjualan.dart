class Penjualan {
  String? idpenjualan;
  String? nama;
  String? namapaket;
  String? hargajual;
  String? status;
  String? iprouter;
  String? namarouter;

  Penjualan({
    this.idpenjualan,
    this.nama,
    this.namapaket,
    this.hargajual,
    this.status,
    this.iprouter,
    this.namarouter,
  });

  factory Penjualan.fromJson(Map<String, dynamic> json) {
    return Penjualan(
      idpenjualan: json['idpenjualan'],
      nama: json['nama'],
      namapaket: json['namapaket'],
      hargajual: json['hargajual'],
      status: json['status'],
      iprouter: json['iprouter'],
      namarouter: json['namarouter'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idpenjualan': idpenjualan,
      'nama': nama,
      'namapaket': namapaket,
      'hargajual': hargajual,
      'status': status,
      'iprouter': iprouter,
      'namarouter': namarouter,
    };
  }
}
