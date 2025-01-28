class UserModel {
  final int? status;
  final int? id;
  final String? username;
  final String? name;
  final String? email;
  final String? role;

  final String? avatar;
  final String? accessToken;
  final String? tokenType;

  UserModel({
    this.status,
    this.id,
    this.username,
    this.name,
    this.email,
    this.role,
    this.avatar,
    this.accessToken,
    this.tokenType,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['userSummary'] != null) {
      return UserModel(
        status: jsonData['status'],
        id: jsonData['userSummary']['_id'],
        username: jsonData['userSummary']['username'],
        name: jsonData['userSummary']['name'],
        role: jsonData['userSummary']['role'],
        email: jsonData['userSummary']['email'],
        avatar: jsonData['userSummary']['avatar'],
        accessToken: jsonData['accessToken'],
        tokenType: jsonData['tokenType'],
      );
    } else {
      // Handle the case where 'userSummary' is null or missing in the JSON.
      return UserModel(); // Return an empty UserModel or handle it differently.
    }
  }
}
