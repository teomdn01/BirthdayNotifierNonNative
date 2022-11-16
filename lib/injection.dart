import 'package:get_it/get_it.dart';
import 'package:moto_suchen/data/repository/friend_repository_impl.dart';
import 'package:moto_suchen/domain/repository/friend_repository.dart';
import 'package:moto_suchen/feature/friend_add/friend_add_bloc.dart';
import 'package:moto_suchen/feature/friend_listings/friend_listings_bloc.dart';

import 'domain/model/friend_listing.dart';
import 'feature/friend_update/friend_update_bloc.dart';


final getIt = GetIt.instance;

void setup() {  
  getIt.registerLazySingleton<FriendRepository>(() => FriendRepositoryImpl());
  getIt.registerLazySingleton<FriendListingsBloc>(() => FriendListingsBloc());
  getIt.registerFactoryParam<FriendUpdateBloc, FriendListing, String>((friend, s) => FriendUpdateBloc(friend));
  getIt.registerFactory<FriendAddBloc>(() => FriendAddBloc());

}