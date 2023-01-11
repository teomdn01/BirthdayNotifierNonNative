import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/model/friend_listing.dart';
import '../../domain/repository/friend_repository.dart';
part 'friend_update_state.dart';
part 'friend_update_event.dart';

abstract class FriendModifyBloc
    extends Bloc<FriendUpdateEvent, FriendUpdateState> {
  final FriendRepository friendRepository =
      GetIt.instance.get<FriendRepository>();
  FriendListing listing;
  FriendModifyBloc(this.listing) : super(FriendUpdate(listing));
  @override
  Stream<FriendUpdateState> mapEventToState(FriendUpdateEvent event) async* {
    if (event is FriendUpdatePhoneNumber) {
      listing = FriendListing.overloadedConstructor(
          event.phoneNumber,
          listing.firstName,
          listing.lastName,
          listing.nickname,
          listing.birthday,
          listing.message);
      yield FriendUpdate(listing);
    }

    if (event is FriendUpdateFirstName) {
      listing = FriendListing.overloadedConstructor(
          listing.phoneNumber,
          event.firstName,
          listing.lastName,
          listing.nickname,
          listing.birthday,
          listing.message);
      yield FriendUpdate(listing);
    }

    if (event is FriendUpdateLastName) {
      listing = FriendListing.overloadedConstructor(
          listing.phoneNumber,
          listing.firstName,
          event.lastName,
          listing.nickname,
          listing.birthday,
          listing.message);
      yield FriendUpdate(listing);
    }

    if (event is FriendUpdateNickname) {
      listing = FriendListing.overloadedConstructor(
          listing.phoneNumber,
          listing.firstName,
          listing.lastName,
          event.nickname,
          listing.birthday,
          listing.message);
      yield FriendUpdate(listing);
    }

    if (event is FriendUpdateBirthday) {
      listing = FriendListing.overloadedConstructor(
          listing.phoneNumber,
          listing.firstName,
          listing.lastName,
          listing.nickname,
          event.birthday,
          listing.message);
      yield FriendUpdate(listing);
    }

    if (event is FriendUpdateMessage) {
      listing = FriendListing.overloadedConstructor(
          listing.phoneNumber,
          listing.firstName,
          listing.lastName,
          listing.nickname,
          listing.birthday,
          event.message);
      yield FriendUpdate(listing);
    }
  }
}
