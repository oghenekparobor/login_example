import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < 4; i++)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: const [
                FadeShimmer(
                  height: 30,
                  width: double.infinity,
                  radius: 4,
                  baseColor: Colors.black26,
                  highlightColor: Colors.black12,
                ),
                SizedBox(height: 5),
                FadeShimmer(
                  height: 15,
                  width: double.infinity,
                  radius: 4,
                  baseColor: Colors.black26,
                  highlightColor: Colors.black12,
                ),
                SizedBox(height: 5),
                FadeShimmer(
                  height: 20,
                  width: double.infinity,
                  radius: 4,
                  baseColor: Colors.black26,
                  highlightColor: Colors.black12,
                ),
              ],
            ),
          )
      ],
    );
  }
}
