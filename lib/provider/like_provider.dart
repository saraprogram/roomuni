import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/provider/providers.dart';

class LikeDetailsProvider with ChangeNotifier {
  LikeRepository _LikeRepository;

  ApiResponse<List<Like>> _like;


  ApiResponse<List<Like>> get likes=> _like;

  LikeDetailsProvider() {
    _LikeRepository = LikeRepository();
    fetchLikeDetails();
  }

  fetchLikeDetails() async {
    print('provider1 - likeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    _like = ApiResponse.loading('loading... ');
    notifyListeners();
    try {
      print("ommad try like222222222222");
      List<Like> like = await _LikeRepository.fetchLikeDetails();
      print("bad az repoooooooooooo ------ $like");
      _like = ApiResponse.completed(like);
      print("kamel shod ----------- $_like");
      notifyListeners();
    } catch (e) {
      _like = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

}