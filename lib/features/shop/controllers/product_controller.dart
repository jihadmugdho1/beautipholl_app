import 'package:get/get.dart';

class ProductController extends GetxController {
  final isElite = false.obs;
  final productId = 'p1'.obs;
  final selectedColor = 0.obs;
  final selectedSize = 'M'.obs;
  final quantity = 1.obs;
  final selectedThumb = 0.obs;
  final sizeGuideOpen = true.obs;
  final expandedFaq = Rxn<int>();

  static const colors = [
    ColorSwatchOption(0xFF4B2E83),
    ColorSwatchOption(0xFFC9A84C),
    ColorSwatchOption(0xFF7B2233),
  ];

  static const sizes = ['XS', 'S', 'M', 'L', 'XL', '2XL'];

  static const faqs = [
    (
      'Is this true to size?',
      'Yes. This crewneck fits true to size. The model is 6\'0" and wears size M.',
    ),
    (
      'Can I rush production?',
      'Rush production is available on request. Most rush orders ship in 2 business days.',
    ),
    (
      'Do you ship internationally?',
      'Yes. International shipping is available at checkout with calculated rates.',
    ),
    (
      'Can I cancel or change my order?',
      'You can cancel or change an order before production starts. Contact the vendor as soon as possible.',
    ),
  ];

  static const sizeRows = [
    ['XS', '32–34', '26'],
    ['S', '35–37', '27'],
    ['M', '38–40', '28'],
    ['L', '41–43', '29'],
    ['XL', '44–46', '30'],
    ['2XL', '47–49', '31'],
  ];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      if (args['isElite'] == true) isElite.value = true;
      final id = args['productId'];
      if (id is String && id.isNotEmpty) productId.value = id;
    }
  }

  void selectColor(int index) => selectedColor.value = index;

  void selectSize(String size) => selectedSize.value = size;

  void incrementQty() => quantity.value++;

  void decrementQty() {
    if (quantity.value > 1) quantity.value--;
  }

  void selectThumb(int index) => selectedThumb.value = index;

  void toggleSizeGuide() => sizeGuideOpen.toggle();

  void toggleFaq(int index) {
    expandedFaq.value = expandedFaq.value == index ? null : index;
  }
}

class ColorSwatchOption {
  const ColorSwatchOption(this.value);
  final int value;
}
