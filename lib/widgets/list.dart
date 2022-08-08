import 'package:chat_app/widgets/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  final String userId;
  ListPage({required this.userId});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.requireData.docs;
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, position) {
                return documents[position]["id"] == widget.userId ? SizedBox() : Card(
                  child: ListTile(
                    title: Text(documents[position]["email"]),
                    subtitle: Text(documents[position]["id"]),
                    trailing: Icon(Icons.chevron_right),
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>DetailPage(userId: widget.userId,friendId: documents[position]["id"],)));
                    },
                  ),
                );
              });
            } else {
              return Text("There is no data at the moment");
            }
          },
        ));
  }
}
