import 'package:flutter/material.dart';
import '../friend_update/friend_modify_bloc.dart';

class ModifyFriendForm extends StatelessWidget {
  final FriendModifyBloc bloc;
  final FriendUpdate state;
  final FriendUpdateEvent saveEvent;
  const ModifyFriendForm(
    this.bloc, this.state,this.saveEvent,
    {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints){
               return Container(
      width:  constraints.maxWidth, 
      height: constraints.maxHeight,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Form(child: 
        ListView(children:
              <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'PhoneNumber',
                      ),
                      initialValue: state.friendListing.phoneNumber,
                      onChanged: (value) => bloc.add(FriendUpdatePhoneNumber(value)) ,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter!';
                        }
                        return null;
                      },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'FirstName',
                      ),
                      initialValue: state.friendListing.firstName,
                      onChanged: (value) => bloc.add(FriendUpdateFirstName(value)) ,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter!';
                        }
                        return null;
                      },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'LastName',
                      ),
                      initialValue: state.friendListing.lastName,
                      onChanged: (value) => bloc.add(FriendUpdateLastName(value)) ,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter!';
                        }
                        return null;
                      },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nickname',
                      ),
                      initialValue: state.friendListing.nickname,
                      onChanged: (value) => bloc.add(FriendUpdateNickname(value)) ,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter!';
                        }
                        return null;
                      },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Birthday',
                      ),
                      initialValue: state.friendListing.birthday,
                      onChanged: (value) => bloc.add(FriendUpdateBirthday(value)) ,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter!';
                        }
                        return null;
                      },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Message',
                      ),
                      initialValue: state.friendListing.message,
                      onChanged: (value) => bloc.add(FriendUpdateMessage(value)) ,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter!';
                        }
                        return null;
                      },
                  ),
                  ElevatedButton(onPressed: () {
                    
                    bloc.add(saveEvent);
                    Navigator.of(context).pop();
                    }, child: const Text("Save"))
              ],
        ),)
        );}
     );
  }
}