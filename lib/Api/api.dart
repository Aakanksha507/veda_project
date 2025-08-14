import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myflutterapp/Api/api_client.dart';
import 'package:myflutterapp/AppColor/app_color.dart';
import 'package:myflutterapp/features/homepage/screen_widgets/app_bar_widget.dart';
import 'package:myflutterapp/l10n/app_localizations.dart';

class ApiDioPractice extends StatefulWidget {
  const ApiDioPractice({super.key});

  @override
  State<ApiDioPractice> createState() => _ApiState();
}

class _ApiState extends State<ApiDioPractice> {
  late final ApiClient apiClient;
  List<dynamic> bbcNews = [];
  List<dynamic> usNews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiClient = ApiClient(); // initialize api client once...
    fetchPosts();
  }

  @override
  void dispose() {
    super.dispose();
    apiClient.cancelToken.cancel('Disposed');
  }

  //fetch data
  // void fetchPosts() async {
  //   try {
  //     var response = await Dio().get(
  //       'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=c1388405f46a4cddad56cc380a96fd65',
  //     );
  //     setState(() {
  //       bbcNews = response.data['articles'];
  //     });
  //   } catch (e) {
  //     print('Error: $e');
  //   }

  // }

  // Performing multiple concurrent request
  Future fetchPosts() async {
    try {
      final result = await Future.wait([
        apiClient.getRequest(
          '/top-headlines?',
          queryParameters: {'sources': 'bbc-news'},
        ),
        apiClient.getRequest(
          'top-headlines?',
          queryParameters: {'country': 'us'},
        ),
      ]);

      setState(() {
        bbcNews = result[0]['articles'];
        usNews = result[1]['articles'];
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  //post data
  void addPosts() async {
    try {
      var response = await Dio().post(
        'https://jsonplaceholder.typicode.com/posts',
        data: {'title': 'NewPosts', 'body': 'this is a description'},
      );
      print('Post response: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }

  //put data
  void putPosts() async {
    try {
      var response = await Dio().put(
        'https://jsonplaceholder.typicode.com/posts/1',
        data: {'title': 'EditPosts', 'body': 'this is a edit description'},
      );
      print('Post response: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }

  void deletePosts() async {
    try {
      var response = await Dio().delete(
        'https://jsonplaceholder.typicode.com/posts/1',
      );
      print('DELETE status code: ${response.statusCode}');
    } catch (e) {
      print('DELETE Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: AppBarWidget(mainTxt: loc.news, txtColor: Colors.white),
          bottom:TabBar(
            tabs: [
              Tab(text: 'BBC News',),
              Tab(text: 'US News'),
            ],
            labelStyle: TextStyle(
              fontSize: 16,
              color: AppColor.neutral6,
              fontWeight:FontWeight.w500
            ),
            unselectedLabelStyle: TextStyle(
               fontSize: 16,
              color: AppColor.neutral6,
              fontWeight:FontWeight.w500
            ),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  NewsList(news: bbcNews),
                  NewsList(news: usNews),
                ],
              ),
      ),
    );
  }
}


class NewsList extends StatelessWidget {
  final List<dynamic> news;

  const NewsList({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    if (news.isEmpty) {
      return const Center(child: Text("No articles found."));
    }

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        final post = news[index];
        return Card(
          margin: EdgeInsets.all(8.w),
          child: ListTile(
            leading: CachedNetworkImage(
              imageUrl: post['urlToImage'] ?? '',
              width: 80,
              height: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            title: Text(
              post['title'] ?? 'No Title',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            subtitle: Text(
              post['description'] ?? 'No Description',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        );
      },
    );
  }
}
      
//       body:
//           isLoading
//               ? Center(child: CircularProgressIndicator())
//               : TabBarView(children: [
//                 Expanded(
//                     child: ListView.builder(
//                       itemCount: usNews.length,
//                       itemBuilder: (context, index) {
//                         final post = usNews[index];
//                         // print('Image URL for post $index: ${post['urlToImage']}');

//                         return Card(
//                           margin: EdgeInsets.all(8.w),

//                           child: ListTile(
//                             leading: CachedNetworkImage(
//                               imageUrl: post['urlToImage'] ?? '',
//                               width: 80,
//                               height: 100,
//                               fit: BoxFit.cover,
//                               repeat: ImageRepeat.noRepeat,
//                               placeholder:
//                                   (context, url) => CircularProgressIndicator(),
//                               errorWidget:
//                                   (context, url, error) => Icon(
//                                     Icons.error,
//                                     color: Theme.of(context).colorScheme.error,
//                                   ),
//                             ),

//                             title: Text(
//                               post['title'] ?? 'No Title',
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color:
//                                     Theme.of(context).colorScheme.onSecondary,
//                               ),
//                             ),
//                             subtitle: Text(
//                               post['description'] ?? 'No Description',
//                               style: TextStyle(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w400,
//                                 color:
//                                     Theme.of(context).colorScheme.onSecondary,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: bbcNews.length,
//                       itemBuilder: (context, index) {
//                         final post = bbcNews[index];
//                         // print('Image URL for post $index: ${post['urlToImage']}');

//                         return Card(
//                           margin: EdgeInsets.all(8.w),

//                           child: ListTile(
//                             leading: CachedNetworkImage(
//                               imageUrl: post['urlToImage'] ?? '',
//                               width: 80,
//                               height: 100,
//                               fit: BoxFit.cover,
//                               repeat: ImageRepeat.noRepeat,
//                               placeholder:
//                                   (context, url) => CircularProgressIndicator(),
//                               errorWidget:
//                                   (context, url, error) => Icon(Icons.error),
//                             ),

//                             title: Text(
//                               post['title'] ?? 'No Title',
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w600,
//                                 color:
//                                     Theme.of(context).colorScheme.onSecondary,
//                               ),
//                             ),
//                             subtitle: Text(
//                               post['description'] ?? 'No Description',
//                               style: TextStyle(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w400,
//                                 color:
//                                     Theme.of(context).colorScheme.onSecondary,
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//               ]),
            
//     );
//   }
// }
