import 'package:get/get.dart';

import '../features/authentication/controllers/biometric_controller.dart';
import '../features/authentication/controllers/interest_controller.dart';
import '../features/authentication/controllers/notification_controller.dart';
import '../features/authentication/controllers/organization_controller.dart';
import '../features/authentication/controllers/otp_controller.dart';
import '../features/authentication/controllers/reset_password_controller.dart';
import '../features/authentication/controllers/set_password_controller.dart';
import '../features/authentication/controllers/sign_in_controller.dart';
import '../features/authentication/controllers/sign_up_controller.dart';
import '../features/authentication/controllers/welcome_controller.dart';
import '../features/authentication/presentation/screens/biometric_screen.dart';
import '../features/authentication/presentation/screens/interest_screen.dart';
import '../features/authentication/presentation/screens/notification_screen.dart';
import '../features/authentication/presentation/screens/organization_screen.dart';
import '../features/authentication/presentation/screens/otp_verify_screen.dart';
import '../features/authentication/presentation/screens/reset_password_screen.dart';
import '../features/authentication/presentation/screens/set_password_screen.dart';
import '../features/authentication/presentation/screens/sign_in_screen.dart';
import '../features/authentication/presentation/screens/sign_up_screen.dart';
import '../features/authentication/presentation/screens/welcome_screen.dart';
import '../features/onboarding/controllers/onboarding_controller.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/cart/controllers/checkout_controller.dart';
import '../features/cart/presentation/screens/delivery_address_screen.dart';
import '../features/cart/presentation/screens/delivery_screen.dart';
import '../features/cart/presentation/screens/dispute_screen.dart';
import '../features/cart/presentation/screens/dispute_submit_screen.dart';
import '../features/cart/presentation/screens/order_confirmed_screen.dart';
import '../features/cart/presentation/screens/order_details_screen.dart';
import '../features/cart/presentation/screens/order_vendor_screen.dart';
import '../features/cart/presentation/screens/payment_screen.dart';
import '../features/cart/presentation/screens/return_details_screen.dart';
import '../features/cart/presentation/screens/return_list_screen.dart';
import '../features/cart/presentation/screens/review_screen.dart';
import '../features/cart/presentation/screens/vendor_sent_screen.dart';
import '../features/shop/controllers/contact_vendor_controller.dart';
import '../features/shop/controllers/product_controller.dart';
import '../features/shop/controllers/shop_controller.dart';
import '../features/shop/presentation/screens/contact_inquiry_screen.dart';
import '../features/shop/presentation/screens/contact_vendor_screen.dart';
import '../features/shop/presentation/screens/main_shell.dart';
import '../features/shop/presentation/screens/product_details_screen.dart';
import '../features/shop/presentation/screens/vendor_screen.dart';
import '../features/profile/controllers/profile_controller.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/profile/presentation/screens/elite_cancel_screen.dart';
import '../features/profile/presentation/screens/elite_join_screen.dart';
import '../features/profile/presentation/screens/elite_membership_screen.dart';
import '../features/profile/presentation/screens/elite_welcome_screen.dart';
import '../features/profile/presentation/screens/help_center_screen.dart';
import '../features/profile/presentation/screens/help_ticket_screen.dart';
import '../features/profile/presentation/screens/help_topic_screen.dart';
import '../features/profile/presentation/screens/my_orders_screen.dart';
import '../features/profile/presentation/screens/profile_addresses_screen.dart';

class AppRoute {
  static const String onboardingScreen = '/onboardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String signInScreen = '/signInScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String otpVerifyScreen = '/otpVerifyScreen';
  static const String setPasswordScreen = '/setPasswordScreen';
  static const String organizationScreen = '/organizationScreen';
  static const String interestScreen = '/interestScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String biometricScreen = '/biometricScreen';
  static const String welcomeScreen = '/welcomeScreen';
  static const String homeScreen = '/homeScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String vendorScreen = '/vendorScreen';
  static const String contactVendorScreen = '/contactVendorScreen';
  static const String contactInquiryScreen = '/contactInquiryScreen';
  static const String deliveryAddressScreen = '/deliveryAddressScreen';
  static const String deliveryScreen = '/deliveryScreen';
  static const String paymentScreen = '/paymentScreen';
  static const String reviewScreen = '/reviewScreen';
  static const String orderConfirmedScreen = '/orderConfirmedScreen';
  static const String orderDetailsScreen = '/orderDetailsScreen';
  static const String disputeScreen = '/disputeScreen';
  static const String disputeSubmitScreen = '/disputeSubmitScreen';
  static const String orderVendorScreen = '/orderVendorScreen';
  static const String vendorSentScreen = '/vendorSentScreen';
  static const String returnListScreen = '/returnListScreen';
  static const String returnDetailsScreen = '/returnDetailsScreen';
  static const String myOrdersScreen = '/myOrdersScreen';
  static const String profileAddressesScreen = '/profileAddressesScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String eliteJoinScreen = '/eliteJoinScreen';
  static const String eliteWelcomeScreen = '/eliteWelcomeScreen';
  static const String eliteMembershipScreen = '/eliteMembershipScreen';
  static const String eliteCancelScreen = '/eliteCancelScreen';
  static const String helpCenterScreen = '/helpCenterScreen';
  static const String helpTopicScreen = '/helpTopicScreen';
  static const String helpTicketScreen = '/helpTicketScreen';

