import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FlutterMetSampleFirebaseUser {
  FlutterMetSampleFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

FlutterMetSampleFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FlutterMetSampleFirebaseUser> flutterMetSampleFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FlutterMetSampleFirebaseUser>(
            (user) => currentUser = FlutterMetSampleFirebaseUser(user));
