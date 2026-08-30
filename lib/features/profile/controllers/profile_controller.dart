import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/services/storage_service.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/icon_path.dart';
import '../../../features/authentication/presentation/widgets/auth_input.dart';
import '../../../features/shop/controllers/shop_controller.dart';
import '../../../features/shop/models/product_model.dart';
import '../../../routes/app_routes.dart';
import '../models/profile_models.dart';

class ProfileController extends GetxController {
  final isElite = false.obs;
  final annualSelected = false.obs;
  final expandedFaq = 0.obs;
  final topicExpanded = 0.obs;
  final ticketCategory = 'Orders & Shipping'.obs;
  final ticketRegarding = 'Orders & Shipping'.obs;
  final ticketFiles = <String>[].obs;
  final ticketReady = false.obs;
  final helpQuery = ''.obs;
  final topicQuery = ''.obs;
  final selectedAddressIndex = 0.obs;
  final editingIndex = (-1).obs;
  final savedAddresses = <SavedAddress>[].obs;
  final mapTransform = TransformationController();
  final addressFormKey = GlobalKey();
  final streetFocus = FocusNode();

  final helpSearch = TextEditingController();
  final topicSearch = TextEditingController();
  final ticketSubject = TextEditingController();
  final ticketOrder = TextEditingController();
  final ticketMessage = TextEditingController();
  final street = TextEditingController();
  final apt = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zip = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final profileName = 'Marcus Johnson'.obs;
  final profileEmail = 'marcus@omegapsi.org'.obs;
  final profilePhone = ''.obs;
  final profilePhotoPath = ''.obs;

  static const perks = [
    ElitePerk(
      icon: IconPath.elitePerkTruck,
      label: 'Up to \$10 Yard Shipping Credits monthly',
    ),
    ElitePerk(
      icon: IconPath.elitePerkTag,
      label: 'Member discounts on select items',
    ),
    ElitePerk(
      icon: IconPath.elitePerkZap,
      label: 'Early access to drops & collections',
    ),
    ElitePerk(icon: IconPath.elitePerkGift, label: 'Birthday rewards'),
    ElitePerk(icon: IconPath.elitePerkSupport, label: 'Priority support'),
    ElitePerk(
      icon: IconPath.elitePerkStar,
      label: 'Loyalty rewards & giveaways',
    ),
  ];

  static const orders = [
    ProfileOrder(
      id: 'D9-2024-88421',
      placed: 'Placed July 21, 2026',
      status: 'In Progress',
      total: 180.99,
    ),
    ProfileOrder(
      id: 'D9-2024-88421',
      placed: 'Placed July 21, 2026',
      status: 'Completed',
      total: 180.99,
    ),
    ProfileOrder(
      id: 'D9-2024-88421',
      placed: 'Placed July 21, 2026',
      status: 'Completed',
      total: 180.99,
    ),
    ProfileOrder(
      id: 'D9-2024-88421',
      placed: 'Placed July 21, 2026',
      status: 'Completed',
      total: 180.99,
    ),
  ];

  static const popularFaqs = [
    HelpFaq(
      question: 'How long does shipping take?',
      answer:
          'Standard shipping takes 3–7 business days. Express arrives in 1–2 days and Overnight by 10am the next day. Elite members receive \$10 in monthly shipping credits applied automatically to standard shipping at checkout.',
    ),
    HelpFaq(
      question: 'Is this product officially licensed?',
      answer:
          'Yes. Every product on The Yard is sold by officially licensed vendors. Look for the Licensed badge on product cards and vendor pages.',
    ),
    HelpFaq(
      question: 'How do I become a licensed vendor?',
      answer:
          'Apply through Vendor & Licensing Questions in Help Center. Our team reviews organization affiliation and licensing documents, typically within 5–7 business days.',
    ),
    HelpFaq(
      question: 'What are Yard Shipping Credits?',
      answer:
          'Elite members receive up to \$10 in shipping credits each billing cycle. Credits apply automatically to standard shipping at checkout and expire at the end of the cycle.',
    ),
    HelpFaq(
      question: 'How do I cancel my membership?',
      answer:
          'Open Profile → Membership and tap Cancel Membership. Benefits stay active through the end of your current billing period.',
    ),
  ];

