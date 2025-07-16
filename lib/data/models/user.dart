class User {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String profileImage;

  User({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImage,
  });
}

List<User> registeredUsers = [
  User(
    username: "cerkezbilal",
    password: "123456",
    firstName: "Bilal",
    lastName: "Karademir",
    phoneNumber: "05432716559",
    profileImage: "assets/images/profile_images/bilal_karademir.jpeg",
  ),
];

User? authenticateUser(String username, String password) {
  try {
    return registeredUsers.firstWhere(
      (user) => user.username == username && user.password == password,
    );
  } catch (e) {
    return null;
  }
}

void registerUser(User user) {
  registeredUsers.add(user);
}
