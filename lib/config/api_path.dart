enum APIPath {
  fetch_ads,
  add_ads,
  remove_ads,
  fetch_question,
  add_question,
  remove_question,
  fetch_reply,
  add_reply,
  remove_reply,
  register,
  login,
  logout,
  add_ad_like,
  add_que_like,
  remove_ad_like,
  remove_que_like,
  my_like,
  fetch_like,
  que_like,
  update,
  get_user,
  get_image,
  indexx,


}

class APIPathHelper{
  static String getValue(APIPath path){
    switch(path){
      case APIPath.fetch_ads:
        return "/ads";
      case APIPath.add_ads:
        return "/ad";
      case APIPath.remove_ads:
        return "/adremove";
      case APIPath.fetch_question:
        return "/question";
      case APIPath.add_question:
        return "/qstore";
      case APIPath.remove_question:
        return "/qremove";
      case APIPath.fetch_reply:
        return "/reply";
      case APIPath.add_reply:
        return "/rstore";
      case APIPath.remove_reply:
        return "/rremove";
      case APIPath.register:
        return "/register";
      case APIPath.login:
        return "/login";
      case APIPath.logout:
        return "/logout";
      case APIPath.update:
        return "/update";
      case APIPath.add_ad_like:
        return "/adlike";
      case APIPath.add_que_like:
        return "/quelike";
      case APIPath.remove_ad_like:
        return "/adlremove";
      case APIPath.remove_que_like:
        return "/qlremove";
      case APIPath.my_like:
        return "/mylike";
      case APIPath.fetch_like:
        return "/qlike";
      case APIPath.que_like:
        return "/quelikes";
      case APIPath.get_user:
        return "/getuser";
      case APIPath.get_image:
        return "/download";
      case APIPath.indexx:
        return "/indexx";
      default:
        return "";
    }
  }
}

