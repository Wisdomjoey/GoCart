import 'package:flutter/material.dart';

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
        );
      },
    );
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
        );
      },
    );
  }
}
