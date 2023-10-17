class DSMediaInfo {
  final int? width;
  final int? height;
  final int? size;

  DSMediaInfo({
    this.width,
    this.height,
    this.size,
  });

  bool get hasDimensions => width != null && height != null;

  bool get isWidescreen => hasDimensions && width! > height!;

  double? get aspectRatio => hasDimensions
      ? isWidescreen
          ? width! / height!
          : height! / width!
      : null;
}
