import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

abstract class FirebaseInitWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return getInitErrorWidget();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {

          Crashlytics.instance.enableInDevMode = true;

          // Pass all uncaught errors to Crashlytics.
          FlutterError.onError = Crashlytics.instance.recordFlutterError;

          return getApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return getLoadingWidget();
      },
    );
  }

  Widget getInitErrorWidget();

  Widget getApp();

  Widget getLoadingWidget();
}
