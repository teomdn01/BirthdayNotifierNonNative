class FriendListing {
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String nickname;
  final String birthday;
  final String message;

  FriendListing(
      {required this.phoneNumber,
      required this.firstName,
      required this.lastName,
      required this.nickname,
      required this.birthday,
      required this.message});

  FriendListing.overloadedConstructor(this.phoneNumber, this.firstName,
      this.lastName, this.nickname, this.birthday, this.message);

  Map<String, dynamic> toMap() {
    return {
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'nickname': nickname,
      'birthday': birthday,
      'message': message
    };
  }

  factory FriendListing.fromJson(Map<String, dynamic> json) {
    return FriendListing(
      phoneNumber: json['phoneNumber'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      nickname: json['nickname'],
      birthday: json['birthday'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "phoneNumber": this.phoneNumber,
      "firstName": this.firstName,
      "lastName": this.lastName,
      "nickname": this.nickname,
      "birthday": this.birthday,
      "message": this.message
    };
  }
}
