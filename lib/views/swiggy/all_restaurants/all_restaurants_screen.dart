import 'package:flutter/material.dart';
import 'package:swiggy_ui/models/all_restaurant.dart';
import 'package:swiggy_ui/models/indian_food.dart';
import 'package:swiggy_ui/models/spotlight_best_top_food.dart';
import 'package:swiggy_ui/utils/ui_helper.dart';
import 'package:swiggy_ui/views/swiggy/groceries/grocery_screen.dart';
import 'package:swiggy_ui/views/swiggy/offers/offer_screen.dart';
import 'package:swiggy_ui/widgets/custom_divider_view.dart';
import 'package:swiggy_ui/widgets/search_food_list_item_view.dart';

import '../indian_delight_screen.dart';
import '../popular_categories_view.dart';

class AllRestaurants extends StatelessWidget {
  final restaurantListOne = AllRestaurant.getRestaurantListOne();
  final restaurantListTwo = AllRestaurant.getRestaurantListTwo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildAppBar(context),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _FoodHorizontalListView(),
                  CategoriesView(),
                  GroceryListView(
                    title: 'ALL RESTAURANTS',
                  ),
                  _RestaurantHorizontalListView(
                    title: 'Indian Restaurants',
                    restaurants: AllRestaurant.getIndianRestaurants(),
                  ),
                  _RestaurantListView(
                    restaurants: restaurantListOne,
                  ),
                  _RestaurantHorizontalListView(
                    title: 'Popular Brands',
                    restaurants: AllRestaurant.getPopularBrands(),
                  ),
                  _RestaurantListView(
                    restaurants: restaurantListTwo,
                  ),
                ],
              ),
            ))
          ],
        )),
      ),
    );
  }

  Container _buildAppBar(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        height: 60.0,
        child: Row(
          children: <Widget>[
            Text(
              'Now',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 18.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            UIHelper.horizontalSpaceSmall(),
            Container(
              alignment: Alignment.center,
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Icon(Icons.arrow_forward_ios, size: 16.0),
            ),
            UIHelper.horizontalSpaceSmall(),
            Text(
              'Other',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontSize: 21.0),
            ),
            UIHelper.horizontalSpaceExtraSmall(),
            Spacer(),
            Icon(Icons.local_offer),
            UIHelper.horizontalSpaceExtraSmall(),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Offer',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontSize: 18.0),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OffersScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      );
}

class _FoodHorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/food1.jpg',
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 2,
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                color: Colors.white,
                child: Text('TRY NOW'),
              ),
              Positioned(
                left: 10.0,
                bottom: 10.0,
                child: Text(
                  'VEGGIE FRIENDLY\nEATERIES',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesView extends StatelessWidget {
  final categories = AllRestaurant.getPopularTypes();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 104.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            width: 50.0,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    height: 40.0,
                    color: Colors.grey[200],
                  ),
                ),
                Positioned(
                  top: 20.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        categories[index].image,
                        height: 30.0,
                        width: 30.0,
                        fit: BoxFit.cover,
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Flexible(
                        child: Text(
                          categories[index].name,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 13.0),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class _RestaurantHorizontalListView extends StatelessWidget {
  final String title;
  final List<IndianFood> restaurants;

  const _RestaurantHorizontalListView({
    Key key,
    @required this.title,
    @required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      height: 180.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomDividerView(dividerHeight: 1.0, color: Colors.black),
          UIHelper.verticalSpaceSmall(),
          Text(
            title,
            style:
                Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 18.0),
          ),
          UIHelper.verticalSpaceSmall(),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              itemBuilder: (context, index) => InkWell(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          restaurants[index].image,
                          height: 80.0,
                          width: 80.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      UIHelper.verticalSpaceExtraSmall(),
                      Text(
                        restaurants[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.grey[700]),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndianDelightScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
          UIHelper.verticalSpaceSmall(),
          CustomDividerView(dividerHeight: 1.0, color: Colors.black),
        ],
      ),
    );
  }
}

class _RestaurantListView extends StatelessWidget {
  final List<SpotlightBestTopFood> restaurants;

  const _RestaurantListView({
    Key key,
    @required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: restaurants.length,
        itemBuilder: (context, index) => SearchFoodListItemView(
          food: restaurants[index],
        ),
      ),
    );
  }
}