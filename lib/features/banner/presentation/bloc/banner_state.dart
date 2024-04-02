part of 'banner_bloc.dart';

class BannerState extends Equatable {
  final BannerStatus bannerStatus;

  const BannerState({required this.bannerStatus});

  @override
  List<Object?> get props => [bannerStatus];

  BannerState copyWith(BannerStatus? newBannerStatus) {
    return BannerState(bannerStatus: newBannerStatus ?? bannerStatus);
  }
}
