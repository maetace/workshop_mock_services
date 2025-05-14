import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:workshop_0/services/account_service.dart';

class AccountServiceMock extends GetxService implements AccountService {
  final _accessTokenKey = 'access_token';

  late FlutterSecureStorage _secureStorage;

  @override
  void onInit() {
    _secureStorage = Get.find();
    super.onInit();
  }

  @override
  Future<void> signUp(
    String fullName,
    String gender,
    String email,
    String username,
    String password,
  ) async {
    // simulate api calling
    await 3.delay();
    // simulate user enter invald username
    if (username != 'demouser') {
      throw 'Invalid username';
    }
    // simulate user enter invald password
    if (password != '1q2w3e\$R') {
      throw 'Invalid password';
    }
    // simulate user sign up success
    // and get access token from api
    await _secureStorage.write(
      key: _accessTokenKey,
      value: 'demo_access_token',
    );
  }

  @override
  Future<void> logIn(String username, String password) async {
    // simulate api calling
    await 3.delay();
    // simulate user enter incorrect username or password
    if (username != 'demouser' || password != '1q2w3e\$R') {
      throw 'Incorrect username or password';
    }
    // simulate user log in success
    // and get access token from api
    await _secureStorage.write(
      key: _accessTokenKey,
      value: 'demo_access_token',
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    // simulate api calling
    await 3.delay();
    // read access token from secure storage
    var token = await _secureStorage.read(key: _accessTokenKey);
    // user is logged in when token is not null
    return token != null;
  }

  @override
  Future<void> logOut() async {
    // simulate api calling
    await 3.delay();
    // delete access token when user finish log out
    await _secureStorage.delete(key: _accessTokenKey);
  }
}
