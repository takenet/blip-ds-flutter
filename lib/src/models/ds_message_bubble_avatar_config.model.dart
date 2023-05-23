class DSMessageBubbleAvatarConfig {
  final Uri? receivedAvatar;
  final String? receivedName;
  final Uri? sentAvatar;
  final String? sentName;
  final bool hideSentAvatar;
  final Uri? customerSentAvatar;
  final String? customerSentName;

  const DSMessageBubbleAvatarConfig({
    this.receivedAvatar,
    this.receivedName,
    this.sentAvatar,
    this.sentName,
    this.hideSentAvatar = false,
    this.customerSentAvatar,
    this.customerSentName,
  });

  bool get showReceivedAvatar =>
      (receivedAvatar != null || (receivedName?.isNotEmpty ?? false));
  bool get showSentAvatar =>
      !hideSentAvatar &&
      (sentAvatar != null || (sentName?.isNotEmpty ?? false));
}
