class Auth {
  String requestToken;
  int statusCode;
  String statusMessage;
  bool success;

  Auth({this.requestToken, this.statusCode, this.statusMessage, this.success});

  Auth.fromJson(Map<String, dynamic> json) {
    requestToken = json['request_token'];
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['request_token'] = this.requestToken;
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['success'] = this.success;
    return data;
  }
}
