part of '../pages/home_listings_tab.dart';

class _HomeListingBuilder extends StatelessWidget {
  const _HomeListingBuilder();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.listing.isEmpty) return const SizedBox();
          return StaggeredGrid.count(
            crossAxisCount: 20,
            mainAxisSpacing: 6.r,
            crossAxisSpacing: 6.r,
            children: [
              StaggeredGridTile.count(
                crossAxisCellCount: 20,
                mainAxisCellCount: 11,
                child: _ListingGridTile(
                  listing: state.listing[0],
                  isGridWide: true,
                  index: 0,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 10,
                mainAxisCellCount: 18,
                child: _ListingGridTile(
                  listing: state.listing[1],
                  isGridWide: false,
                  index: 1,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 10,
                mainAxisCellCount: 9,
                child: _ListingGridTile(
                  listing: state.listing[2],
                  isGridWide: false,
                  index: 2,
                ),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 10,
                mainAxisCellCount: 9,
                child: _ListingGridTile(
                  listing: state.listing[3],
                  isGridWide: false,
                  index: 3,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
