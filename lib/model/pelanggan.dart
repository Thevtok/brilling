class Pelanggan {
  final String? no;
  final String? idPenjualan;
  final String? namaPelanggan;
  final String? noKtp;
  final String? noHp;
  final String? userPppoe;
  final String? passPppoe;
  final String? lat;
  final String? longitude;
  final String? hargaJual;
  final String? alamat;
  final String? idPaketPppoe;
  final String? cdate;
  final String? idOnMikrotik;
  final String? status;

  Pelanggan({
    this.no,
    this.idPenjualan,
    this.namaPelanggan,
    this.noKtp,
    this.noHp,
    this.userPppoe,
    this.passPppoe,
    this.lat,
    this.longitude,
    this.hargaJual,
    this.alamat,
    this.idPaketPppoe,
    this.cdate,
    this.idOnMikrotik,
    this.status,
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      no: json['no'],
      idPenjualan: json['idpenjualan'],
      namaPelanggan: json['namapelanggan'],
      noKtp: json['noktp'],
      noHp: json['nohp'],
      userPppoe: json['userppoe'],
      passPppoe: json['passppoe'],
      lat: json['lat'],
      longitude: json['longitude'],
      hargaJual: json['hargajual'],
      alamat: json['alamat'],
      idPaketPppoe: json['idpaketppoe'],
      cdate: json['cdate'],
      idOnMikrotik: json['idonmikrotik'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'idpenjualan': idPenjualan,
      'namapelanggan': namaPelanggan,
      'noktp': noKtp,
      'nohp': noHp,
      'userppoe': userPppoe,
      'passppoe': passPppoe,
      'lat': lat,
      'longitude': longitude,
      'hargajual': hargaJual,
      'alamat': alamat,
      'idpaketppoe': idPaketPppoe,
      'cdate': cdate,
      'idonmikrotik': idOnMikrotik,
      'status': status,
    };
  }
}
