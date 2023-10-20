class StatementModel {
  int? id; //
  String? storeName; //
  String? productName; //
  double? cashback;
  double? cashbackUser;
  DateTime? date;
  String? operacao; // - == entrada - + == saida
  String? status; // - == entrada - + == saida

  StatementModel({
    this.id,
    this.storeName,
    this.productName,
    this.cashback,
    this.date,
    this.operacao,
    this.cashbackUser,
    this.status
  });

  StatementModel.fromJson(Map json)
      : storeName = json['identificacao'] ?? '',
        id = int.parse(json['id'].toString()) ,
        productName = json['NomeProduto'] ?? '',
        cashback = double.parse(json['valor'].toString()),
        cashbackUser = double.parse(json['saldo'].toString()) ,
        status = json['status'] ?? '',
        date = json['data'] == null
            ? DateTime.now()
            : DateTime.parse(json['data']!),
        operacao = json['operacao'] ?? ''; //json['date']!;
}
