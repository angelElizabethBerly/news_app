// ignore_for_file: prefer_const_constructors

import 'package:api_with_provider/controller/favourite_screen_controller.dart';
import 'package:api_with_provider/controller/home_screen_controller.dart';
import 'package:api_with_provider/view/detailed_screen/detailed_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfffff2c5),
        appBar: AppBar(
          title: Text("Favourites"),
          backgroundColor: Color(0xfffff2c5),
        ),
        body: Consumer<FavouriteScreenController>(
          builder: (context, favouriteScreenState, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                  itemCount: favouriteScreenState.favouriteList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailedScreen(
                                      article: favouriteScreenState
                                          .favouriteList[index].article),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 2),
                                      blurRadius: 6)
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                    height: 100,
                                    width: 100,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: favouriteScreenState
                                              .favouriteList[index]
                                              .article
                                              .urlToImage ??
                                          "",
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        favouriteScreenState
                                                .favouriteList[index]
                                                .article
                                                .title ??
                                            "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(
                                        favouriteScreenState
                                                .favouriteList[index]
                                                .article
                                                .author ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<FavouriteScreenController>()
                                              .deleteFromFavourite(index);
                                        },
                                        icon: Icon(Icons.delete)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
            );
          },
        ));
  }
}
