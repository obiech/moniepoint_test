part of '../pages/home_listings_tab.dart';

class _ListingGridTile extends StatefulWidget {
  const _ListingGridTile({
    required this.listing,
    required this.isGridWide,
    required this.index,
  });
  final int index;
  final HomeListing listing;
  final bool isGridWide;

  @override
  State<_ListingGridTile> createState() => __ListingGridTileState();
}

class __ListingGridTileState extends State<_ListingGridTile>
    with SingleTickerProviderStateMixin {
  late final double circleWidth;
  bool scaleLabel = false;
  bool expandLabel = false;
  bool showText = false;
  bool isDragging = false;
  double currentWidth = 0.0; // Tracks the width of the AnimatedContainer
  late final double maxWidth; // Max width of the container

  @override
  void initState() {
    circleWidth = widget.isGridWide ? 38.w : 32.w;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      maxWidth = MediaQuery.of(context).size.width; // Initialize maxWidth
      currentWidth = maxWidth; // Set initial width to full width
      await Future.delayed(kDuration300Mil);
      await Future.delayed(Duration(milliseconds: widget.index * 100));
      if (!mounted) return;
      setState(() => scaleLabel = true);
      await Future.delayed(kDuration150Mil * 3);
      if (!mounted) return;
      setState(() => expandLabel = true);
      await Future.delayed(kDuration500Mil);
      if (!mounted) return;
      setState(() => showText = true);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: widget.isGridWide ? EdgeInsets.all(12.r) : EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        image: DecorationImage(
          image: AssetImage(widget.listing.image),
          fit: BoxFit.cover,
        ),
      ),
      child: AnimatedScale(
        duration: kDuration500Mil,
        scale: scaleLabel ? 1 : 0,
        curve: Curves.easeOutBack,
        child: Blur(
          blur: 18,
          colorOpacity: 0.25,
          borderRadius: BorderRadius.circular(circleWidth),
          overlay: Stack(
            children: [
              Align(
                alignment: widget.isGridWide
                    ? Alignment.center
                    : const Alignment(-0.8, 0),
                child: AnimatedOpacity(
                  duration: kDuration500Mil,
                  curve: Curves.easeInOutQuad,
                  opacity: showText ? 1 : 0,
                  child: Text(
                    widget.listing.text,
                    style: const TextStyle(
                      fontSize: 18.5,
                      color: AppColor.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 3.r,
                bottom: 0,
                top: 0,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    isDragging = true;
                    showText = false;
                    setState(() {
                      currentWidth += details.delta.dx;
                      if (currentWidth > maxWidth) {
                        currentWidth = maxWidth;
                      } // Clamp to maxWidth
                      if (currentWidth < circleWidth + 6.w) {
                        currentWidth = circleWidth + 6.w; // Minimum width
                      }
                    });
                  },
                  onHorizontalDragEnd: (_) {
                    isDragging = false;
                    showText = true;
                    setState(() {
                      currentWidth = maxWidth; // Reset to maxWidth on drag end
                    });
                  },
                  child: Container(
                    width: circleWidth,
                    height: circleWidth,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.grey,
                      size: 16.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, consts) {
              return AnimatedContainer(
                curve: Curves.easeInOutCubic,
                duration: isDragging ? kDuration100Mil : kDuration800Mil,
                height: circleWidth + 6.w,
                width: currentWidth, // Bind to currentWidth
                padding: EdgeInsets.all(3.r),
              );
            },
          ),
        ),
      ),
    );
  }
}
