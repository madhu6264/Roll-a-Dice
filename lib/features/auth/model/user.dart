class UserModel {
  String email = '';
  String firstName = '';
  String lastName = '';
  String userID;

  UserModel({
    this.email,
    this.userID,
    this.firstName,
    this.lastName,
  });

  String fullName() {
    return '$firstName $lastName';
  }

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return new UserModel(
      email: parsedJson['email'] ?? '',
      firstName: parsedJson['firstName'] ?? '',
      lastName: parsedJson['lastName'] ?? '',
      userID: parsedJson['userID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "userID": this.userID,
    };
  }
}
