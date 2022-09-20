class User {
  //User(this.id, this.email, this.name, this.idDevice, this.token);
  int id = 0;
  String email = "";
  String name = "";
  String idDevice = "";
  String token  = "";

  User._privateConstructor();

  static final User _instance = User._privateConstructor();

  static User get instance => _instance;

}
