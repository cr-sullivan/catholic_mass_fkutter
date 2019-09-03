class Parish {
  final String login;
  final String avatarUrl;
  final String details;

  Parish(this.login, this.avatarUrl, this.details) {
    if (login == null) {
      throw ArgumentError("login of Parish cannot be null. "
          "Received: '$login'");
    }
    if (avatarUrl == null) {
      throw ArgumentError("avatarUrl of Parish cannot be null. "
          "Received: '$avatarUrl'");
    }
    if (details == null) {
      throw ArgumentError("details of Parish cannot be null. "
          "Received: '$details'");
    }
  }
}
