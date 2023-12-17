import 'package:crudapiproject/screens/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: ((context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text("Home View"),
            ),
            body: FutureBuilder(
                future: viewModel.getUnicorn(),
                builder: ((BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                      itemCount: viewModel.unicorns.length,
                      itemBuilder: ((context, index) {
                        final unicorn = viewModel.unicorns[index];
                        return ListTile(
                          title: Text(unicorn.name!),
                          leading: IconButton(
                              onPressed: () async {
                                await viewModel.deletUnicorn(
                                    id: unicorn.sId!.toString());
                              },
                              icon: Icon(Icons.delete)),
                        );
                      }));
                })),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await viewModel.dialogBuilder(context);
              },
              child: Text(
                "Add User",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }));
  }
}
