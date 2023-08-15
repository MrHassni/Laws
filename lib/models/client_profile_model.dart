class ClientModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNo;
  final String password;
  final String address;
  final String? image;
  final String path;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClientModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.path
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      email: json['email'],
      phoneNo: json['phone_no'],
      password: json['password'],
      address: json['address'],
      image: json['image'],
      path: json['path'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
