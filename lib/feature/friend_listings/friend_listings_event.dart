part of 'friend_listings_bloc.dart';

@immutable
abstract class FriendListingsEvent {}

class getFriendListings extends FriendListingsEvent {
  getFriendListings();
}

class deleteFriendListing extends FriendListingsEvent {
  final String phoneNumber;
  deleteFriendListing(this.phoneNumber);
}



