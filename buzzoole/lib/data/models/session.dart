class Session {
  bool success;
  String sessionId;

  Session({this.success, this.sessionId});

  Session.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    sessionId = json['session_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['session_id'] = this.sessionId;
    return data;
  }
}
