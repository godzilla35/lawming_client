class User {
  String? email = '';
  String? password = '';
  String? name = '';
  String? nick = '';
  String? phoneNum = '';
  String? officeName = '';
  String? officeNum = '';
  String? jwt = '';
  int? id = 0;

  User(
      {this.email,
      this.nick,
      this.password,
      this.jwt,
      this.name,
      this.phoneNum,
      this.officeName,
      this.officeNum,
      this.id});
}
