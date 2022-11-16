import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moto_suchen/feature/friend_update/friend_update_bloc.dart';

import '../../domain/model/friend_listing.dart';
import 'friend_modify_bloc.dart';
import '../widgets/friend_modify_form.dart';

class FriendUpdateScreen extends StatelessWidget {
  final FriendListing initialValue;
  const FriendUpdateScreen(this.initialValue, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Edit listing"),
        ),
      body: BlocProvider(
          create: (context) => GetIt.instance.get<FriendUpdateBloc>(param1: initialValue),
          child: BlocBuilder<FriendUpdateBloc, FriendUpdateState>(
          builder: (blocContext, state) {
             if (state is FriendUpdating){
              
                return const CircularProgressIndicator();
            } 
            else if (state is FriendUpdate){
              return
                ModifyFriendForm(blocContext.read<FriendUpdateBloc>(), state, FriendUpdateSubmit());
            }
            return const CircularProgressIndicator();
          }
          )
      ));
  }
}

