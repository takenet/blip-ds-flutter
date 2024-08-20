extension EnumByNameOrNull<T extends Enum> on Iterable<T> {
  T byNameOrDefault(String name, T defaultValue) {
    for (var value in this) {
      if (value.name.toString().toLowerCase() ==
          name.toString().toLowerCase()) {
        return value;
      }
    }

    return defaultValue;
  }
}
