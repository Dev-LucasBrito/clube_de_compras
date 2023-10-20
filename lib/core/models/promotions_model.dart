class PromotionsModel {
 
  String? owner; //
 
  DateTime? date;
  String? description;
  String? intro;
  String? link;
  String? img;

  PromotionsModel({
    
     this.owner,
     this.date,
     this.description,
     this.img,
     this.link,
     this.intro,
  });


  PromotionsModel.fromJson(Map json)
      :
        link = json['link'] ?? '',
        owner = json['associadoNome']?? '',
        intro = json['introducao']?? '',
        description = json['descricao']?? '',
        img = json['imagem']?? '',
        date = DateTime.now(); //json['date']!;
}
