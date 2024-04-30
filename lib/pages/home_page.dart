import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ngdemo_20/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

import '../models/rondom_user_list_res.dart';
import '../services/http_service.dart';
import '../viewes/item_of_random_user.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadRandomUserList();
    viewModel.initScrollerListener();



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Random Users - SetState"),
      ),
      body:ChangeNotifierProvider(
        create: (context)=>viewModel,
        child: Consumer<HomeViewModel>(
          builder: (context,model,index)=> Stack(
            children: [
              ListView.builder(
                controller: viewModel.scrollController,
                itemCount:viewModel. userList.length,
                itemBuilder: (ctx, index) {
                  return itemOfRandomUser(viewModel.userList[index], index);
                },
              ),

              viewModel. isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : const SizedBox.shrink(),
            ],
          ),


        ),
      )
    );
  }


}
