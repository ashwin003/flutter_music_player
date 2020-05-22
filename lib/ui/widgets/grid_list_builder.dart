import 'package:flutter/material.dart';

typedef GridTileWidgetBuilder<T> = Widget Function(T data);

typedef Predicate<T> = bool Function(T data);

class GridListBuilder<T> extends StatelessWidget {
  final Future<List<T>> elements;
  final GridTileWidgetBuilder<T> builder;
  final EdgeInsetsGeometry itemSpacing;
  final Predicate<T> predicate;

  const GridListBuilder({Key key, @required this.elements, @required this.builder, this.itemSpacing, this.predicate}) : super(key: key);

  int _getColumnCount(BuildContext context){
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    if(mediaQuery.size.shortestSide > 600) {
      // Tablet
      return mediaQuery.orientation == Orientation.portrait ? 3 : 5;  
    }
    // Smartphone
    return mediaQuery.orientation == Orientation.portrait ? 2 : 4;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: elements,
      builder: (ctx, AsyncSnapshot<List<T>> snapshot) {
        if(snapshot.hasData) {
          return GridView.count(
            padding: EdgeInsets.symmetric(horizontal: 8,),
            crossAxisCount: _getColumnCount(context),
            children: predicate == null ? 
                        snapshot.data.map((a) => builder(a)).toList() : 
                        snapshot.data.where((element) => predicate(element)).map((e) => builder(e)).toList(),
            );
        }
        return Center(child: CircularProgressIndicator() ,);
      },
    );
  }
}