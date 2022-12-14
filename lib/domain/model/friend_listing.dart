class FriendListing {
    final String phoneNumber;
    final String firstName;
    final String lastName;
    final String nickname;
    final String birthday;
    final String message;

    FriendListing(this.phoneNumber, this.firstName, this.lastName, this.nickname,
    this.birthday, this.message);

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
}