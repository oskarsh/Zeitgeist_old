class Character {
  String name;
  int price;
  String image_path;

  Character(this.name, this.price, this.image_path);

  Character.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        image_path = json['image_path'];
}
