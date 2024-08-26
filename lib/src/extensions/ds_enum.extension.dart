extension EnumByNameOrNull<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String? name) {
    for (var value in this) {
      if (value.name.toString().toLowerCase() ==
          name?.toString().toLowerCase()) {
        return value;
      }
    }

    return null;
  }
}
