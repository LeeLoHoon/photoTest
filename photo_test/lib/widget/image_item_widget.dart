import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_test/core/lru_map.dart';
import 'package:photo_test/model/photo_provider.dart';
import 'package:provider/provider.dart';

import 'change_notifier_builder.dart';
import 'loading_widget.dart';

class ImageItemWidget extends StatefulWidget {
  final AssetEntity entity;

  const ImageItemWidget({
    Key key,
    this.entity,
  }) : super(key: key);
  @override
  _ImageItemWidgetState createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PhotoProvider>(context);
    return ChangeNotifierBuilder(
      builder: (c, p) {
        final format = provider.thumbFormat;
        return buildContent(format);
      },
      value: provider,
    );
  }

  Widget buildContent(ThumbFormat format) {
    if (widget.entity.type == AssetType.audio) {
      return Center(
        child: Icon(
          Icons.audiotrack,
          size: 30,
        ),
      );
    }
    final item = widget.entity;
    final size = 130;
    final u8List = ImageLruCache.getData(item, size, format);

    Widget image;

    if (u8List != null) {
      return _buildImageWidget(item, u8List, size);
    } else {
      image = FutureBuilder<Uint8List>(
        future: item.thumbDataWithSize(size, size, format: format),
        builder: (context, snapshot) {
          Widget w;
          if (snapshot.hasError) {
            w = Center(
              child: Text("load error, error: ${snapshot.error}"),
            );
          }
          if (snapshot.hasData) {
            ImageLruCache.setData(item, size, format, snapshot.data);
            w = _buildImageWidget(item, snapshot.data, size);
          } else {
            w = Center(
              child: loadWidget,
            );
          }

          return w;
        },
      );
    }

    return image;
  }

  Widget _buildImageWidget(AssetEntity entity, Uint8List uint8list, num size) {
    return Image.memory(
      uint8list,
      width: size.toDouble(),
      height: size.toDouble(),
      fit: BoxFit.cover,
    );
  }

  @override
  void didUpdateWidget(ImageItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.entity.id != oldWidget.entity.id) {
      setState(() {});
    }
  }
}
