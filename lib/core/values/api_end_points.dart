abstract class ApiEndPoints {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";

  static const String login = '/auth/signin';
  static const String logout = '/auth/logout';
  static const String register = '/auth/signup';
  static const String forgetPassword = "/auth/forgotPassword";
  static const String resetPassword = "/auth/resetPassword";
  static const String verifyResetCode = "/auth/verifyResetCode";

  static const String getUserData = "/auth/profile-data";
  static const String categories = "/categories";
  static const String products = "/products";
  static const String home = "/home";
  static const String getOccasions = '/occasions';

  static const String editProfile = '/auth/editProfile';
  static const String uploadPhoto = '/auth/upload-photo';
  static const String changePassword = '/auth/change-password';
  static const String cart="/cart" ;

  static const userAddress = "/addresses";
  static const addressById = "$userAddress/{id}";

  static const String userNotifications = '/notifications/user';
  static const String unreadCount = '/notifications/unread-count';

  static const String getOrders = "/orders";
    static const String orders = 'orders';
  static const String cashOrderCheckout = "/cash-order";
  static const String creditCheckout = '$orders/checkout';
}
