import 'package:crudapiproject/data/models/uicornsmodel.dart';
import 'package:crudapiproject/repository/unicorn_repository.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final unicornrepos = UnicornRepos();

  final namecontorller = TextEditingController();
  final agecontorller = TextEditingController();
  final citycontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<UnicornModel> unicorns = [];

  addUnicorn() async {
    UnicornModel unicornModel = UnicornModel(
        name: namecontorller.text,
        age: int.parse(agecontorller.text),
        colour: citycontroller.text);
    Map<String, dynamic> body = unicornModel.toJson();
    await unicornrepos.adddata(body);
    return unicorns.add(unicornModel);
  }

  Future getUnicorn() async {
    unicorns = await unicornrepos.getdata();
    rebuildUi();
  }

  Future updateUnicorn({required String id}) async {
    Map<String, dynamic> body = {
      "name": namecontorller,
      "age": agecontorller,
      "colour": citycontroller
    };
    await unicornrepos.adddata(body);
    await getUnicorn();
    rebuildUi();
  }

  Future deletUnicorn({required String id}) async {
    setBusy(true);
    await unicornrepos.deletePost();
    setBusy(false);
    rebuildUi();
  }

  dialogBuilder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Enter Your Details"),
                TextFormField(
                  controller: namecontorller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter Your Name"),
                ),
                TextFormField(
                  controller: agecontorller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Age";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter Your Age"),
                ),
                TextFormField(
                  controller: citycontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your City Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: "Enter Your City Name"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await addUnicorn();
                  }
                },
                child: Text("Add"))
          ],
        );
      },
    );
  }
}
