// ignore_for_file: prefer_const_constructors

import 'package:api_with_provider/controller/favourite_screen_controller.dart';
import 'package:api_with_provider/controller/home_screen_controller.dart';
import 'package:api_with_provider/model/news_api_res_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailedScreen extends StatefulWidget {
  const DetailedScreen({super.key, this.index = 0, this.article});
  final int index;
  final Article? article;

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    final homeProviderObj = context.watch<HomeScreenController>();
    final favouriteScreenState = context.watch<FavouriteScreenController>();

    return Scaffold(
      backgroundColor: Color(0xfffff2c5),
      appBar: AppBar(
        backgroundColor: Color(0xfffff2c5),
        title: Text(
          widget.article?.source?.name ?? "",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Share.share(
                    "Hey check this latest news from my news app ${widget.article?.url ?? ""}");
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.article?.title ?? "",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.article?.author ?? "Unknown",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<FavouriteScreenController>().addToFavourite(
                        homeProviderObj
                            .newsApiCatResModel!.articles![widget.index!],
                        context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Added to Favourites")));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  child: Text(
                    "Add to Favourites",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Text(
              widget.article?.content ?? "",
              // homeProviderObj
              //       .newsApiCatResModel?.articles?[widget.index!].content ??
            ),
            SizedBox(height: 15),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 5)),
                height: 200,
                width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.article?.urlToImage ?? "",
                  // homeProviderObj.newsApiCatResModel
                  //         ?.articles?[widget.index!].urlToImage ??
                  //     "",
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )),
            SizedBox(height: 15),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await launchUrl(Uri.parse(widget.article?.url ?? ""
                          // homeProviderObj
                          //       .newsApiCatResModel
                          //       ?.articles?[widget.index!]
                          //       .url ??
                          //   ""
                          ));
                    },
                    child: Text("Read More")))
          ],
        ),
      ),
    );
  }
}