  static const topics = [
    HelpTopic(
      id: 'orders',
      title: 'Orders & Shipping',
      icon: IconPath.helpTopicOrders,
      searchHint: 'Search Orders & Shipping...',
      faqs: [
        HelpFaq(
          question: 'Where is my order?',
          answer:
              "To track your order, go to Profile → Orders and select the relevant order. You'll see real-time tracking and an estimated delivery date. You can also use the 'Where's my order?' shortcut on the Help Center home page.",
        ),
        HelpFaq(
          question: 'How long does standard shipping take?',
          answer:
              'Standard shipping takes 3–7 business days. Express arrives in 1–2 days and Overnight by 10am the next day.',
        ),
        HelpFaq(
          question: 'Can I change or cancel my order after placing it?',
          answer:
              'You can request a change or cancellation from Order Details before the vendor ships. Once shipped, start a return after delivery.',
        ),
        HelpFaq(
          question: "My order shows delivered but I haven't received it.",
          answer:
              "Wait 24 hours, then open a ticket with your order number. We'll work with the carrier and vendor to locate the package.",
        ),
      ],
    ),
    HelpTopic(
      id: 'returns',
      title: 'Returns & Refunds',
      icon: IconPath.helpTopicReturns,
      searchHint: 'Search Returns & Refunds...',
      faqs: [
        HelpFaq(
          question: 'How do I start a return?',
          answer:
              'Open Profile → Orders, select a completed order, then tap Return. You can also use Start a Return from Help Center.',
        ),
        HelpFaq(
          question: 'How long do refunds take?',
          answer:
              'Refunds are issued within 5–7 business days after the return is received and approved.',
        ),
      ],
    ),
    HelpTopic(
      id: 'payments',
      title: 'Payments & Billing',
      icon: IconPath.helpTopicPay,
      searchHint: 'Search Payments & Billing...',
      faqs: [
        HelpFaq(
          question: 'What payment methods are accepted?',
          answer:
              'We accept Visa, Mastercard, American Express, and Discover. Cards are charged when you place the order.',
        ),
        HelpFaq(
          question: 'How do I update my card?',
          answer:
              'Open Profile → Payment Methods to add or change a card. Elite billing uses the card on file for membership.',
        ),
      ],
    ),
    HelpTopic(
      id: 'membership',
      title: 'Membership & Yard Elite',
      icon: IconPath.helpTopicElite,
      searchHint: 'Search Membership & Yard Elite...',
      faqs: [
        HelpFaq(
          question: 'What is The Yard Elite?',
          answer:
              'The Yard Elite is a membership with shipping credits, member discounts, early access, birthday rewards, and priority support.',
        ),
        HelpFaq(
          question: 'How do I cancel my membership?',
          answer:
              'Open Profile → Membership and tap Cancel Membership. Benefits stay active through the end of your current billing period.',
        ),
      ],
    ),
    HelpTopic(
      id: 'vendor',
      title: 'Vendor & Licensing Questions',
      icon: IconPath.helpTopicVendor,
      searchHint: 'Search Vendor & Licensing...',
      faqs: [
        HelpFaq(
          question: 'Is this product officially licensed?',
          answer:
              'Yes. Every product on The Yard is sold by officially licensed vendors. Look for the Licensed badge on product cards and vendor pages.',
        ),
        HelpFaq(
          question: 'How do I become a licensed vendor?',
          answer:
              'Open a ticket under Vendor & Licensing Questions with your organization affiliation and licensing documents.',
        ),
      ],
    ),
    HelpTopic(
      id: 'account',
      title: 'Account & Login',
      icon: IconPath.helpTopicAccount,
      searchHint: 'Search Account & Login...',
      faqs: [
        HelpFaq(
          question: 'How do I reset my password?',
          answer:
              'From Sign In, tap Forgot password and follow the email or phone verification steps.',
        ),
        HelpFaq(
          question: 'How do I update my profile?',
          answer:
              'Open Profile and tap the edit icon in the header to update your details.',
        ),
      ],
    ),
  ];

