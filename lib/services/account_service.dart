abstract class AccountService {
  Future<void> signUp(
    String fullName,
    String gender,
    String email,
    String username,
    String password,
  );

  Future<void> logIn(String username, String password);

  Future<bool> isLoggedIn();

  Future<void> logOut();
}
