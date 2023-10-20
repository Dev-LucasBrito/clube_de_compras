class BannersModel {
 
  String? name;
  String? link;
  String? img;

  BannersModel({
    
     this.name,
   
     this.img,
     this.link,

  });


  BannersModel.fromJson(Map json)
      :
        link = json['link'] ?? '',
        name = json['nome']?? '',
       
        img = json['imagem']?? ''; //json['date']!;
}
