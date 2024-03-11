import 'package:flutter/cupertino.dart';

class EmptyMapWidget extends StatelessWidget {
  const EmptyMapWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        CupertinoIcons.map_fill,
      ),
    );
  }
}
