import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('GO-CART'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate: _MySearchDelegate());
          },
        )
      ],
      backgroundColor: Colors.green,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light
      ),
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