  static const defaultAddresses = [
    SavedAddress(
      label: 'Shipping Address',
      name: 'Marcus Johnson',
      street: '1247 Brotherhood Lane',
      apt: 'Apt 3B',
      city: 'Atlanta',
      state: 'GA',
      zip: '30301',
    ),
    SavedAddress(
      label: 'Shipping Address',
      name: 'Marcus Johnson',
      street: '88 Spelman Lane',
      apt: '',
      city: 'Atlanta',
      state: 'GA',
      zip: '30314',
    ),
  ];

  static const ticketCategories = [
    'Orders & Shipping',
    'Returns & Refunds',
    'Payments & Billing',
    'Membership & Yard Elite',
    'Vendor & Licensing Questions',
    'Account & Login',
  ];

  String get displayName => profileName.value;

  String get email => profileEmail.value;

  String get memberBadge {
    final letters = OrganizationLetters.fromName(
      StorageService.organizationName,
    );
    return '$letters Member';
  }

  String get joinPriceLabel =>
      annualSelected.value ? 'Join Elite \$99/yr' : 'Join Elite \$9.99/mo';

  String get upgradeLabel =>
      annualSelected.value ? 'Upgrade \$99/yr' : 'Upgrade \$9.99/mo';

  String get planName =>
      annualSelected.value ? 'Elite Annual' : 'Elite Monthly';

  String get planPrice => annualSelected.value ? '\$99/year' : '\$9.99/mo';

  List<HelpFaq> get filteredPopular {
    final query = helpQuery.value.trim().toLowerCase();
    if (query.isEmpty) return popularFaqs;
    return popularFaqs
        .where(
          (faq) =>
              faq.question.toLowerCase().contains(query) ||
              faq.answer.toLowerCase().contains(query),
        )
        .toList();
  }

  List<HelpTopic> get filteredTopics {
    final query = helpQuery.value.trim().toLowerCase();
    if (query.isEmpty) return topics;
    return topics
        .where((topic) => topic.title.toLowerCase().contains(query))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    isElite.value = StorageService.isElite;
    annualSelected.value = StorageService.eliteAnnual;
    profileName.value = StorageService.profileName;
    final remembered = StorageService.rememberedEmail;
    profileEmail.value =
        (remembered != null && remembered.contains('@'))
            ? remembered
            : 'marcus@omegapsi.org';
    profilePhone.value = StorageService.profilePhone;
    profilePhotoPath.value = StorageService.profilePhotoPath;
    ticketSubject.addListener(_syncTicket);
    ticketMessage.addListener(_syncTicket);
    _loadAddresses();
  }

  void _loadAddresses() {
    final stored = StorageService.savedAddressMaps
        .map(SavedAddress.fromJson)
        .where((address) => address.street.trim().isNotEmpty)
        .toList();
    savedAddresses.assignAll(
      stored.isEmpty ? defaultAddresses : stored,
    );
    final index = StorageService.selectedAddressIndex;
    selectedAddressIndex.value =
        index.clamp(0, savedAddresses.length - 1);
  }

  Future<void> _persistAddresses() async {
    await StorageService.setSavedAddresses(
      addresses: savedAddresses.map((address) => address.toJson()).toList(),
      selectedIndex: selectedAddressIndex.value,
    );
  }

  void _syncTicket() {
    ticketReady.value =
        ticketSubject.text.trim().isNotEmpty &&
        ticketMessage.text.trim().isNotEmpty;
  }

  void selectAnnual(bool annual) {
    annualSelected.value = annual;
  }

