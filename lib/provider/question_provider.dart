import 'package:flutter/material.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/config/configs.dart';

class QuestionDetailsProvider with ChangeNotifier {
  QuestionRepository _questionRepository;

  ApiResponse<List<Questions>> _question;

  ApiResponse<List<Questions>> get questions=> _question;

  QuestionDetailsProvider() {
    _questionRepository = QuestionRepository();
    fetchPostDetails();
  }

  fetchPostDetails() async {
    //print('provider1 - post');
    _question = ApiResponse.loading('loading... ');
    notifyListeners();
    try {
      List<Questions> que = await _questionRepository.fetchQuestionDetails();
      _question = ApiResponse.completed(que);
      notifyListeners();
      print(_question);
    } catch (e) {
      _question = ApiResponse.error(e.toString());
      notifyListeners();
      print(_question);
    }
  }

}