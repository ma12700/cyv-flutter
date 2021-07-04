import 'package:cyv/models/style.dart';
import 'package:cyv/views/screens/candidates_screen.dart';
import 'package:cyv/views/screens/home_screen.dart';
import 'package:cyv/views/screens/page_content_screen.dart';
import 'package:cyv/views/screens/candidate_profile_screen.dart';
import 'package:cyv/views/widgets/candidature.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './views/screens/splash_screen.dart';
import './providers/auth.dart';
import 'views/screens/face_login_screen.dart';
import './views/screens/login_screen.dart';
// import './screen/candidatepr.dart';
import 'views/widgets/write_Program_screen.dart';
// import './widget/fform.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<bool> delay() async {
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Auth(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cast Your Vote',
          theme: ThemeData(
              fontFamily: 'SourceSansPro', primaryColor: Style.primaryColor),
          home: FutureBuilder(
            future: delay(),
            builder: (ctx, authResultSnapshot) =>
                authResultSnapshot.connectionState == ConnectionState.waiting
                    ? SplashScreen()
                    : LoginScreen(),
          ),
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(),
            FaceRecognitionScreen.routeName: (ctx) => FaceRecognitionScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            PageContentScreen.routeName: (ctx) => PageContentScreen(),
            CandidatesScreen.routeName: (ctx) => CandidatesScreen(),
            CandidateProfileScreen.routeName: (ctx) => CandidateProfileScreen(),
            CandidatureForm.routeName: (ctx) => CandidatureForm(),
          },
        ),
      ),
    );
  }
}
