import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'hero_artwork.dart';

class CustomGridTile extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String id;
  final Function onTap;
  final ValueSetter<String> actionsHandler;

  const CustomGridTile({Key key, this.imagePath, this.title, this.subtitle, this.onTap, this.id, this.actionsHandler}) : super(key: key);

  @override
  _CustomGridTileState createState() => _CustomGridTileState();
}

class _CustomGridTileState extends State<CustomGridTile> {
  var _tapPosition;

  PopupMenuItem<String> _preparePopupItem(IconData icon, String text, ValueSetter<String> handler) {
    return PopupMenuItem<String>(
      value: text,
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        onTap: (){
          if(handler != null) {
            handler(text);
          }
        },
      ),
      enabled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: widget.onTap,
        onTapDown: (det) {
          _tapPosition = det.globalPosition;
        },
        onLongPress: () {
          final RenderBox overlay = Overlay.of(context).context.findRenderObject();

          showMenu<String>(
            context: context,
            position: RelativeRect.fromRect(
                _tapPosition & Size(40, 40), // smaller rect, the touch area
                Offset.zero & overlay.size // Bigger rect, the entire screen
                ),
            items: [
              _preparePopupItem(Icons.shuffle, 'Shuffle', widget.actionsHandler),
              _preparePopupItem(Icons.playlist_play, 'Play', widget.actionsHandler),
            ],
            elevation: 8.0,
            useRootNavigator: true,
          );
        },
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.85),
            title: Text(widget.title ?? '', softWrap: true, maxLines: 2, style: Theme.of(context).textTheme.subtitle1,),
            subtitle: Text(widget.subtitle ?? '', style: Theme.of(context).textTheme.caption,),
          ),
          child: HeroArtwork(
            path: widget.imagePath,
            id: widget.id,
          ),
        )
      ),
    );
  }
}