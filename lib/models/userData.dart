class UserData {
  final String email;
  final String firstname;
  final String uid;
  final String lastname;
  final int Previous;
  final List Cart;
  final List IssuedItems;
  final List RequestedItems;
  final String PhotoUrl;

  const UserData(
      {required this.firstname,
      required this.email,
      required this.uid,
      required this.lastname,
      required this.Previous,
      required this.Cart,
      required this.IssuedItems,
      required this.RequestedItems,
      required this.PhotoUrl});

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'uid': uid,
        'email': email,
        'lastname': lastname,
        'Cart': Cart,
        'Previous': Previous,
        'issuedItems': IssuedItems,
        'requested items': RequestedItems,
        'PhotoUrl': PhotoUrl,
      };

  static UserData fromJson(Map<String, dynamic> data) => UserData(
        firstname: data["firstname"],
        lastname: data["lastname"],
        email: data["email"],
        uid: data["uid"],
        Cart: data["Cart"],
        Previous: data["Previous"],
        IssuedItems: data["issuedItems"],
        RequestedItems: data["requested items"],
        PhotoUrl: data["PhotoUrl"],
      );
}
