import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sam/src/ui/screens/models/home_screen_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollPercentage = 1.0;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeScreenModel>();

    final image = Image.network(
      'https://picsum.photos/250?image=9',
      fit: BoxFit.cover,
    );
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.axis == Axis.vertical) {
            setState(() {
              _scrollPercentage =
                  (scrollInfo.metrics.pixels / 300.0).clamp(0.0, 1.0);
            });
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            // First Sliver: Persistent Header with the fading out image
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverImageDelegate(fadeOut: true, image: image),
            ),

            // Some spacing or content between the images
            SliverToBoxAdapter(
              child: Container(
                height: 1000,
                color: Colors.blue,
                child: Center(
                    child: Text("Scroll down to see the second image fade in")),
              ),
            ),

            // Second Sliver: Content with a fading in image
            SliverToBoxAdapter(
              child: _FadingImageContainer(image: image),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverImageDelegate extends SliverPersistentHeaderDelegate {
  final bool fadeOut;
  final Widget image;

  _SliverImageDelegate({
    required this.fadeOut,
    required this.image,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double opacity =
        fadeOut ? 1.0 - (shrinkOffset / maxExtent) : shrinkOffset / maxExtent;

    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Container(
        color: Colors.transparent,
        child: image,
      ),
    );
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _FadingImageContainer extends StatelessWidget {
  final Widget image;

  const _FadingImageContainer({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Determine the scroll position relative to the widget
        ScrollableState? scrollableState = Scrollable.of(context);
        double scrollPosition = scrollableState?.position.pixels ?? 0.0;
        double fadeStart = 1000.0; // Start fading in after this scroll position
        double fadeEnd = fadeStart + 300.0; // End fading in at this position

        double opacity = 0.0;
        if (scrollPosition >= fadeStart && scrollPosition <= fadeEnd) {
          opacity = (scrollPosition - fadeStart) / (fadeEnd - fadeStart);
        } else if (scrollPosition > fadeEnd) {
          opacity = 1.0;
        }

        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Container(
            height: 300,
            child: image,
          ),
        );
      },
    );
  }
}
