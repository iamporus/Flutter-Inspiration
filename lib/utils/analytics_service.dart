import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future logFavoriteMarked(designId) async {
    await _analytics.logEvent(
      name: 'favorite',
      parameters: {'designId': designId},
    );
  }

  Future logViewSourceClicked(designId) async {
    await _analytics.logEvent(
      name: 'viewSource',
      parameters: {'designId': designId},
    );
  }

  Future logViewRepoClicked() async {
    await _analytics.logEvent(
      name: 'viewRepo',
    );
  }

  Future logViewWalkThroughClicked() async {
    await _analytics.logEvent(
      name: 'viewWalkThrough',
    );
  }

  Future logViewCreditsClicked() async {
    await _analytics.logEvent(
      name: 'viewCredits',
    );
  }
}
