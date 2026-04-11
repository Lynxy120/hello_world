import 'package:flutter/material.dart';

class PageSearchListview extends StatefulWidget {
  const PageSearchListview({super.key});

  @override
  State<PageSearchListview> createState() => _PageSearchListviewState();
}

class _PageSearchListviewState extends State<PageSearchListview> {
  //data json static
  List<Map<String, dynamic>> books = [
    {
      "id": 1,
      "title": "Harry Potter",
      "author": "J.K. Rowling",
      "year": "1997",
    },
    {"id": 2, "title": "The Hobbit", "author": "J.R.R Tolkien", "year": "1937"},
    {
      "id": 3,
      "title": "Clean Code",
      "author": "Robert C. Martin",
      "year": "2008",
    },
    {
      "id": 4,
      "title": "Atomic Habits",
      "author": "James Clear",
      "year": "2018",
    },
    {"id": 5, "title": "Deep Work", "author": "Cal Newport", "year": "2016"},
  ];

  List<Map<String, dynamic>> filteredBooks = [];
  TextEditingController txtSearch = TextEditingController();

  bool isGrid = false; //utk toggle view

  @override
  void initState() {
    super.initState();
    filteredBooks = books;
  }

  void searchBooks(String keyword) {
    final results = books.where((book) {
      final title = book["title"].toString().toLowerCase();
      final author = book["author"].toString().toLowerCase();
      final input = keyword.toLowerCase();

      return title.contains(input) || author.contains(input);
    }).toList();

    setState(() {
      filteredBooks = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Library Book"),
        backgroundColor: Colors.lightBlue,
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.grid_view : Icons.list),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            //search bar
            TextField(
              controller: txtSearch,
              decoration: InputDecoration(
                hintText: "Search Book....",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                searchBooks(value);
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filteredBooks.isEmpty
                  ? const Center(child: Text("No Books Found"))
                  : isGrid
                      ? buildListView()
                      : buildGridView(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: filteredBooks.length,
      itemBuilder: (context, index) {
        final book = filteredBooks[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.book, size: 32),
            title: Text(book["title"]),
            subtitle: Text("${book["author"]} . ${book["year"]}"),
          ),
        );
      },
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      itemCount: filteredBooks.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        final book = filteredBooks[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Icon(Icons.book, size: 60, color: Colors.lightBlue),
                ),
                const SizedBox(height: 10),
                Text(
                  book["title"],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  book["author"],
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const Spacer(),
                Text(
                  book["year"],
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
