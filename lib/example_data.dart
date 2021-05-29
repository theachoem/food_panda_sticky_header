class ExampleData {
  ExampleData._internal();

  static List<String> images = [
    "https://d1sag4ddilekf6.cloudfront.net/compressed/items/6-CYXCTZAEEEECJE-CZAYA3CERF5ETJ/photo/b44c9b4be5044923b3f5b8f8f6e7e55b_1581506444759847068.jpg",
    "https://d1sag4ddilekf6.cloudfront.net/compressed/items/6-CY21EXXWSEV2E2-CZKKV8MFGPUTMA/photo/321adfd29ded4d9eae3488848ecfbb05_1592997965388846905.jpg",
    "https://d1sag4ddilekf6.cloudfront.net/compressed/items/6-CY4ETPUKCCCYTX-CZAYA3BKLEN2KE/photo/8d2d5939ec5a42269a0d8ec3c0a97e44_1581506429557055566.jpg",
    "https://d1sag4ddilekf6.cloudfront.net/item/6-CY21EXXWUFW1CN-CZAYA25ZSEUJV6/photos/c3f51cd36f2344e28abae3a91b94ef9b_1581506376835073709.jpg",
    "https://d1sag4ddilekf6.cloudfront.net/compressed/items/6-CZADR6NJMB3UL6-CZADR6UYL65GSE/photo/d4e13ca45a4747b78364dcf643095124_1580377235610503360.jpg",
  ];

  static PageData data = PageData(
    title: "ខេនកាហ្វេតែគុជ (ជិតស្តុបឥន្រ្ទទេវី)\nCAN Caffee",
    deliverTime: "20 នាទី",
    bannerText:
        "ប្រើកូដ HELLOPANDA បញ្ចុះតម្លៃ 50% សម្រាប់ការកុម៉្មងលើកដំបូងចាប់ពី 4.5\$ ឡើងទៅ",
    backgroundUrl:
        "https://www.browncoffee.com.kh/uploads/ximg/item_menus/20210515062936c2531deff29845101d3f6f5691943c98.jpg",
    rate: 4.2,
    rateQuantity: 331,
    optionalCard: OptionalCard(
      title: "30% Discount",
      subtitle: "On the entire menu",
    ),
    categories: [
      category1,
      category2,
      category3,
      category4,
      category3,
      category4,
    ],
  );

  static Category category1 = Category(
    title: "ពេញនិយម",
    subtitle: "លក់ដាច់ជាងគេពេលនេះ",
    isHotSale: true,
    foods: List.generate(
      5,
      (index) {
        return Food(
          name: "សូកូឡាដូងក្រអូប",
          price: "1.33",
          comparePrice: "\$1.90",
          imageUrl: images[index % images.length],
          isHotSale: false,
        );
      },
    ),
  );

  static Category category2 = Category(
    title: "ទិញ១ថែម១",
    subtitle: "រងចាំយ៉ាងតិច 30នាទី",
    isHotSale: false,
    foods: List.generate(
      3,
      (index) {
        return Food(
          name: "សូកូឡាដូងក្រអូប",
          price: "1.33",
          comparePrice: "\$1.90",
          imageUrl: images[index % images.length],
          isHotSale: index == 2 ? true : false,
        );
      },
    ),
  );

  static Category category3 = Category(
    title: "តែរសជាតិ",
    subtitle: null,
    isHotSale: false,
    foods: List.generate(
      5,
      (index) {
        return Food(
          name: "សូកូឡាដូងក្រអូប",
          price: "1.33",
          comparePrice: "\$1.90",
          imageUrl: images[index % images.length],
          isHotSale: false,
        );
      },
    ),
  );

  static Category category4 = Category(
    title: "តែទឹកដោះគោ",
    subtitle: "លក់ដាច់ជាងគេពេលនេះ",
    isHotSale: false,
    foods: List.generate(
      5,
      (index) {
        return Food(
          name: "សូកូឡាដូងក្រអូប",
          price: "1.33",
          comparePrice: "\$1.90",
          imageUrl: images[index % images.length],
          isHotSale: index == 3 ? true : false,
        );
      },
    ),
  );
}

class PageData {
  String title;
  String deliverTime;
  String bannerText;
  String backgroundUrl;

  double rate;
  int rateQuantity;

  OptionalCard optionalCard;
  List<Category> categories;

  PageData({
    required this.title,
    required this.deliverTime,
    required this.bannerText,
    required this.backgroundUrl,
    required this.rate,
    required this.rateQuantity,
    required this.optionalCard,
    required this.categories,
  });
}

class OptionalCard {
  String title;
  String subtitle;
  OptionalCard({
    required this.title,
    required this.subtitle,
  });
}

class Category {
  String title;
  String? subtitle;
  List<Food> foods;
  bool isHotSale;

  Category({
    required this.title,
    required this.subtitle,
    required this.foods,
    required this.isHotSale,
  });
}

class Food {
  String name;
  String price;
  String comparePrice;
  String imageUrl;
  bool isHotSale;

  Food({
    required this.name,
    required this.price,
    required this.comparePrice,
    required this.imageUrl,
    required this.isHotSale,
  });
}
