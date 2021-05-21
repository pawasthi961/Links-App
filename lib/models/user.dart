class SignedInUser {
  final String uid;
  SignedInUser({this.uid});
}

class UserData {
  final String firstName;
  final String lastName;
  final String email;
  final int profileAvatarColor;
  final String userId;
  UserData(
      {this.userId,
      this.profileAvatarColor,
      this.lastName,
      this.firstName,
      this.email});
}
