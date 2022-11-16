import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moto_suchen/feature/friend_add/friend_add_bloc.dart';

import '../friend_update/friend_modify_bloc.dart';
import '../widgets/friend_modify_form.dart';

class FriendAddScreen extends StatelessWidget {
  const FriendAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Edit listing"),
        ),
      body: BlocProvider(
          create: (context) => GetIt.instance.get<FriendAddBloc>(),
          child: BlocBuilder<FriendAddBloc, FriendUpdateState>(
          builder: (blocContext, state) {
             if (state is FriendUpdating){
              
                return const CircularProgressIndicator();
            } 
            else if (state is FriendUpdate){
              return
                ModifyFriendForm(blocContext.read<FriendAddBloc>(), state, FriendAddSubmit());
            }
            return const CircularProgressIndicator();
          }
          )
      ));
  }
}

