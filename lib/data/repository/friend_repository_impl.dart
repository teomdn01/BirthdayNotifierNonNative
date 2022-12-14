import 'package:moto_suchen/domain/model/friend_listing.dart';
import 'package:moto_suchen/domain/repository/friend_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class FriendRepositoryImpl implements FriendRepository{

  // var friends = <FriendListing>[
  //         FriendListing("+40 740 152 590", "Ioana", "Moldovan", "Yoyo", "22.03.1999", "Happy birthday englezeste, la multi ani pe romaneste!"),
  //         FriendListing("+40 741 152 590", "Teodor", "Moldovan", "C#", "22.03.2001", "Happy birthday englezeste, la multi ani pe romaneste!"),
  //         FriendListing("+40 742 152 590", "Remus", "Moldovan", "Grasu", "22.03.1980", "Happy birthday englezeste, la multi ani pe romaneste!")

  //       ];
  final Database _db;

  static Future<FriendRepositoryImpl> createFriendRepository() async {
    Database db = await FriendRepositoryImpl.getDatabase();
    return FriendRepositoryImpl(db);
  }

  FriendRepositoryImpl(this._db);

  static Future<Database> getDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'friend.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Friends(phoneNumber TEXT PRIMARY KEY, firstName TEXT, lastName TEXT, nickname TEXT, birthday TEXT, message TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<List<FriendListing>> fetchFriends() async {
    // return Future.delayed(const Duration(seconds: 1), 
    // (){
    //     return friends;
    
    // });
    final List<Map<String, dynamic>> maps = await _db.query('friends');
    return List.generate(maps.length, (i) {
    return FriendListing(maps[i]['phoneNumber'], maps[i]['firstName'],maps[i]['lastName'],maps[i]['nickname'],
      maps[i]['birthday'], maps[i]['message']
    );
  });
  }
  
  @override
  Future deleteListing(String phoneNumber) async {
    //  return Future.delayed(const Duration(seconds: 1), 
    // (){
    //     friends.removeWhere((element) => element.phoneNumber == phoneNumber);
    
    // });
     await _db.delete('friends', where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
  }
  
  @override
  Future<FriendListing> updateListing(FriendListing listing) async {
    // return Future.delayed(const Duration(milliseconds: 500), 
    // (){
    //     friends[friends.indexWhere((element) => element.phoneNumber == listing.phoneNumber)] = listing;
    //     return friends.where((element) => element.phoneNumber == listing.phoneNumber).first;
    
    // });

      await _db.update(
      'friends',
      listing.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'phoneNumber = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [listing.phoneNumber],
   );

    final List<Map<String, dynamic>> updated = await _db.query('friends', where: "phoneNumber = ?", whereArgs: [listing.phoneNumber], limit: 1);
    return FriendListing(updated.first['phoneNumber'], updated.first['firstName'],
      updated.first['lastName'],updated.first['nickname'],
      updated.first['birthday'], updated.first['message']
    ); 
  }
  
  @override
  Future<FriendListing> addListing(FriendListing listing) async {
    // return Future.delayed(const Duration(milliseconds: 500), 
    // (){
    //     FriendListing last = friends.last;
    //     listing = FriendListing(listing.phoneNumber, listing.firstName, listing.lastName, listing.nickname, listing.birthday, listing.message);
    //     friends.add(listing);
    //     return listing;
    // });

   // FriendListing last = motorcycles.last;
    listing = FriendListing(listing.phoneNumber, listing.firstName, listing.lastName, listing.nickname, listing.birthday, listing.message);
    await _db.insert('friends', listing.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return listing;
  }
  
}