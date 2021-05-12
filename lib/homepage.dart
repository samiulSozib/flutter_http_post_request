import 'package:flutter/material.dart';
import './user.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

Future<User> createdUser(String name, String job) async {
  final String apiUrl = "https://reqres.in/api/users";

  final response =
      await http.post(Uri.parse(apiUrl), body: {"name": name, "job": job});

  if (response.statusCode == 201) {
    final String responseString = response.body;

    return userFromJson(responseString);
  } else {
    return null;
  }
}

class _HomepageState extends State<Homepage> {
  User _user;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Http Post Request "),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: nameController,
              ),
              TextField(
                controller: jobController,
              ),
              SizedBox(
                height: 20,
              ),
              _user == null ? Container() : Text("${_user.name}"),
              RaisedButton(
                  child: Text("Add User"),
                  onPressed: () async {
                    print(nameController.text);
                    final String name = nameController.text;
                    final String job = jobController.text;
                    final User user = await createdUser(name, job);
                    setState(() {
                      _user = user;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
