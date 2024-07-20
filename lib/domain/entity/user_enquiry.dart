class UserEnquiry {
  final String message;
  final DateTime created;
  final String userName;
  final String userPhone;
  final String userImageUrl;
  final String propertyName;

  UserEnquiry({
    required this.message,
    required this.created,
    required this.userName,
    required this.userPhone,
    required this.userImageUrl,
    required this.propertyName,
  });
}
