part of 'friend_listings_bloc.dart';

abstract class FriendListingsState {
  const FriendListingsState();
}

class FriendListingsInitial extends FriendListingsState {
  const FriendListingsInitial();
}

class FriendListingsLoading extends FriendListingsState {
  const FriendListingsLoading();
}

class FriendListingsLoaded extends FriendListingsState {
  final List<FriendListing> friendListings;
  const FriendListingsLoaded(this.friendListings);
}

class FriendOfflineDelete extends FriendListingsState {
  const FriendOfflineDelete();
}
