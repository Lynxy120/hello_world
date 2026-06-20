import "package:shared_preferences/shared_preferences.dart";

class SessionManager {
  static Future<void> saveUserSession(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_success', true);
    await prefs.setString('username', userData['username']);
    await prefs.setString('email', userData['email']);
    await prefs.setString('id', userData['id']);
    await prefs.setString('level', userData['level']);
    await prefs.setString('tgl_daftar', userData['tgl_daftar']);
  }

  static Future<Map<String, String?>> getUserSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return{
      'is_success': prefs.getBool('is_success')?.toString(),
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
      'id': prefs.getString('id'),
      'level': prefs.getString('level'),
      'tgl_daftar': prefs.getString('tgl_daftar'),
    };
  }

  static Future<bool> isLogin() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_success') ?? false;
  }

  static Future<bool> isAdmin() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('level') == 'admin';
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('is_success');
    await prefs.clear();
  }
}