  static String getOnboardingScreen() => onboardingScreen;
  static String getLoginScreen() => signInScreen;

  static List<GetPage> routes = [
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(OnboardingController.new);
      }),
    ),
    GetPage(
      name: loginScreen,
      page: () => const SignInScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignInController>(SignInController.new);
      }),
    ),
    GetPage(
      name: signInScreen,
      page: () => const SignInScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignInController>(SignInController.new);
      }),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignUpController>(SignUpController.new);
      }),
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ResetPasswordController>(ResetPasswordController.new);
      }),
    ),
    GetPage(
      name: otpVerifyScreen,
      page: () => const OtpVerifyScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OtpController>(OtpController.new);
      }),
    ),
    GetPage(
      name: setPasswordScreen,
      page: () => const SetPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SetPasswordController>(SetPasswordController.new);
      }),
    ),
    GetPage(
      name: organizationScreen,
      page: () => const OrganizationScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OrganizationController>(OrganizationController.new);
      }),
    ),
    GetPage(
      name: interestScreen,
      page: () => const InterestScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<InterestController>(InterestController.new);
      }),
    ),
    GetPage(
      name: notificationScreen,
      page: () => const NotificationScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NotificationPrefsController>(NotificationPrefsController.new);
      }),
    ),
    GetPage(
      name: biometricScreen,
      page: () => const BiometricScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<BiometricController>(BiometricController.new);
      }),
    ),
    GetPage(
      name: welcomeScreen,
      page: () => const WelcomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<WelcomeController>(WelcomeController.new);
      }),
    ),
    GetPage(
      name: homeScreen,
      page: () => const MainShell(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<ShopController>()) {
          Get.put(ShopController(), permanent: true);
        }
        if (!Get.isRegistered<CheckoutController>()) {
          Get.put(CheckoutController(), permanent: true);
        }
        if (!Get.isRegistered<ProfileController>()) {
          Get.put(ProfileController(), permanent: true);
        }
      }),
    ),
    GetPage(
      name: productDetailsScreen,
      page: () => const ProductDetailsScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<ProductController>()) {
          Get.delete<ProductController>();
        }
        Get.put(ProductController());
      }),
    ),
    GetPage(
      name: vendorScreen,
      page: () => const VendorScreen(),
    ),
    GetPage(
      name: contactVendorScreen,
      page: () => const ContactVendorScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<ContactVendorController>()) {
          Get.put(ContactVendorController());
        }
      }),
    ),
    GetPage(
      name: contactInquiryScreen,
      page: () => const ContactInquiryScreen(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<ContactVendorController>()) {
          Get.put(ContactVendorController());
        }
      }),
    ),
    GetPage(
      name: deliveryAddressScreen,
      page: () => const DeliveryAddressScreen(),
    ),
    GetPage(
      name: deliveryScreen,
      page: () => const DeliveryScreen(),
    ),
    GetPage(
      name: paymentScreen,
      page: () => const PaymentScreen(),
    ),
    GetPage(
      name: reviewScreen,
      page: () => const ReviewScreen(),
    ),
    GetPage(
      name: orderConfirmedScreen,
      page: () => const OrderConfirmedScreen(),
    ),
    GetPage(
      name: orderDetailsScreen,
      page: () => const OrderDetailsScreen(),
    ),
    GetPage(
      name: disputeScreen,
      page: () => const DisputeScreen(),
    ),
    GetPage(
      name: disputeSubmitScreen,
      page: () => const DisputeSubmitScreen(),
    ),
    GetPage(
      name: orderVendorScreen,
      page: () => const OrderVendorScreen(),
    ),
    GetPage(
      name: vendorSentScreen,
      page: () => const VendorSentScreen(),
    ),
    GetPage(
      name: returnListScreen,
      page: () => const ReturnListScreen(),
    ),
    GetPage(
      name: returnDetailsScreen,
      page: () => const ReturnDetailsScreen(),
    ),
    GetPage(
      name: myOrdersScreen,
      page: () => const MyOrdersScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
    GetPage(
      name: profileAddressesScreen,
      page: () => const ProfileAddressesScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
    GetPage(
      name: editProfileScreen,
      page: () => const EditProfileScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
    GetPage(
      name: eliteJoinScreen,
      page: () => const EliteJoinScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
    GetPage(
      name: eliteWelcomeScreen,
      page: () => const EliteWelcomeScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
    GetPage(
      name: eliteMembershipScreen,
      page: () => const EliteMembershipScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
    GetPage(
      name: eliteCancelScreen,
      page: () => const EliteCancelScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
    GetPage(
      name: helpCenterScreen,
      page: () => const HelpCenterScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
    GetPage(
      name: helpTopicScreen,
      page: () => const HelpTopicScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
    GetPage(
      name: helpTicketScreen,
      page: () => const HelpTicketScreen(),
      binding: BindingsBuilder(_ensureProfile),
    ),
  ];
}

void _ensureProfile() {
  if (!Get.isRegistered<ProfileController>()) {
    Get.put(ProfileController(), permanent: true);
  }
}
