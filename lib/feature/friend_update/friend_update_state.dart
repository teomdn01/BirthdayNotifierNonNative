part of 'friend_modify_bloc.dart';


abstract class FriendUpdateState {
  const FriendUpdateState();
}

class FriendUpdate extends FriendUpdateState {
  final FriendListing friendListing;
  const FriendUpdate(this.friendListing);
}

class FriendUpdating extends FriendUpdateState {
  const FriendUpdating();
}
