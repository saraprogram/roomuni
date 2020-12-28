String validate(String value , String type) {
Pattern email_pattern =
r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

Pattern password_pattern =  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp e_regex = new RegExp(email_pattern);
RegExp p_regex = new RegExp(password_pattern);

if (value.isEmpty){
  if (type == 'email'){
    return 'Email can\'t be empty';}
  else{
    return 'Password can\'t be empty';}
} else if (!e_regex.hasMatch(value)){
  return 'Enter valid email';
} else if (!p_regex.hasMatch(value)){
  return 'Enter valid password';
}
else
return null;
}


