import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike/core/utils/constants.dart';
import 'package:nike/di.dart';
import 'package:nike/features/feature_home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = di<HomeBloc>();
        homeBloc.add(LoadHomeEvent());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeCompleted) {
                return ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                  itemBuilder: (BuildContext context, int index) {
                    switch (index) {
                      case 0:
                        {
                          return Image.asset(
                            '${Constants.baseImageLocation}nike_logo.png',
                            height: 35,
                          );
                        }
                      case 1:
                        {
                          break;
                        }
                      case 2:
                        {
                          return Container();
                        }
                      case 3:
                        {
                          return Container();
                        }
                      case 4:
                        {
                          return Container();
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(state.exception.message),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(RefreshHomeEvent());
                        },
                        child: Text('تلاش مجدد'),
                      ),
                    ],
                  ),
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
