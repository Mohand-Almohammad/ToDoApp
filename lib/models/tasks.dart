class Task{
  String _email ;
  String _password ;
  String _cPassword ;
  String _token ;

Task( this._email, this._password, this._cPassword, this._token);

 Task.fromJson(Map<String, dynamic> map){
   
   this._email     = map["email"];
   this._password  = map["password"];
   this._cPassword = map["c_password"];
   this._token     = map["token"];
 }

 
 String get email     => _email;
 String get password  => _password;
 String get cPassword => _cPassword;
 String get name      => _token;

 
 set setEmail(String email)         => _email = email;
 set setPassword(String password)   => _password = password;
 set setCPassword(String cPassword) => _cPassword = cPassword;
 set setName(String name)           => _token = name;

}