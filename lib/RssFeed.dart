import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  RssFeed? _feed;

  @override

  void initState() {
    super.initState();
    fetchToINews();
  }

  Future<void> fetchToINews() async {
    final response = await http.get(Uri.parse('http://timesofindia.indiatimes.com/rssfeedstopstories.cms'));
    if (response.statusCode == 200) {
      final feed = RssFeed.parse(response.body);
      setState(() {
        _feed = feed;
      });
    } else {
      throw Exception('Failed to load RSS feed');
    }
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon:const Icon(Icons.arrow_back_ios,size:15)),
          title:const Text('RSS Feed: World News'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _buildNewsList(),
        ),
      );
  }
  Widget _buildNewsList() {
    if (_feed == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: _feed!.items?.length,
        itemBuilder: (context, index) {
          final item = _feed!.items?[index];
          final pubDate = item?.pubDate;
          final formattedPubDate = pubDate != null
              ? DateFormat('MMM dd, yyyy HH:mm').format(pubDate)
              : 'Date not available';

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 233, 233, 233),
                  borderRadius: BorderRadius.circular(10.0), 
                ),
                child: Column(
                  children: [
                    const SizedBox(height:10),
                    ListTile(
                      title: Text(item?.title ?? '',style: GoogleFonts.lora(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),),
                      subtitle: Text(formattedPubDate),
                      onTap: () => openFeedInChrome(item?.link ?? ''),
                    ),
                  ],
                ),
              ),
              const SizedBox(height:10),
            ],
          );
        },
      );
    }
  }
  Future<void> openFeedInChrome(String url) async {
    try {
      await launchUrl(
        Uri.parse(url),
      );
    } catch (e) {
      print('Failed to launch Chrome: $e');
    }
  }
}