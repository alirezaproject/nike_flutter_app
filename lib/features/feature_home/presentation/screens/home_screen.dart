import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/core/widgets/app_error_widget.dart';
import 'package:nike/features/feature_home/presentation/widgets/horizontal_product_list.dart';
import 'package:nike/service_locator.dart';
import 'package:nike/features/feature_home/presentation/bloc/home_bloc.dart';
import 'package:nike/features/feature_home/presentation/widgets/app_bar.dart';
import 'package:nike/features/feature_home/presentation/widgets/banner_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                          return NikeAppBar();
                        }
                      case 1:
                        {
                          break;
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
                            onTap: () {},
                            products: state.latestProducts,
                          );
                        }
                      case 4:
                        {
                          return HorizontalProductList(
                            title: 'پربازدید ترین',
                            onTap: () {},
                            products: state.popularProducts,
                          );
                        }

                      default:
                    }

                    return SizedBox();
                  },
                );
              }
              if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeError) {
                return AppErrorWidget(
                  exception: state.exception,
                  onTap: () => BlocProvider.of<HomeBloc>(context).add(RefreshHomeEvent()),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
