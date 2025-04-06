class Tool {
  final String name;
  final String category;
  final double price;

  Tool({required this.name, required this.category, required this.price});
}

List<Tool> tools = [
  Tool(name: "Tractor", category: "Tools", price: 5000),
  Tool(name: "Plow", category: "Tools", price: 800),
  Tool(name: "Irrigation Pump", category: "Tools", price: 1200),
  Tool(name: "Organic Fertilizer", category: "Fertilizers", price: 50),
  Tool(name: "Pesticide Spray", category: "Pesticides", price: 60),
  Tool(name: "Seed Drill", category: "Tools", price: 300),
  Tool(name: "Harvesting Machine", category: "Tools", price: 10000),
  Tool(name: "Auto Mist Sprayer", category: "Pesticides", price: 200),
  Tool(name: "Compost", category: "Fertilizers", price: 30),
];
