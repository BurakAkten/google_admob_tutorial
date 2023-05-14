import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_admob_tutorial/ad_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google AdMob Tutorial',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const MyHomePage(title: 'Google AdMob Tutorial Page'),
      home: const MyHomePage(title: 'Google AdMob Tutorial Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();
    _loadBanner();
    _loadRewarded();
    _loadInterstitial();
  }

  void _loadBanner() {
    _bannerAd = AdService().loadBannerAd(
      onAdLoaded: (ad) => _bannerAd = ad as BannerAd,
      onFailed: (_, __) => _bannerAd?.dispose(),
    );
  }

  void _loadInterstitial() {
    AdService().loadInterstitialAd(
      onAdLoaded: (ad) => _interstitialAd = ad as InterstitialAd,
      onFailed: (error) => _interstitialAd?.dispose(),
    );
  }

  void _loadRewarded() {
    AdService().loadRewardedAd(
      onAdLoaded: (ad) => _rewardedAd = ad,
      onFailed: (error) => _rewardedAd?.dispose(),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            _buildButton(
              title: "Show Interstitial Add",
              onTap: () async {
                if (_interstitialAd != null) await _interstitialAd!.show();
              },
            ),
            _buildButton(
                title: "Show Rewarded Add",
                onTap: () async {
                  if (_rewardedAd != null)
                    await _rewardedAd!.show(
                      onUserEarnedReward: (_, __) async {
                        //Do what ever you want, user gained the reward.
                        Fluttertoast.showToast(msg: "Congratulation, You get your reward.", timeInSecForIosWeb: 3, gravity: ToastGravity.TOP);
                      },
                    );
                }),
            Spacer(),
            if (_bannerAd != null)
              SafeArea(
                child: Container(
                  height: _bannerAd!.size.height.toDouble(),
                  width: _bannerAd!.size.width.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({required Function() onTap, required String title}) {
    return Container(
      margin: EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          height: 50,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(title, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
