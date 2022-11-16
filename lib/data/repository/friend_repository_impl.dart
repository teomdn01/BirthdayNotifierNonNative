import 'package:moto_suchen/domain/model/friend_listing.dart';
import 'package:moto_suchen/domain/repository/friend_repository.dart';

class FriendRepositoryImpl implements FriendRepository{

  var friends = <FriendListing>[
          FriendListing("+40 740 152 590", "Ioana", "Moldovan", "Yoyo", "22.03.1999", "Happy birthday englezeste, la multi ani pe romaneste!"),
          FriendListing("+40 741 152 590", "Teodor", "Moldovan", "C#", "22.03.2001", "Happy birthday englezeste, la multi ani pe romaneste!"),
          FriendListing("+40 742 152 590", "Remus", "Moldovan", "Grasu", "22.03.1980", "Happy birthday englezeste, la multi ani pe romaneste!")

        ];
  @override
  Future<List<FriendListing>> fetchFriends() {
    return Future.delayed(const Duration(seconds: 1), 
    (){
        return friends;
    
    });
  }
  
  @override
  Future deleteListing(String phoneNumber) {
     return Future.delayed(const Duration(seconds: 1), 
    (){
        friends.removeWhere((element) => element.phoneNumber == phoneNumber);
    
    });
  }
  
  @override
  Future<FriendListing> updateListing(FriendListing listing) {
    return Future.delayed(const Duration(milliseconds: 500), 
    (){
        friends[friends.indexWhere((element) => element.phoneNumber == listing.phoneNumber)] = listing;
        return friends.where((element) => element.phoneNumber == listing.phoneNumber).first;
    
    });
  }
  
  @override
  Future<FriendListing> addListing(FriendListing listing) {
    return Future.delayed(const Duration(milliseconds: 500), 
    (){
        FriendListing last = friends.last;
        listing = FriendListing(listing.phoneNumber, listing.firstName, listing.lastName, listing.nickname, listing.birthday, listing.message);
        friends.add(listing);
        return listing;
    });
  }
  
}