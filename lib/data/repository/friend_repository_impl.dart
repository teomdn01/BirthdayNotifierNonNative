import 'dart:convert';

import 'package:http/http.dart';
import 'package:moto_suchen/domain/exceptions/offline_exception.dart';
import 'package:moto_suchen/domain/model/friend_listing.dart';
import 'package:moto_suchen/domain/repository/friend_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class FriendRepositoryImpl implements FriendRepository {
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
    List<FriendListing> friends = [];
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      final response =
          await http.get(Uri.parse('https://10.0.2.2:7136/api/Friend/get-all'));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Iterable list = json.decode(response.body);
        friends = List<FriendListing>.from(
            list.map((e) => FriendListing.fromJson(e)));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load list from server');
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      //no internet connection => use the local stored items

      final List<Map<String, dynamic>> maps = await _db.query('friends');
      return List.generate(maps.length, (i) {
        return FriendListing(
            phoneNumber: maps[i]['phoneNumber'],
            firstName: maps[i]['firstName'],
            lastName: maps[i]['lastName'],
            nickname: maps[i]['nickname'],
            birthday: maps[i]['birthday'],
            message: maps[i]['message']);
      });
    }

    //throw 'Error when fetching items';
    return friends;
  }

  @override
  Future deleteListing(String phoneNumber) async {
    //  return Future.delayed(const Duration(seconds: 1),
    // (){
    //     friends.removeWhere((element) => element.phoneNumber == phoneNumber);

    // });

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      var response = await http.delete(
          Uri.parse('https://10.0.2.2:7136/api/Friend/delete/$phoneNumber'));

      if (response.statusCode == 200) {
        await _db.delete('friends',
            where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
      }
    } else {
      throw OfflineException("delete");
    }
  }

  @override
  Future<FriendListing> updateListing(FriendListing listing) async {
    // return Future.delayed(const Duration(milliseconds: 500),
    // (){
    //     friends[friends.indexWhere((element) => element.phoneNumber == listing.phoneNumber)] = listing;
    //     return friends.where((element) => element.phoneNumber == listing.phoneNumber).first;

    // });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      var response = await http.put(
          Uri.parse('https://10.0.2.2:7136/api/Friend/update'),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          },
          body: jsonEncode(listing.toJson()));

      if (response.statusCode == 200) {
        await _db.update(
          'friends',
          listing.toMap(),
          // Ensure that the Dog has a matching id.
          where: 'phoneNumber = ?',
          // Pass the Dog's id as a whereArg to prevent SQL injection.
          whereArgs: [listing.phoneNumber],
        );
      }
    } else {
      throw OfflineException("update");
    }

    final List<Map<String, dynamic>> updated = await _db.query('friends',
        where: "phoneNumber = ?", whereArgs: [listing.phoneNumber], limit: 1);
    return listing;
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
    listing = FriendListing(
        phoneNumber: listing.phoneNumber,
        firstName: listing.firstName,
        lastName: listing.lastName,
        nickname: listing.nickname,
        birthday: listing.birthday,
        message: listing.message);

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response = await http.post(
          Uri.parse('https://10.0.2.2:7136/api/Friend/add'),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          },
          body: jsonEncode(listing.toJson()));
      if (response.statusCode == 200) {
        await _db.insert('friends', listing.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      await _db.insert('friends', listing.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    return listing;
  }
}
