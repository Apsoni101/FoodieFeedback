class RoutePaths {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String auth = '/register';

  static const String restaurantsListingTab = '/restaurantsListingTab';
  static const String settings = 'settings';

  static const String restaurantsAdding = 'add';
  static const String restaurantsDetail = 'detail';
  static const String addReview = 'add-review';

  static const String loginTab = 'login';
  static const String registerTab = 'register';

  static String restaurantDetailWithId(final String id) =>
      '$restaurantsListingTab/$restaurantsDetail?id=$id';

  static String addReviewWithRestaurantId(final String restaurantId) =>
      '$restaurantsListingTab/$addReview?restaurantId=$restaurantId';

  static String settingsPath() => '$restaurantsListingTab/$settings';
}
