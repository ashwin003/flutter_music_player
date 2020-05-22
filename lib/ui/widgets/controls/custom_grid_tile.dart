import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'artwork.dart';

class CustomGridTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final Function onTap;

  const CustomGridTile({Key key, this.imagePath, this.title, this.subtitle, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.85),
            title: Text(title ?? '', softWrap: true, maxLines: 2, style: Theme.of(context).textTheme.subtitle1.apply(color: Colors.black87),),
            subtitle: Text(subtitle ?? '', style: Theme.of(context).textTheme.caption.apply(color: Colors.black54),),
          ),
          child: Artwork(
            path: imagePath,
          ),
        )
      ),
    );
  }
}