import 'package:portal/data/models/subscription_model.dart';

class CheckoutModel {
  String? sessionId;
  String? url;
  SubscriptionModel? subscription;

  CheckoutModel({this.sessionId, this.url, this.subscription});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      sessionId : json['sessionId'],
      url : json['stripeUrl'],
      subscription : json['subscription'] != null ? SubscriptionModel.fromJson(json['subscription']) : null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'url': url,
      'subscription': subscription != null ? subscription!.toJson() : null
    };
  }
}