import 'package:flutter/material.dart';
import 'package:roomie/provider/providers.dart';
import 'package:roomie/config/configs.dart';
import 'package:roomie/model/models.dart';

class AdsDetailsProvider with ChangeNotifier {
  AdsRepository _adsRepository;

  ApiResponse<List<Ads>> _ad;

  ApiResponse<List<Ads>> get ads=> _ad;

  AdsDetailsProvider() {
    _adsRepository = AdsRepository();
    fetchAdsDetails();
  }

  fetchAdsDetails() async {
    print('provider1');
    _ad = ApiResponse.loading('loading... ');
    notifyListeners();
    try {
      print("try ad provider");
      List<Ads> ad = await _adsRepository.fetchAdsDetails();
      print("addddd----------------$ad");
      _ad = ApiResponse.completed(ad);
      notifyListeners();
    } catch (e) {
      _ad = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

}