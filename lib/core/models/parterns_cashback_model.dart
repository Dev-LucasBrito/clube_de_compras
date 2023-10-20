class ParternsCashbackModel {
  String title; //
  int id;
  String? cashback;
  DateTime? date;
  String? description;
  String img;
  String? category;
  String? categorySlug;
  String? link;
  String? email;
  String? whatsApp;
  String? address;
  String? status;
  String? documento;

  ParternsCashbackModel(
      {required this.title,
      this.cashback,
      this.date,
      this.category,
      this.categorySlug,
      this.link,
      this.description,
      this.email,
      this.whatsApp,
      this.address,
      this.documento,
      required this.img,
      required this.id,
      this.status});

  ParternsCashbackModel.fromJson(Map json)
      : title = json['nome']!.toString(),
        id = json['id'] ?? 0,
        cashback = json['bonificacao'] ?? '',
        description = json['descricao'] ?? '',
        category = json['segmento'] ?? '',
        categorySlug = json['segmentoSlug'] ?? '',
        link = json['website'] ?? '',
        email = json['email'] ?? '',
        address = json['endereco'] ?? '',
        whatsApp = json['telefone'] ?? '',
        img = json['imagem'],
        documento = json['documento'],
        status = json['status'].toString(),
        date = DateTime.now(); //json['date']!;
}
