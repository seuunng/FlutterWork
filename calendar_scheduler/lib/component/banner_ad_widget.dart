import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}): super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget>{
  late final BannerAd banner;

  @override
  void initState() {
    super.initState();

    final adUnitId = Platform.isIOS
    ? 'ca-app-pub-4461306523468443/1698607046'
        : 'ca-app-pub-4461306523468443/1175862867';


  banner = BannerAd(
    size: AdSize.banner,
    adUnitId: adUnitId,
    listener: BannerAdListener(onAdFailedToLoad: (ad, error) {
    ad.dispose();
  }),
  request: AdRequest(),
      );
  banner.load();
  }
  @override
  void dispose() {
    banner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height: 75,
    child: AdWidget(ad: banner)
    );
  }
}