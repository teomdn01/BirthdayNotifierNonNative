import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:moto_suchen/domain/exceptions/offline_exception.dart';
import 'package:moto_suchen/domain/model/friend_listing.dart';

import '../../domain/repository/friend_repository.dart';
part 'friend_listings_state.dart';
part 'friend_listings_event.dart';

class FriendListingsBloc
    extends Bloc<FriendListingsEvent, FriendListingsState> {
  final FriendRepository _friendRepository =
      GetIt.instance.get<FriendRepository>();

  FriendListingsBloc() : super(const FriendListingsInitial());
  @override
  Stream<FriendListingsState> mapEventToState(
      FriendListingsEvent event) async* {
    if (event is getFriendListings) {
      yield const FriendListingsLoading();
      final List<FriendListing> listings =
          await _friendRepository.fetchFriends();
      yield FriendListingsLoaded(listings);
    }

    if (event is deleteFriendListing) {
      yield const FriendListingsLoading();
      try {
        await _friendRepository.deleteListing(event.phoneNumber);
        final List<FriendListing> listings =
            await _friendRepository.fetchFriends();
        yield FriendListingsLoaded(listings);
      } on OfflineException {
        yield const FriendOfflineDelete();
      }
    }
  }
}
