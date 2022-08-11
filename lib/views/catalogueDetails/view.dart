import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewear/generals/colors.dart';
import 'package:rewear/generals/constants.dart';
import 'package:rewear/generals/widgets/break.widget.dart';
import 'package:rewear/generals/widgets/hr.widget.dart';
import 'package:rewear/generals/widgets/star.widget.dart';
import 'package:rewear/models/tailor.dart';

class CatalogueDetails extends StatelessWidget {
  CatalogueDetails({Key? key}) : super(key: key);

  final Tailor tailor = Get.arguments;
  final List<String> images = [
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_herringbone_check_slim_fit_suit_formal_3_piece_set_in_blue_5_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5eba6b316dd6e88c1bf7ab6c64c82900/n/a/navy_blue_velvet_3_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5eba6b316dd6e88c1bf7ab6c64c82900/_/b/_boy_s_check_slim_fit_suit_formal_3_piece_set_in_grey_8_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5eba6b316dd6e88c1bf7ab6c64c82900/b/o/boys_herringbone_check_slim_fit_suit_formal_3_piece_set_in_blue_5_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boy_s_windowpane_check_slim_fit_suit_formal_3_piece_set_in_navy_blue_6_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_check_slim_fit_suit_formal_3_piece_set_in_beige_8_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_burgundy_windowpane_check_slim_fit_suit_formal_3_piece_set_in_blue_8_.jpg',
    'https://www.sirri.com/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_herringbone_check_slim_fit_suit_formal_3_piece_set_in_dark_green_7_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boy_s_windowpane_check_slim_fit_suit_formal_3_piece_set_in_petrol_blue_7_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5482c685bf4c22bf379b7056916e3d21/6/w/6w_130.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_herringbone_check_slim_fit_suit_formal_3_piece_set_in_blue_5_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5eba6b316dd6e88c1bf7ab6c64c82900/n/a/navy_blue_velvet_3_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5eba6b316dd6e88c1bf7ab6c64c82900/_/b/_boy_s_check_slim_fit_suit_formal_3_piece_set_in_grey_8_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5eba6b316dd6e88c1bf7ab6c64c82900/b/o/boys_herringbone_check_slim_fit_suit_formal_3_piece_set_in_blue_5_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boy_s_windowpane_check_slim_fit_suit_formal_3_piece_set_in_navy_blue_6_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_check_slim_fit_suit_formal_3_piece_set_in_beige_8_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_burgundy_windowpane_check_slim_fit_suit_formal_3_piece_set_in_blue_8_.jpg',
    'https://www.sirri.com/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_herringbone_check_slim_fit_suit_formal_3_piece_set_in_dark_green_7_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boy_s_windowpane_check_slim_fit_suit_formal_3_piece_set_in_petrol_blue_7_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5482c685bf4c22bf379b7056916e3d21/6/w/6w_130.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_herringbone_check_slim_fit_suit_formal_3_piece_set_in_blue_5_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5eba6b316dd6e88c1bf7ab6c64c82900/n/a/navy_blue_velvet_3_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5eba6b316dd6e88c1bf7ab6c64c82900/_/b/_boy_s_check_slim_fit_suit_formal_3_piece_set_in_grey_8_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5eba6b316dd6e88c1bf7ab6c64c82900/b/o/boys_herringbone_check_slim_fit_suit_formal_3_piece_set_in_blue_5_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boy_s_windowpane_check_slim_fit_suit_formal_3_piece_set_in_navy_blue_6_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_check_slim_fit_suit_formal_3_piece_set_in_beige_8_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_burgundy_windowpane_check_slim_fit_suit_formal_3_piece_set_in_blue_8_.jpg',
    'https://www.sirri.com/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boys_herringbone_check_slim_fit_suit_formal_3_piece_set_in_dark_green_7_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/c0e7c0875c889aef60063c3b9191953f/b/o/boy_s_windowpane_check_slim_fit_suit_formal_3_piece_set_in_petrol_blue_7_.jpg',
    'https://www.sirri.co.uk/media/catalog/product/cache/5482c685bf4c22bf379b7056916e3d21/6/w/6w_130.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightGrey.withAlpha(240),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            backgroundColor: MyColors.orange,
            floating: true,
            pinned: true,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/jpg/sample-catalog-04.jpg',
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.dstOut,
                color: MyColors.orange.withOpacity(0.7),
              ),
              collapseMode: CollapseMode.parallax,
              expandedTitleScale: 2.2,
              centerTitle: false,
              titlePadding: MyConstants.primaryPadding.copyWith(
                  top: 20,
                  bottom: 16,
                  left: MyConstants.primaryPadding.left * 2),
              title: Text(
                tailor.fullname ?? '',
                textAlign: TextAlign.left,
                style: Get.theme.textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold, color: MyColors.white),
              ),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: MyColors.white,
                ),
                onPressed: Get.back),
          ),
          SliverPadding(
            padding: MyConstants.primaryPadding,
            sliver: SliverToBoxAdapter(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.teal.withAlpha(140),
                            Colors.teal.withAlpha(130),
                            Colors.teal.withAlpha(150),
                            Colors.teal.withAlpha(180),
                            Colors.teal.withAlpha(200),
                            Colors.teal.withAlpha(250),
                          ])),
                  child: Padding(
                      padding: MyConstants.primaryPadding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tailor information',
                            style: Get.theme.textTheme.headline6!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          BreakWidget(size: 40, vertical: true),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  'Phone',
                                  style: Get.theme.textTheme.bodyText1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  tailor.phone ?? '',
                                  style: Get.theme.textTheme.bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Hr(
                            color: Colors.white.withOpacity(0.5),
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  'Address',
                                  style: Get.theme.textTheme.bodyText1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  tailor.address ?? '',
                                  style: Get.theme.textTheme.bodyText1!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Hr(
                            color: Colors.white.withOpacity(0.5),
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text(
                                  'Rate',
                                  style: Get.theme.textTheme.bodyText1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: StarWidget(rate: tailor.rate ?? 0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))),
            ),
          ),
          SliverPadding(
            padding: MyConstants.primaryPadding,
            sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                          margin: const EdgeInsets.all(5),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              color: MyColors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child:
                              Image.network(images[index], fit: BoxFit.cover),
                        ),
                    childCount: images.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3)),
          ),
        ],
      ),
    );
  }
}
