import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:moto_suchen/feature/friend_add/friend_add_screen.dart';
import 'package:moto_suchen/feature/friend_listings/friend_listings_bloc.dart';
import 'package:moto_suchen/feature/friend_update/friend_update_screen.dart';

class FriendListingsScreen extends StatelessWidget {
  const FriendListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => GetIt.instance.get<FriendListingsBloc>( ),
          child: BlocBuilder<FriendListingsBloc, FriendListingsState>(
          builder: (blocContext, state) {
            if (state is FriendListingsInitial){
              blocContext.read<FriendListingsBloc>().add(getFriendListings());
              return const CircularProgressIndicator();
            } else if (state is FriendListingsLoading){
                return const CircularProgressIndicator();
            } else if (state is FriendListingsLoaded) {
              return
                LayoutBuilder(builder: (ctx, constraints){
               return
               Scaffold(
                floatingActionButton: FloatingActionButton(
                child: const Text("Add new"),
                onPressed: () => Navigator.push(context, 
                                  MaterialPageRoute(builder: (context) => const FriendAddScreen()))
                                  .then((_)=>
                                        blocContext.read<FriendListingsBloc>().add(getFriendListings())),
                ) ,
                body: Container(
                  width:  constraints.maxWidth, 
                  height: constraints.maxHeight,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),               
                  child: 
                    Expanded(
                    child: ListView.builder(
                      itemCount: state.friendListings.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(child:
                         Row(
                          children: [
                            //Container(height: 150, width: constraints.maxWidth * 0.4, child: Column(children: [state.friendListings[index].photoUrl != null ? Image.network(state.friendListings[index].photoUrl!) : const Text("No image")])),
                            SizedBox(width: constraints.maxWidth * 0.1,height: 150),
                            Container( height: 150,
                            width: constraints.maxWidth * 0.4,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(children: [Text(state.friendListings[index].phoneNumber,overflow: TextOverflow.ellipsis)]),
                                Row(children: [Text(state.friendListings[index].firstName,overflow: TextOverflow.ellipsis)]),
                                Row(children: [Text(state.friendListings[index].lastName,overflow: TextOverflow.ellipsis)]),
                                Row(children: [Text(state.friendListings[index].nickname,overflow: TextOverflow.ellipsis)]),
                                Row(children: [Text(state.friendListings[index].birthday,overflow: TextOverflow.ellipsis)]),
                                Row(children: [Text(state.friendListings[index].message,overflow: TextOverflow.ellipsis)]),
                            ],))
                          ],
                        ), 
                        onTap: () => {
                            Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => FriendUpdateScreen(state.friendListings[index])))
                          .then((_)=>
                                blocContext.read<FriendListingsBloc>().add(getFriendListings()))
                        }, 
                        onDoubleTap: () => {
                          showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            title:  const Text('Warning!'),
                            content:  const Text('Are you sure you want to delete this record?'),
                            actions: [
                              TextButton(
                                child: const Text('Confirm'),
                                onPressed: () {
                                  blocContext.read<FriendListingsBloc>().add(deleteFriendListing(state.friendListings[index].phoneNumber));
                                  blocContext.read<FriendListingsBloc>().add(getFriendListings());
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );

                        })
                        });
                      }))
              ));
            });

          }
          return const CircularProgressIndicator();
          }
        )
      )
    );
  }
}