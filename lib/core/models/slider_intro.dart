class SliderIntro {
  String imagem; //
  String introducao; //
  String descricao;
  String link;
  String btnTxt;

  SliderIntro({
    required this.imagem,
    required this.introducao,
    required this.descricao,
    required this.link,
    required this.btnTxt,
  });


  SliderIntro.fromJson(Map json)
      : imagem = json['imagem']!.toString(),
        introducao = json['introducao'],
        descricao = json['descricao'],
        link = json['link'],
        btnTxt = json['btnTxt']; //json['date']!;
}
