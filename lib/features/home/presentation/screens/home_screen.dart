import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/widgets/app_error_widget.dart';
import 'package:nike/features/home/presentation/widgets/horizontal_product_list.dart';
import 'package:nike/features/product/domain/entities/product_entity.dart';
import 'package:nike/features/product/presentation/screens/product_list_screen.dart';
import 'package:nike/service_locator.dart';
import 'package:nike/features/home/presentation/bloc/home_bloc.dart';
import 'package:nike/features/home/presentation/widgets/app_bar.dart';
import 'package:nike/features/home/presentation/widgets/banner_slider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = sl<HomeBloc>();
        homeBloc.add(LoadHomeEvent());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeCompleted) {
                return ListView.builder(
                  physics: Constants.defaultScrollPhysics,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        {
                          return const NikeAppBar();
                        }
                      case 1:
                        {
                          return Container(
                            height: 56,
                            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                label: const Text('جستجو'),
                                isCollapsed: false,
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    _search(context);
                                  },
                                  icon: const Icon(CupertinoIcons.search),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                              ),
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                _search(context);
                              },
                            ),
                          );
                        }
                      case 2:
                        {
                          return BannerSlider(
                            banners: state.banners,
                          );
                        }
                      case 3:
                        {
                          return HorizontalProductList(
                            title: 'جدید ترین',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProductListScreen(sort: ProductSort.latest),
                              ));
                            },
                            products: state.latestProducts,
                          );
                        }
                      case 4:
                        {
                          return HorizontalProductList(
                            title: 'پربازدید ترین',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProductListScreen(sort: ProductSort.popular),
                              ));
                            },
                            products: state.popularProducts,
                          );
                        }

                      default:
                    }

                    return const SizedBox();
                  },
                );
              }
              if (state is HomeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeError) {
                return AppErrorWidget(
                  exception: state.exception,
                  onTap: () => BlocProvider.of<HomeBloc>(context).add(RefreshHomeEvent()),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  void _search(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductListScreen.search(
        seachTerm: _searchController.text,
      ),
    ));
  }
}
