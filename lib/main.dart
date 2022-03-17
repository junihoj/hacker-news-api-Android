import './blocs/stories_provider.dart';
import './screens/news_list.dart';
import 'package:flutter/material.dart';
import './screens/news_detail.dart';
import 'blocs/comments_provider.dart';

void main() => (runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name.replaceFirst('/', ''));

          commentsBloc.fetchItemWithComments(itemId);
          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
  }
}

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // void sendApi() async {
//   //   print('Starting Api call');
//   //   var response =
//   //       await get('https://hacker-news.firebaseio.com/v0/topstories.json');
//   //   print('Call received');
//   //   print(jsonDecode(response.body));
//   // }

//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   sendApi();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return return StoriesProvider(
//       child: MaterialApp(
//         initialRoute: '/',
//         routes: {
//           '/': (context) => HomeScreen(),
//         },
//       ),
//     );
//   }
// }
