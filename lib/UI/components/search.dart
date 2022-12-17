import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:GOCart/UI/routes/route_helper.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      splashRadius: 24,
      tooltip: 'Search',
      onPressed: () {
        showSearch(context: context, delegate: _MySearchDelegate());
      },
    );
  }
}

class _MySearchDelegate extends SearchDelegate {
  List<String> terms = ['jay', 'boy', 'Joe', 'John', 'Dan'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // List<String> matchQuery = [];

    // for (var element in terms) {
    //   if (element.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(element);
    //   }
    // }

    // return ListView.builder(
    //   itemCount: matchQuery.length,
    //   itemBuilder: (context, index) {
    //     var result = matchQuery[index];

    //     return ListTile(
    //       title: Text(result),
    //       visualDensity: const VisualDensity(vertical: -2),
    //       shape: const Border(bottom: BorderSide(color: Colors.grey)),
    //       onTap: () => query = result,
    //     );
    //   },
    // );
    // Timer(const Duration(milliseconds: 100), (() {
    // Get.toNamed(RouteHelper.getProductListPage());
    print('added');
    // }));
    return const Text('added');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var element in terms) {
      if (element.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(element);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];

        return ListTile(
          title: Text(result),
          visualDensity: const VisualDensity(vertical: -2),
          shape: const Border(
              bottom: BorderSide(color: Color.fromARGB(255, 203, 203, 203))),
          onTap: () {
            // query = result;
            Get.offNamed(RouteHelper.getProductListPage());
          },
        );
      },
    );
  }
}
