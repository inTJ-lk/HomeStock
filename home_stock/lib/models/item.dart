class Item{
  
  final String name;
  final String category;
  final String metric;
  final int quantity;
  final int inShoppingList;

  Item({this.name, this.category, this.metric, this.quantity, this.inShoppingList});


  factory Item.fromJson(Map<String, dynamic> parsedJson){
    print('lol ${parsedJson['name']}');
    return Item(name: parsedJson['name'],
      quantity: parsedJson['quantity'],
      metric: parsedJson['metric'],
      category: parsedJson['category'],
      inShoppingList: parsedJson['inShoppingList']
    );
  }

}