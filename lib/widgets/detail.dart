import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String userId;
  final String friendId;

  DetailPage({required this.userId, required this.friendId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var messages = [
    {"name": "AAA", "message": "Hello", "date": "1/1/2022 3.00pm"},
    {"name": "BBB", "message": "Hello AAA", "date": "1/1/2022 3.10pm"},
    {
      "name": "AAA",
      "message": "Are you coming to class?",
      "date": "1/1/2022 3.12pm"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    var groupchatId = "";
    if (widget.userId.hashCode < widget.friendId.hashCode) {
      groupchatId = '${widget.userId}-${widget.friendId}';
    } else {
      groupchatId = '${widget.friendId}-${widget.userId}';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(groupchatId)
                  .collection(groupchatId)
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return ListView.builder(
                      itemCount: snapshots.data!.size,
                      itemBuilder: (context, position) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshots.data!.docs[position]["content"]),
                        subtitle: Text(snapshots.data!.docs[position]["idFrom"]),
                      ),
                    );
                  });
                } else {
                  return CircularProgressIndicator();
                }
              },
            )),
            Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(hintText: "Enter message"),
                )),
                TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red, primary: Colors.white),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('messages')
                          .doc(groupchatId)
                          .collection(groupchatId)
                          .doc(DateTime.now().microsecondsSinceEpoch.toString())
                          .set({
                        'idFrom': widget.userId,
                        'idTo': widget.friendId,
                        'timestamp':
                            DateTime.now().microsecondsSinceEpoch.toString(),
                        'content': messageController.text
                      }).then((value) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          messageController.text = "";
                      });

                    },
                    child: Text("Send"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
