class EditProfileParams {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;

  const EditProfileParams({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
    };
  }
}
