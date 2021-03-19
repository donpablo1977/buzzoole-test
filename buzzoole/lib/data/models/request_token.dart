class RequestToken {
  bool success;
  String expiresAt;
  String requestToken;

  RequestToken({this.success, this.expiresAt, this.requestToken});

  RequestToken.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    expiresAt = json['expires_at'];
    requestToken = json['request_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['expires_at'] = this.expiresAt;
    data['request_token'] = this.requestToken;
    return data;
  }
}
