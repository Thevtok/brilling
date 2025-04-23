class Pool {
  final String? namapool;
  final String? ranges;
  final String? idonmikrotik;
  final String? idippool;

  Pool({
    this.namapool,
    this.ranges,
    this.idonmikrotik,
    this.idippool,
  });

  factory Pool.fromJson(Map<String, dynamic> json) {
    return Pool(
      namapool: json['namapool'] as String?,
      ranges: json['ranges'] as String?,
      idonmikrotik: json['idonmikrotik'] as String?,
      idippool: json['idippool'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namapool': namapool,
      'ranges': ranges,
      'idonmikrotik': idonmikrotik,
      'idippool': idippool,
    };
  }
}