  void toggleFaq(int index) {
    expandedFaq.value = expandedFaq.value == index ? -1 : index;
  }

  void toggleTopicFaq(int index) {
    topicExpanded.value = topicExpanded.value == index ? -1 : index;
  }

  void openOrders() => Get.toNamed(AppRoute.myOrdersScreen);

  void openOrderDetails() => Get.toNamed(AppRoute.orderDetailsScreen);

  void openSaved() {
    if (Get.isRegistered<ShopController>()) {
      Get.find<ShopController>().selectTab(2);
    }
    if (Get.currentRoute != AppRoute.homeScreen) {
      Get.until((route) => route.settings.name == AppRoute.homeScreen);
    }
  }

  void openAddresses() => Get.toNamed(AppRoute.profileAddressesScreen);

  void openEditProfile() {
    nameController.text = profileName.value;
    emailController.text = profileEmail.value;
    phoneController.text = profilePhone.value;
    Get.toNamed(AppRoute.editProfileScreen);
  }

  void showPhotoPicker() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.maroonAccent,
                ),
                title: Text(
                  'Choose from gallery',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                  ),
                ),
                onTap: () {
                  Get.back();
                  pickProfilePhoto(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.maroonAccent,
                ),
                title: Text(
                  'Take a photo',
                  style: GoogleFonts.hankenGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBody,
                  ),
                ),
                onTap: () {
                  Get.back();
                  pickProfilePhoto(ImageSource.camera);
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> pickProfilePhoto(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1200,
      );
      if (picked == null) return;

      final dir = await getApplicationDocumentsDirectory();
      final dest = File(
        '${dir.path}/profile_avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await File(picked.path).copy(dest.path);

      final previous = profilePhotoPath.value;
      if (previous.isNotEmpty) {
        final oldFile = File(previous);
        if (oldFile.existsSync()) {
          await oldFile.delete();
        }
        await FileImage(oldFile).evict();
      }

      profilePhotoPath.value = dest.path;
      await StorageService.setProfilePhotoPath(dest.path);
    } catch (_) {
      showAuthMessage('Could not update photo. Please try again.');
    }
  }

  void saveProfile() {
    final name = nameController.text.trim();
    final mail = emailController.text.trim();
    final phone = phoneController.text.trim();
    if (name.isEmpty) {
      showAuthMessage('Please enter your full name');
      return;
    }
    if (!mail.contains('@')) {
      showAuthMessage('Please enter a valid email');
      return;
    }
    profileName.value = name;
    profileEmail.value = mail;
    profilePhone.value = phone;
    StorageService.setProfileName(name);
    StorageService.setRememberedEmail(mail);
    StorageService.setProfilePhone(phone);
    Get.back();
    showAuthMessage('Profile updated');
  }

  void openNotifications() => Get.toNamed(
    AppRoute.notificationScreen,
    arguments: {'fromProfile': true},
  );

  void selectAddress(int index) {
    if (index < 0 || index >= savedAddresses.length) return;
    selectedAddressIndex.value = index;
    _persistAddresses();
  }

  void editAddress(int index) {
    if (index < 0 || index >= savedAddresses.length) return;
    selectAddress(index);
    editingIndex.value = index;
    _fillForm(savedAddresses[index]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = addressFormKey.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 280),
          alignment: 0.15,
        );
      }
      streetFocus.requestFocus();
    });
  }

  void _fillForm(SavedAddress address) {
    street.text = address.street;
    apt.text = address.apt;
    city.text = address.city;
    state.text = address.state;
    zip.text = address.zip;
  }

  void clearAddressForm() {
    editingIndex.value = -1;
    street.clear();
    apt.clear();
    city.clear();
    state.clear();
    zip.clear();
  }

  void zoomMap(double factor) {
    final scale = mapTransform.value.getMaxScaleOnAxis();
    final next = (scale * factor).clamp(1.0, 4.0);
    mapTransform.value = Matrix4.identity()..scale(next);
  }

  void resetMap() {
    mapTransform.value = Matrix4.identity();
  }

  void openMembership() {
    if (isElite.value) {
      Get.toNamed(AppRoute.eliteMembershipScreen);
    } else {
      Get.toNamed(AppRoute.eliteJoinScreen);
    }
  }

  void openHelp() => Get.toNamed(AppRoute.helpCenterScreen);

  void openTopic(HelpTopic topic) {
    topicExpanded.value = 0;
    topicQuery.value = '';
    topicSearch.clear();
    ticketRegarding.value = topic.title;
    ticketCategory.value = topic.title;
    Get.toNamed(AppRoute.helpTopicScreen, arguments: topic);
  }

  void openTicket({String? regarding}) {
    if (regarding != null) {
      ticketRegarding.value = regarding;
      ticketCategory.value = regarding;
    }
    ticketSubject.clear();
    ticketOrder.clear();
    ticketMessage.clear();
    ticketFiles.clear();
    ticketReady.value = false;
    Get.toNamed(AppRoute.helpTicketScreen);
  }

  void clearRegarding() {
    ticketRegarding.value = '';
  }

  Future<void> attachTicketFile() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (picked == null) return;
      ticketFiles.add(picked.name);
    } catch (_) {
      showAuthMessage('Could not attach photo. Please try again.');
    }
  }

  void submitTicket() {
    if (!ticketReady.value) {
      showAuthMessage('Add a subject and message');
      return;
    }
    showAuthMessage('Ticket submitted');
    Get.back();
  }

  void joinElite() {
    isElite.value = true;
    StorageService.setElite(true);
    StorageService.setEliteAnnual(annualSelected.value);
    Get.offNamed(AppRoute.eliteWelcomeScreen);
  }

  void startShopping() {
    if (Get.isRegistered<ShopController>()) {
      Get.find<ShopController>().selectTab(0);
    }
    Get.until((route) => route.settings.name == AppRoute.homeScreen);
  }

  void cancelMembership() {
    isElite.value = false;
    StorageService.setElite(false);
    Get.until((route) => route.settings.name == AppRoute.homeScreen);
    showAuthMessage('Membership canceled');
  }

  void saveAddress() {
    final streetText = street.text.trim();
    final cityText = city.text.trim();
    final stateText = state.text.trim().toUpperCase();
    final zipText = zip.text.trim();
    if (streetText.isEmpty ||
        cityText.isEmpty ||
        stateText.isEmpty ||
        zipText.isEmpty) {
      showAuthMessage('Please complete your delivery address');
      return;
    }

    final next = SavedAddress(
      label: 'Shipping Address',
      name: displayName,
      street: streetText,
      apt: apt.text.trim(),
      city: cityText,
      state: stateText,
      zip: zipText,
    );

    if (editingIndex.value >= 0 &&
        editingIndex.value < savedAddresses.length) {
      savedAddresses[editingIndex.value] = next;
      selectedAddressIndex.value = editingIndex.value;
      showAuthMessage('Address updated');
    } else {
      savedAddresses.add(next);
      selectedAddressIndex.value = savedAddresses.length - 1;
      showAuthMessage('Address saved');
    }
    savedAddresses.refresh();
    _persistAddresses();
    clearAddressForm();
    resetMap();
  }

  Future<void> logOut() async {
    if (Get.isRegistered<ShopController>()) {
      Get.find<ShopController>().selectTab(0);
    }
    await StorageService.logoutUser();
    Get.offAllNamed(AppRoute.signInScreen);
  }

  @override
  void onClose() {
    helpSearch.dispose();
    topicSearch.dispose();
    ticketSubject.dispose();
    ticketOrder.dispose();
    ticketMessage.dispose();
    street.dispose();
    apt.dispose();
    city.dispose();
    state.dispose();
    zip.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    streetFocus.dispose();
    mapTransform.dispose();
    super.onClose();
  }
}
