import 'package:flutter/material.dart';

int curPage = 0;

class HomePage extends StatefulWidget {
  final VoidCallback update;

  const HomePage({Key key, this.update}) : super(key: key);
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
      drawer: DrawerWid(
        update: widget.update,
      ),
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
  final VoidCallback update;

  const DrawerWid({Key key, this.update}) : super(key: key);
  @override
  _DrawerWidState createState() => _DrawerWidState();
}

class _DrawerWidState extends State<DrawerWid> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(height: 80),
          Container(
            height: 150,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('Guest', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
          section('Main Page', Icons.home, 0, () {
            widget.update();
          }),
          section('Sell', Icons.book, 1, () {
            widget.update();
          }),
        ],
      ),
    );
  }

  Widget section(name, icon, i, callback) {
    return GestureDetector(
      onTap: () {
        curPage = i;
        callback();
      },
      child: Container(
        color: curPage == i ? Colors.deepOrange : Colors.transparent,
        height: 60,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(name, style: TextStyle(fontSize: 16)),
              ),
              Icon(icon, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
