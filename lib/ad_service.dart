import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService {
  final String testBannerAdId = "ca-app-pub-3940256099942544/6300978111";
  final String testInterstitialAdId = "ca-app-pub-3940256099942544/1033173712";
  final String testRewardAdId = "ca-app-pub-3940256099942544/5224354917";

  BannerAd loadBannerAd({String? adId, AdEventCallback? onAdLoaded, AdLoadErrorCallback? onFailed}) {
    return BannerAd(
      adUnitId: adId ?? testBannerAdId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onFailed,
      ),
    )..load();
  }

  void loadInterstitialAd({String? adId, GenericAdEventCallback<Ad>? onAdLoaded, FullScreenAdLoadErrorCallback? onFailed}) {
    InterstitialAd.load(
      adUnitId: adId ?? testInterstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded != null ? onAdLoaded : (ad) {},
        onAdFailedToLoad: onFailed != null ? onFailed : (error) {},
      ),
    );
  }

  void loadRewardedAd({String? adId, GenericAdEventCallback<RewardedAd>? onAdLoaded, FullScreenAdLoadErrorCallback? onFailed}) {
    RewardedAd.load(
      adUnitId: adId ?? testRewardAdId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: onAdLoaded != null ? onAdLoaded : (ad) {},
        onAdFailedToLoad: onFailed != null ? onFailed : (error) {},
      ),
    );
  }
}
