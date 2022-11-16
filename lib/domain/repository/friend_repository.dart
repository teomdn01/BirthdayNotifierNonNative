import 'package:moto_suchen/domain/model/friend_listing.dart';

abstract class FriendRepository{
  Future<List<FriendListing>> fetchFriends();

  deleteListing(String phoneNumber) {}

  updateListing(FriendListing listing) {}

  addListing(FriendListing listing) {}
}
