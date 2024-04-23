import 'package:expensetracker/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'simple_bloc_observer.dart';

//here generate a uuid for users and save it in local storage and load it up

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAIn5Us4gvfOcKouu29YF_Ew8MJJoQEDVA", // paste your api key here
      appId: "1:852191497282:android:f6a5f3b94264b8420871db", //paste your app id here
      messagingSenderId: "852191497282", //paste your messagingSenderId here
      projectId: "expense-tracker-13403", //paste your project id here
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());

}




