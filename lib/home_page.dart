import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_turkiye/signin_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatelessWidget {
  final Query query = FirebaseFirestore.instance
      .collection("movies")
      .orderBy('year', descending: true);

  @override
  Widget build(BuildContext context) {
    // Eskiden Firestore'du.
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Firestore"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async => showDialog(
              context: context,
              child: _Dialog(),
            ),
          ),
          //! Builder eklemezsek Scaffold.of() hata verecektir!
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.login),
              onPressed: () async {
                final User user = _auth.currentUser; // Eskiden asenkrondu
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text("Henüz giriş yapılmamış"),
                  ));
                  return;
                }

                await _auth.signOut(); // Çıkış yapma kodu

                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("$uid başarıyla çıkış yaptı"),
                ));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: query.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Icon(Icons.error),
              );
            }
            final QuerySnapshot querySnapshot = snapshot.data;
            return ListView.builder(
              itemCount: querySnapshot.size,
              itemBuilder: (context, index) =>
                  MovieWidget(querySnapshot.docs[index]),
            );
          },
        ),
      ),
    );
  }
}

class MovieWidget extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const MovieWidget(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    print(documentSnapshot.data());
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      leading: documentSnapshot.data()['image'] == null
          ? SizedBox.shrink()
          : Image.network(documentSnapshot.data()['image']),
      title: Text(documentSnapshot.data()['title']),
      subtitle: Text("${documentSnapshot.data()['year'] ?? '-'}"),
      trailing: documentSnapshot.data()['isWatched'] == true
          ? Icon(
              Icons.check_box,
              color: Colors.green,
            )
          : SizedBox.shrink(),
      onTap: () {
        var isWatched = true;
        if (documentSnapshot.data()['isWatched'] == true) {
          isWatched = false;
        }
        documentSnapshot.reference.update({'isWatched': isWatched});
      },
    );
  }
}

class _Dialog extends StatefulWidget {
  @override
  __DialogState createState() => __DialogState();
}

class __DialogState extends State<_Dialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _yearController = TextEditingController();

  final TextEditingController _imageController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Film Adı"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Lütfen bir film adı giriniz";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: "Yıl"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Lütfen bir yıl giriniz";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(labelText: "Resim"),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Lütfen bir resim url giriniz";
                  }
                  return null;
                },
              ),
              RaisedButton(
                color: Colors.orangeAccent,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _saveMovie(context);
                  }
                },
                child: Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveMovie(BuildContext context) async {
    try {
      final String title = _titleController.text;
      final int year = int.parse(_yearController.text);
      final String image = _imageController.text;

      Map<String, dynamic> map = {
        'title': title,
        'year': year,
        'image': image,
      };

      FirebaseFirestore.instance.collection("movies").add(map);

      Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
