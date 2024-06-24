
class ItemsData {
  final String? name;
  final String? description;
  final String? link;
  final String? price;
  final int? quantity;
  final int? time;
  final String? sellable;
  final String? prodLink;
  final String? UID;
  final String? issuedTo;
  final String? pastUsers;

  const ItemsData(
      {required this.name,
      required this.description,
      required this.link,
      required this.price,
      required this.quantity,
      required this.time,
      required this.sellable,
      required this.prodLink,
      required this.UID,
      required this.pastUsers,
      required this.issuedTo});

  static ItemsData fromJson(Map<String, dynamic> data) => ItemsData(
      name: data["Item name"],
      description: data["Item description"],
      link: data["Item image link"],
      price: data["Item price"],
      quantity: data["Item quantity"],
      time: data["Return time"],
      sellable: data["Sellable?"],
      prodLink: data["Item product link"],
      UID: data["User ID"],
      pastUsers: data["Past Users"],
      issuedTo: data["IssuedD To"]);

  Map<String,dynamic> toJson() =>
  {'Item name': name,
    'Item description': description,
    'Item image link' : link,
    'Item price' : price,
    'Item quantity' : quantity,
    'Return time' : time,
    'Sellable?' : sellable,
    'Item product link' : prodLink,
    'User ID' : UID,
    'Past Users' : pastUsers,
    'Issued To' : issuedTo,
  };
}
  // Stream<List<ItemsData>> getItems() {
  //   final data = FirebaseFirestore.instance.collection("items").snapshots().map(
  //       (snapshot) =>
  //           snapshot.docs.map((doc) => ItemsData.fromJson(doc.data())).toList());
  //   return data;
  // }




  // factory ItemsData.fromSnapShot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   final data = document.data()!;

  //   return ItemsData(
  //       name: data["Item name"],
  //       description: data["Item description"],
  //       link: data["Item image link"],
  //       price: data["Item price"],
  //       quantity: data["Item quantity"],
  //       time: data["Return time"],
  //       sellable: data["Sellable?"]);
  // }
