class MuralModel {
 
  String imagem; //`
  String nome;
  String link;

  MuralModel({
    
    required this.imagem,
    required this.nome,
    required this.link,
  });

  MuralModel.fromJson(Map json)
      : 
        imagem = json['imagem'] ?? '',
        nome = json['nome'] ?? '',
        link = json['link'] ?? ''; //json['date']!;
}
