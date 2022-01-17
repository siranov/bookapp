import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book App'),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Padding(
                padding: EdgeInsets.only(right: 12), child: Icon(Icons.search)),
          )
        ],
      ),
      drawer: DrawerWid(),
      body: ListWidget(),
    );
  }
}

class ListWidget extends StatefulWidget {
  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 10, right: 10, top: index == 0 ? 20 : 0, bottom: 20),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(blurRadius: 3, color: Colors.black38)
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text('Cat in the Hat',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        height: 250,
                        child: ClipRRect(
                          child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://static.scientificamerican.com/sciam/cache/file/1DDFE633-2B85-468D-B28D05ADAE7D1AD8_source.jpg?w=590&h=800&D80F3D79-4382-49FA-BE4B4D0C62A5C3ED')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class DrawerWid extends StatefulWidget {
  @override
  _DrawerWidState createState() => _DrawerWidState();
}

class _DrawerWidState extends State<DrawerWid> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
          ),
        ],
      ),
    );
  }
}
