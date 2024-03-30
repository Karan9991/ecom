class Users{
  final String name;
  final String email;
  final String address;

  Users({required this.name,
  required this.email,
    required this.address,
  });

  factory Users.fromJson(Map<String, dynamic> json) =>
     Users(name: json['name'], email: json['email'], address: json['address']);

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'address': address,
  };
}
