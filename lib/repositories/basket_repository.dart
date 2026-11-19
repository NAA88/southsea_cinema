import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';

class BasketRepository {
  BasketRepository._internal();

  static final BasketRepository instance = BasketRepository._internal();

  final List<BasketItem> _items = [];

  List<BasketItem> getItems() {
    return List<BasketItem>.unmodifiable(_items);
  }

  void addItem(BasketItem item) {
    _items.add(item);
  }

  void removeItem(int index) {
    _items.removeAt(index);
  }

  void clear() {
    _items.clear();
  }

  double getServiceCharge() {
    if (_items.isEmpty) {
      return 0.0;
    }
    return serviceCharge;
  }

  double getTotal() {
    double total = getServiceCharge();
    for (final BasketItem item in _items) {
      total += item.lineTotal;
    }
    return total;
  }
}
