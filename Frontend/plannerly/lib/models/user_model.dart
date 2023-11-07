// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  // ID            primitive.ObjectID `bson:"_id"`
  // First_name    *string            `json:"first_name" validate:"required,min=2,max=100"`
  // Last_name     *string            `json:"last_name" validate:"required,min=2,max=100"`
  // Password      *string            `json:"password" validate:"required,min=6"`
  // Email         *string            `json:"email" validate:"email,required"`
  // Phone         *string            `json:"phone" validate:"required"`
  // Token         *string            `json:"token"`
  // Refresh_token *string            `json:"refresh_token"`
  // Created_at    time.Time          `json:"created_at"`
  // Updated_at    time.Time          `json:"updated_at"`
  // User_id       string             `json:"user_id"`
  String? firstName;
  String? lastName;
  String? email;
  String? token;
  String? phone;
  String? userId;
  User({
    this.firstName,
    this.lastName,
    this.email,
    this.token,
    this.phone,
    this.userId,
  });

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? token,
    String? phone,
    String? userId,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      token: token ?? this.token,
      phone: phone ?? this.phone,
      userId: userId ?? this.userId,
    );
  }

  User fromJson(dynamic json) {
    return User(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      token: json["token"],
      phone: json["phone"],
      userId: json["user_id"],
    );
  }

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, email: $email, token: $token, phone: $phone, userId: $userId)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.token == token &&
        other.phone == phone &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        token.hashCode ^
        phone.hashCode ^
        userId.hashCode;
  }
}
