
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../models/rondom_user_list_res.dart';
import '../services/http_service.dart';

class HomeViewModel extends ChangeNotifier{
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
  List<RandomUser> userList = [];
  int currentPage = 1;

  initScrollerListener(){
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <=
          scrollController.offset) {
        loadRandomUserList();
      }
    });
      }

      loadRandomUserList() async {
        isLoading = true;
        notifyListeners();

        var response = await Network.GET(Network.API_RANDOM_USER_LIST,
            Network.paramsRandomUserList(currentPage));
        var randomUserListRes = Network.parseRandomUserList(response!);
        currentPage = randomUserListRes.info.page + 1;


        userList.addAll(randomUserListRes.results);
        isLoading = false;
        notifyListeners();
      }

    }