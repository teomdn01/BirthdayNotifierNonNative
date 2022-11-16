part of 'friend_modify_bloc.dart';


abstract class FriendUpdateEvent{}

class FriendUpdatePhoneNumber extends FriendUpdateEvent{
  final String phoneNumber;
  FriendUpdatePhoneNumber(this.phoneNumber);
}

class FriendUpdateFirstName extends FriendUpdateEvent{
  final String firstName;
  FriendUpdateFirstName(this.firstName);
}
class FriendUpdateLastName extends FriendUpdateEvent{
  final String lastName;
  FriendUpdateLastName(this.lastName);
}

class FriendUpdateNickname extends FriendUpdateEvent{
  final String nickname;
  FriendUpdateNickname(this.nickname);
}

class FriendUpdateBirthday extends FriendUpdateEvent{
  final String birthday;
  FriendUpdateBirthday(this.birthday);
}


class FriendUpdateMessage extends FriendUpdateEvent{
  final String message;
  FriendUpdateMessage(this.message);
}

class FriendUpdateSubmit extends FriendUpdateEvent{
   FriendUpdateSubmit();
}

class FriendAddSubmit extends FriendUpdateEvent{
   FriendAddSubmit();
}