class Restaurant {
  final String _image;
  final String _name;
  Restaurant(this._image, this._name);

  String getImage() => _image;

  String getName() => _name;
}

class IDRestaurant extends Restaurant {
  final String _id;
  IDRestaurant(image, name, this._id): super(image, name);

  String getId() => _id;
}