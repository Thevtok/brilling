class Tagihan {
  String? no;
  String? noinvoice;
  String? hargainvoice;
  String? ppn;
  String? idpelangganppoe;
  String? idpenjualan;
  String? tglinvoice;
  String? status;
  String? cdate;

  Tagihan({
    this.no,
    this.noinvoice,
    this.hargainvoice,
    this.ppn,
    this.idpelangganppoe,
    this.idpenjualan,
    this.tglinvoice,
    this.status,
    this.cdate,
  });

  factory Tagihan.fromJson(Map<String, dynamic> json) {
    return Tagihan(
      no: json['no']?.toString(),
      noinvoice: json['noinvoice']?.toString(),
      hargainvoice: json['hargainvoice']?.toString(),
      ppn: json['ppn']?.toString(),
      idpelangganppoe: json['idpelangganppoe']?.toString(),
      idpenjualan: json['idpenjualan']?.toString(),
      tglinvoice: json['tglinvoice']?.toString(),
      status: json['status']?.toString(),
      cdate: json['cdate']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'noinvoice': noinvoice,
      'hargainvoice': hargainvoice,
      'ppn': ppn,
      'idpelangganppoe': idpelangganppoe,
      'idpenjualan': idpenjualan,
      'tglinvoice': tglinvoice,
      'status': status,
      'cdate': cdate,
    };
  }
}
