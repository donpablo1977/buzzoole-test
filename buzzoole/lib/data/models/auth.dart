class Auth {
  String requestToken;
  String expiresAt;
  bool success;

  Auth({this.requestToken, this.expiresAt, this.success});

  Auth.fromJson(Map<String, dynamic> json) {
    requestToken = json['request_token'];
    expiresAt = json['expires_at'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_token'] = this.requestToken;
    data['expires_at'] = this.expiresAt;
    data['success'] = this.success;
    return data;
  }
}
