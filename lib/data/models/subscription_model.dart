class SubscriptionModel {
  String? subscriptionId;
  String? customer;

  SubscriptionModel({this.subscriptionId, this.customer});

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      subscriptionId : json['subscriptionId'],
      customer : json['customer']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subscriptionId': subscriptionId,
      'customer': customer
    };
  }
}