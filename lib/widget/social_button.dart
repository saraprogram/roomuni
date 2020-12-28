import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:roomie/model/models.dart';
import 'package:roomie/widget/widgets.dart';

class PostStats extends StatelessWidget {
  final model;
  final type;
  final Function comment;
  final Function like;
  final Icon icon;

  const PostStats({
    Key key,
    @required this.model,
    @required this.type,
    @required this.comment,
    @required this.like,
    @required this.icon,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool toggle=false;

    if (type == 'ads') {
      Ads post = model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PostButton(
              icon: Icon(
              MdiIcons.shareOutline,
              color: Colors.grey[600],
              size: 25.0,
            ),
              label: 'Like',
              onTap:like,
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () => custom_share(context),
            )
          ],
        ),
      ],
    );

    }
    else if(type == 'question') {
      Questions post = model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Like',
              onTap: like,
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () => custom_share(context),
            )
          ],
        ),
      ],
    );
    }
    else  if(type == 'reply'){
      print("ready");
      Questions post = model;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _PostButton(
                icon: icon,
                label: 'Like',
                onTap:like,
              ),
              _PostButton(
                icon: Icon(
                  MdiIcons.comment,
                  color: Colors.grey[600],
                  size: 25.0,
                ),
                label: 'Comment',
                onTap: comment,
              ),
              _PostButton(
                icon: Icon(
                  MdiIcons.shareOutline,
                  color: Colors.grey[600],
                  size: 25.0,
                ),
                label: 'Share',
                onTap: () => custom_share(context),
              ),
            ],
          ),
        ],
      );
    }

  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}