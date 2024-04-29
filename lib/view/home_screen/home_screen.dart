// ignore_for_file: prefer_const_constructors

import 'package:api_with_provider/controller/home_screen_controller.dart';
import 'package:api_with_provider/view/detailed_screen/detailed_screen.dart';
import 'package:api_with_provider/view/favourite_screen/favourite_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeScreenController>().getCatData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderObj = context.watch<HomeScreenController>();
    return DefaultTabController(
      length: homeProviderObj.categories.length,
      child: Scaffold(
        backgroundColor: Color(0xfffff2c5),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavouriteScreen()));
                },
                icon: Icon(Icons.favorite_border, color: Colors.white))
          ],
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/704767/pexels-photo-704767.jpeg?auto=compress&cs=tinysrgb&w=600"),
            ),
          ),
          title: Text(
            "News",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Colors.black,
          bottom: TabBar(
              indicatorSize: null,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.white60),
              onTap: (value) {
                context.read<HomeScreenController>().onCategorySelection(value);
              },
              isScrollable: true,
              tabs: List.generate(
                  homeProviderObj.categories.length,
                  (index) => Text(
                        homeProviderObj.categories[index].toUpperCase(),
                      ))),
        ),
        body: homeProviderObj.isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: homeProviderObj.newsApiCatResModel?.articles?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailedScreen(
                              index: index,
                              article: homeProviderObj
                                  .newsApiCatResModel?.articles?[index],
                            ),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          homeProviderObj.newsApiCatResModel?.articles?[index]
                                          .urlToImage ==
                                      null ||
                                  homeProviderObj.newsApiCatResModel
                                          ?.articles?[index].urlToImage ==
                                      ""
                              ? SizedBox()
                              : Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  height: 200,
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: homeProviderObj.newsApiCatResModel
                                            ?.articles?[index].urlToImage ??
                                        "",
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  // Image.network(
                                  //     homeProviderObj.newsApiCatResModel
                                  //             ?.articles?[index].urlToImage ??
                                  //         "",
                                  //     fit: BoxFit.cover),
                                ),
                          Text(
                            homeProviderObj.newsApiCatResModel?.articles?[index]
                                    .title ??
                                "",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            homeProviderObj.newsApiCatResModel?.articles?[index]
                                    .description ??
                                "",
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
