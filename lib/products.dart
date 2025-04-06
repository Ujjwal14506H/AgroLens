class Product {
  final String title;
  final String category;
  final String imagePath;
  final String description;
  final double price;

  Product({
    required this.title,
    required this.category,
    required this.imagePath,
    required this.description,
    required this.price,
  });
}

class ProductData {
  static List<Product> getProducts() {
    return [
      Product(
        title: "Plough",
        category: "Machinery",
        imagePath: "assets/images/Plough.png",
        description:
            "The AGRIONA Hydraulic Reversible MB Plough is a robust agricultural implement designed for efficient soil preparation.\n\n"
            "• Hydraulic Reversibility: Effortless switching between left and right furrows for better efficiency.\n"
            "• Durable Construction: Made from boron steel for longevity.\n"
            "• Efficient Soil Inversion and Aeration: Enhances soil quality for healthier crops.\n"
            "• Versatile: Works well in different soil types.\n"
            "• Adjustable Furrow Width: Customizable for specific farming needs.",
        price: 25000.0,
      ),
      Product(
        title: "Rotavator",
        category: "Machinery",
        imagePath: "assets/images/Rotavator.png",
        description:
            "The Shaktiman Rotavator 42 Blade is a high-performance tillage tool for efficient soil preparation.\n\n"
            "• Heavy-Duty 42 Blades: Ensures deep and uniform tillage.\n"
            "• Fuel-Efficient: Reduces fuel consumption while maximizing productivity.\n"
            "• Adjustable Depth Control: Provides flexibility for different soil types.\n"
            "• Durable Build: High-strength steel components for long-lasting use.\n"
            "• Ideal for Seedbed Preparation: Enhances soil aeration and moisture retention.",
        price: 75000.0,
      ),
      Product(
        title: "Irrigation Pump",
        category: "Irrigation",
        imagePath: "assets/images/irrigation.png",
        description: "High-capacity water pump for irrigation purposes.",
        price: 35000.0,
      ),
      Product(
        title: "Sprayer Machine",
        category: "Irrigation",
        imagePath: "assets/images/sprayer.png",
        description: "Portable sprayer for pesticides and fertilizers.",
        price: 15000.0,
      ),
      Product(
        title: "Seeder Machine",
        category: "Machinery",
        imagePath: "assets/images/Seeder.png",
        description: "Precision seeder for accurate seed placement.",
        price: 45000.0,
      ),
      Product(
        title: "Harvester",
        category: "Machinery",
        imagePath: "assets/images/Harvester.png",
        description: "Automatic harvester for efficient crop harvesting.",
        price: 1200000.0,
      ),
      Product(
        title: "Drip Irrigation Kit",
        category: "Irrigation",
        imagePath: "assets/images/Drip.png",
        description: "Complete drip irrigation system for water efficiency.",
        price: 20000.0,
      ),
      Product(
        title: "Solar Water Pump",
        category: "Irrigation",
        imagePath: "assets/images/Solar.png",
        description: "Energy-efficient solar-powered water pump.",
        price: 180000.0,
      ),
    ];
  }
}
