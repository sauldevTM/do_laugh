import 'dart:async';
import 'package:flutter/material.dart';
import 'package:giphy_flutter_sdk/dto/giphy_content_request.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media.dart';
import 'package:giphy_flutter_sdk/dto/giphy_media_type.dart';
import 'package:giphy_flutter_sdk/giphy_grid_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchQuery = "Do Laugh";
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        searchQuery = query;
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 16.0),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Search GIFs",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: _onSearchChanged,
          ),
        ),
        Expanded(
          child: GiphyGridView(
            key: ValueKey(searchQuery),
            content: GiphyContentRequest(
              mediaType: GiphyMediaType.emoji,
              requestType: GiphyContentRequestType.search,
              searchQuery: searchQuery,
            ),
            onMediaSelect: (GiphyMedia media) {
            },
          ),
        ),
      ],
    );
  }
}
