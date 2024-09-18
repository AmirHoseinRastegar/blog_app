import '../../domain/entities/auth_user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.name, required super.email});

 factory UserModel.fromJson(Map<String, dynamic> json) {
   return UserModel(
     id: json['id'] ?? '',
     name: json['name'] ?? '',
     email: json['email'] ?? '',
   );
 }
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}

