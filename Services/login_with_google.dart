import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
  static final _googleSignIn= GoogleSignIn();
  static Future login()=>_googleSignIn.signIn();
}

Future signIn() async{
  await GoogleSignInApi.login();
}


/* Ive included the same class in the login page as well so if any changes required make it there not here,
 there is some issue with importing here. */