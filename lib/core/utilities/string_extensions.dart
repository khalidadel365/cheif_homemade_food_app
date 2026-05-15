import 'api_constants.dart';

extension ImageFormatter on String? {
  String? toCleanImageUrl() {
    if (this == null || this!.isEmpty) return null;

    int resIndex = this!.indexOf('res.cloudinary.com');
    if (resIndex != -1) {
      String cleanUrl = "https://${this!.substring(resIndex)}";
      return Uri.decodeFull(cleanUrl);
    }

    if (this!.startsWith('/')) {
      String baseUrl =
          ApiConstants.baseUrl!.endsWith('/')
              ? ApiConstants.baseUrl!.substring(
                0,
                ApiConstants.baseUrl!.length - 1,
              )
              : ApiConstants.baseUrl!;

      return "$baseUrl${this!}";
    }

    if (this!.startsWith('http')) {
      return this;
    }

    return this;
  }
}
