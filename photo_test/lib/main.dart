import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:photo_test/page/index_page.dart';
import 'package:provider/provider.dart';

import 'model/photo_provider.dart';

final provider = PhotoProvider();

void main() => runApp(
      OKToast(
        child: ChangeNotifierProvider<PhotoProvider>.value(
          value: provider,
          child: MaterialApp(
            home: IndexPage(),
          ),
        ),
      ),
    );
