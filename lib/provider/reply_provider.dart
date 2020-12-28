import 'package:flutter/material.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/provider/providers.dart';

class ReplyDetailsProvider with ChangeNotifier {
  ReplyRepository _replyRepository;

  ApiResponse<List<Reply>> _reply;

  ApiResponse<List<Reply>> get replies=> _reply;

  ReplyDetailsProvider() {
    _replyRepository = ReplyRepository();
    fetchReplyDetails();
  }

  fetchReplyDetails() async {
    print('provider1 - CL');
    _reply = ApiResponse.loading('loading... ');
    notifyListeners();
    try {
      List<Reply> reply = await _replyRepository.fetchReplyDetails();
      _reply = ApiResponse.completed(reply);
      notifyListeners();
    } catch (e) {
      _reply = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

}