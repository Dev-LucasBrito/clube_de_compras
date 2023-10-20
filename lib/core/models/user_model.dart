class UserModel {
  int clientId; //
  String name; //
  String email; //
  String cpf; //
  String? imagem; //
  String token;

  UserModel({
    required this.clientId,
    required this.name,
    required this.email,
    required this.cpf,
    this.imagem,
    required this.token,
  });

  UserModel.fromJson(Map json)
      : name = json['nome'] ?? "",
        clientId = json['clienteId'] ?? 0,
        email = json['email'] ?? "",
        token = json['token'] ?? "",
        cpf = json['documento'] ?? "",
        imagem = json['imagem'] ?? ''; //json['date']!;

  Map<String, dynamic> toMap() => {
        "name": name,
        "clientId": clientId,
        "email": email,
        "token": token,
        "cpf": cpf,
        "imagem": imagem ?? 'vazio'
      };

       UserModel.fromJsonInEnglish(Map json)
      : name = json['name'] ?? "",
        clientId = json['clientId'] ?? 0,
        email = json['email'] ?? "",
        token = json['token'] ?? "",
        cpf = json['cpf'] ?? "",
        imagem = json['imagem'] ?? ''; //json['date']!;
}
