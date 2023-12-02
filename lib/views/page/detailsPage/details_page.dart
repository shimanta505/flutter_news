import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/models/news_model.dart';
import 'package:flutter_news/utils/dimensions/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsPage extends StatefulWidget {
  final NewsModel newsModel;
  const DetailsPage({super.key, required this.newsModel});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NewsModel news = widget.newsModel;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: Dimensions.height300,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Dimensions.radious20),
              bottomRight: Radius.circular(Dimensions.radious20),
            )),
            flexibleSpace: FlexibleSpaceBar(
              background: news.localDbImgDestination == null
                  ? CachedNetworkImage(
                      imageUrl: widget.newsModel.urlToImage.toString(),
                      fit: BoxFit.fill,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(Dimensions.radious20),
                                bottomRight:
                                    Radius.circular(Dimensions.radious20)),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        );
                      },
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimensions.radious20),
                            bottomRight: Radius.circular(Dimensions.radious20)),
                      ),
                      child: Image(
                          fit: BoxFit.cover,
                          image: FileImage(
                              File(news.localDbImgDestination.toString()))),
                    ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: Dimensions.height20,
              ),
              description(news.description.toString()),
              SizedBox(
                height: Dimensions.height10,
              ),
              content(news.content.toString()),
            ],
          ))
        ],
      ),
    );
  }

  Widget description(String description) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height10),
      child: Text(
        description,
        textAlign: TextAlign.start,
        softWrap: true,
        style: GoogleFonts.dmSerifDisplay(
            fontSize: Dimensions.font24,
            letterSpacing: 2,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget content(String description) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.height10),
      child: Text(
        description,
        textAlign: TextAlign.start,
        softWrap: true,
        style:
            GoogleFonts.roboto(fontSize: Dimensions.font16, letterSpacing: 1.6),
      ),
    );
  }

  String title(String title) {
    if (title.length <= 25) {
      return title;
    } else {
      return '${title.substring(0, 25)}...';
    }
  }
}
