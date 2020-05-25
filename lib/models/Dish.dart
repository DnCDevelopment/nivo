class Dish {
  final String _image;
  final String _name;
  final String _price;
  final String _restaurant;
  Dish(this._image, this._name, this._price, this._restaurant);

  String getImage() => _image;

  String getName() => _name;

  String getPrice() => _price;

  String getRestaurant() => _restaurant;
}

class IDDish extends Dish {
  final String _id;
  IDDish(image, name, price, restaurant, this._id): super(image, name, price, restaurant);

  String getId() => _id;
}
