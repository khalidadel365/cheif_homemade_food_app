extension ImageFormatter on String? {
  String? toCleanImageUrl() {
    if (this == null) return null;

    int resIndex = this!.indexOf('res.cloudinary.com');

    if (resIndex != -1) {
      String cleanUrl = "https://${this!.substring(resIndex)}";
      return Uri.decodeFull(cleanUrl);
    }

    return this;
  }
}
