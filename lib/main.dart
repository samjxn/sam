import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sam/src/application.dart';

import 'src/ui/screens/models/home_screen_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeScreenModel()),
      ],
      child: const PortfolioApplication(),
    ),
  );
}
