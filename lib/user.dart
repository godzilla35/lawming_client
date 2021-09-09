class User {
  String? nick = "no-nick";
  String? email = "no-email";
  String? jwt = 'no-jwt';

  User({this.email, this.nick, this.jwt});

  factory User.fromMap(Map map) {
    return User(
      email: map['email'],
      nick: map['nick'],
    );
  }
}