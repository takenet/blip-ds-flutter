class DSMessageBubbleAvatarConfig {
  final Uri? ownerAvatar;
  final String? ownerName;
  final Uri? userAvatar;
  final String? userName;

  const DSMessageBubbleAvatarConfig({
    this.ownerAvatar,
    this.ownerName,
    this.userAvatar,
    this.userName,
  });

  bool get showOwnerAvatar => (ownerAvatar != null || (ownerName?.isNotEmpty ?? false));
  bool get showUserAvatar => (userAvatar != null || (userName?.isNotEmpty ?? false));
}
