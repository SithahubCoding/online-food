class FoodModel {
  final int id;
  final String name;
  final String image;
  final String description;
  final String category;
  final double price;
  final double rating;

  // Main constructor (manual creation)
  FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rating,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'category': category,
      'price': price,
      'rating': rating,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
      rating: map['rating'],
    );
  }
  // Factory constructor (dummy data, auto fills some fields)
}

// Example food list
List<FoodModel> foods = [
  FoodModel(
    id: 1,
    name: "Burger",
    description: "Juicy burger with cheese",
    price: 3.5,
    category: "Fast Food",
    image: "assets/images/burger.png",
    rating: 4.5,
  ),
  FoodModel(
    id: 2,
    name: "Pizza",
    description: "Cheesy pizza with toppings",
    price: 5.0,
    category: "Italian",
    image: "assets/images/pizza.png",
    rating: 4.7,
  ),
  FoodModel(
    id: 3,
    name: "Fried Chicken",
    description: "Crispy fried chicken",
    price: 4.0,
    category: "Fast Food",
    image: "assets/images/burger.png",
    rating: 4.3,
  ),
  FoodModel(
    id: 4,
    name: "Sushi",
    description: "Fresh sushi rolls",
    price: 6.0,
    category: "Japanese",
    image: "assets/images/burger.png",
    rating: 4.8,
  ),
  FoodModel(
    id: 4,
    name: "Sushi",
    description: "Fresh sushi rolls",
    price: 6.0,
    category: "Japanese",
    image: "assets/images/burger.png",
    rating: 4.8,
  ),
  FoodModel(
    id: 4,
    name: "Sushi",
    description: "Fresh sushi rolls",
    price: 6.0,
    category: "Japanese",
    image: "assets/images/burger.png",
    rating: 4.8,
  ),
  FoodModel(
    id: 4,
    name: "Sushi",
    description: "Fresh sushi rolls",
    price: 6.0,
    category: "Japanese",
    image: "assets/images/burger.png",
    rating: 4.8,
  ),
  FoodModel(
    id: 4,
    name: "Sushi",
    description: "Fresh sushi rolls",
    price: 6.0,
    category: "Japanese",
    image: "assets/images/burger.png",
    rating: 4.8,
  ),
];

class CategoryModel {
  final String name;
  final String icon;
  final List<SubCategory> subCategories;
  CategoryModel({required this.name, required this.icon, required this.subCategories});
}
class SubCategory {
  final String name;
  final String icon;

  SubCategory({required this.name, required this.icon});
}

final List<CategoryModel> categories = [
  CategoryModel(
    name: "Burger",
    icon: "assets/images/burger.png",
    subCategories: [
      SubCategory(name: "Cheese Burger", icon: "assets/images/cheese_burger.png"),
      SubCategory(name: "Veggie Burger", icon: "assets/images/veggie_burger.png"),
      SubCategory(name: "Chicken Burger", icon: "assets/images/buger_checken.jpg"),
    ],
  ),
  CategoryModel(
    name: "Pizza",
    icon: "assets/images/pizza.png",
    subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni_pizza.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],
  ),
  CategoryModel(
    name: "Sandwich",
    icon: "assets/images/sandwich.png",
    subCategories: [
      SubCategory(name: "Club Sandwich", icon: "assets/images/club_sandwich.png"),
      SubCategory(name: "Egg Sandwich", icon: "assets/images/egg_sandwich.png"),
    ],
  ),
  CategoryModel(
    name: "Donut",
    icon: "assets/images/donut.png",
    subCategories: [
      SubCategory(name: "Chocolate Donut", icon: "assets/images/choco_donut.png"),
      SubCategory(name: "Strawberry Donut", icon: "assets/images/strawberry_donut.png"),
    ],
  ),
  CategoryModel(
    name: "Chips",
    icon: "assets/images/chips.png",
    subCategories: [
      SubCategory(name: "Potato Chips", icon: "assets/images/potato_chips.png"),
      SubCategory(name: "Tortilla Chips", icon: "assets/images/tortilla_chips.png"),
    ],
  ),
  CategoryModel(name: "Burger", icon: "assets/images/burger.png", subCategories: [
      SubCategory(name: "Cheese Burger", icon: "assets/images/cheese_burger.png"),
      SubCategory(name: "Veggie Burger", icon: "assets/images/veggie_burger.png"),
      SubCategory(name: "Chicken Burger", icon: "assets/images/chicken_burger.png"),
    ],
  ),
  CategoryModel(name: "Pizza", icon: "assets/images/pizza.png", subCategories: [
      SubCategory(name: "Cheese Burger", icon: "assets/images/cheese_burger.png"),
      SubCategory(name: "Veggie Burger", icon: "assets/images/veggie_burger.png"),
      SubCategory(name: "Chicken Burger", icon: "assets/images/chicken_burger.png"),
  ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/sandwich.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/donut.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/chips.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/noodel.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/nuggets.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Drinks", icon: "assets/images/drink.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Desserts", icon: "assets/images/dessert.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Burger", icon: "assets/images/burger.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Pizza", icon: "assets/images/pizza.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/sandwich.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/donut.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/chips.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/noodel.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Sandwich", icon: "assets/images/nuggets.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Drinks", icon: "assets/images/drink.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
  CategoryModel(name: "Desserts", icon: "assets/images/dessert.png",  subCategories: [
      SubCategory(name: "Pepperoni Pizza", icon: "assets/images/pepperoni.png"),
      SubCategory(name: "Veggie Pizza", icon: "assets/images/veggie_pizza.png"),
    ],),
];
