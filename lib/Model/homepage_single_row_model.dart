class HomeSingleRowModel{
  HomeSingleRowModel({
    this.name,
    this.location,
    this.image,
    this.price,
    this.about,
    this.length,
  });

  String? name;
  String? location;
  String? image;
  int? price;
  String? about;
  int? length;

  factory HomeSingleRowModel.fromJson(Map<String, dynamic> json) => HomeSingleRowModel(
    name: json["name"],
    location: json["location"],
    image: json["image"],
    price: json["price"],
    about: json["about"],
    length: json["length"],
  );
}