class Metadata {
    int subscriptions = 0;

    Metadata({
        this.subscriptions,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        subscriptions: json["subscriptions"],
    );

    Map<String, dynamic> toJson() => {
        "subscriptions": subscriptions,
    };
}