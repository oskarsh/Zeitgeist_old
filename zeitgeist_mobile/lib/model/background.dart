class Background {
  String name;
  String image_path;
  int price;

  Background(this.name, this.price, this.image_path);

  Background.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        image_path = json['image_path'];
}
