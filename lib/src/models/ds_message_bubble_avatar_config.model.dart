class DSMessageBubbleAvatarConfig {
  final Uri? receivedAvatar;
  final String? receivedName;
  final Uri? sentAvatar;
  final String? sentName;

  const DSMessageBubbleAvatarConfig({
    this.receivedAvatar,
    this.receivedName,
    this.sentAvatar,
    this.sentName,
  });

  bool get showReceivedAvatar => (receivedAvatar != null || (receivedName?.isNotEmpty ?? false));
  bool get showSentAvatar => (sentAvatar != null || (sentName?.isNotEmpty ?? false));
}
