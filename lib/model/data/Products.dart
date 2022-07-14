class ProdProducts {
  String productImage;
  String name;
  String brand;
  double price;
  double totalPrice;
  String desc;
  String moreDesc;
  String weight;
  String size;
  String productID;
  String category;
  String subCategory;
  String service;
  String tag;
  int quantity;

  ProdProducts.fromMap(Map<String, dynamic> data) {
    productImage = data["productImage"];
    name = data["name"];
    brand = data["brand"];
    price = data["price"].toDouble();
    totalPrice = data["totalPrice"].toDouble();
    desc = data["desc"];
    moreDesc = data["moreDesc"];
    weight = data["weight"].toString();
    size = data["size"];
    productID = data["productID"];
    category = data["category"];
    subCategory = data["subCategory"];
    service = data["service"];
    tag = data["tag"];
    quantity = data["quantity"];
  }

  Map<String, dynamic> toMap() {
    return {
      'productImage': productImage,
      'name': name,
      'brand': brand,
      'price': price,
      'totalPrice': totalPrice,
      'desc': desc,
      'moreDesc': moreDesc,
      'weight': weight,
      'size': size,
      'productID': productID,
      'category': category,
      'subCategory': subCategory,
      'service': service,
      'tag': tag,
      'quantity': quantity,
    };
  }
}
