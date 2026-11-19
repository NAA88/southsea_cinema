import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() {
    return _BasketViewState();
  }
}

class _BasketViewState extends State<BasketView> {
  String _confirmationMessage = '';

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Text('Your basket is empty', style: cinemaMutedStyle),
      ),
    );
  }

  Widget _buildHeaderRow() {
    const TextStyle headerStyle = TextStyle(
      color: cinemaFontWhite,
      fontWeight: FontWeight.bold,
    );

    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 90, child: Text('Item', style: headerStyle)),
          Expanded(child: Text('Details', style: headerStyle)),
          Text('Price', style: headerStyle),
          SizedBox(width: 56),
        ],
      ),
    );
  }

  Widget _buildLineItem(BasketRepository basket, BasketItem item, int index) {
    final String ticketWord;
    if (item.quantity == 1) {
      ticketWord = 'Ticket';
    } else {
      ticketWord = 'Tickets';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '${item.quantity} $ticketWord',
              style: const TextStyle(
                color: cinemaBrand,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${item.quantity} Standard\n'
              '${item.movie.title.toUpperCase()}, '
              '${item.movie.screeningTime}, $filmVenue',
              style: cinemaBodyStyle,
            ),
          ),
          Text(
            '£${item.lineTotal.toStringAsFixed(2)}',
            style: cinemaBodyStyle,
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: cinemaFontWhite),
            style: IconButton.styleFrom(
              backgroundColor: cinemaBrand,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            onPressed: () {
              setState(() {
                basket.removeItem(index);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool emphasise = false}) {
    final TextStyle style;
    if (emphasise) {
      style = cinemaHeaderStyle;
    } else {
      style = cinemaBodyStyle;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  Widget _buildBasketList(BasketRepository basket, List<BasketItem> items) {
    final List<Widget> children = [];

    children.add(const Text('MY ORDER', style: cinemaHeaderStyle));
    children.add(const SizedBox(height: 16));
    children.add(_buildHeaderRow());

    for (int index = 0; index < items.length; index++) {
      final BasketItem item = items[index];
      children.add(_buildLineItem(basket, item, index));
    }

    children.add(const SizedBox(height: 16));
    children.add(
      _buildTotalRow(
        'Service Charge',
        '£${basket.getServiceCharge().toStringAsFixed(2)}',
      ),
    );
    children.add(
      _buildTotalRow(
        'Total Due',
        '£${basket.getTotal().toStringAsFixed(2)}',
        emphasise: true,
      ),
    );
    children.add(const SizedBox(height: 24));

    children.add(
      Align(
        alignment: Alignment.centerRight,
        child: CinemaButton(
          label: 'BUY TICKETS',
          onPressed: () {
            setState(() {
              basket.clear();
              _confirmationMessage = 'Thank you, your tickets are booked.';
            });
          },
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final BasketRepository basket = BasketRepository.instance;
    final List<BasketItem> items = basket.getItems();

    final Widget content;
    if (items.isEmpty) {
      if (_confirmationMessage.isNotEmpty) {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmptyState(),
            const SizedBox(height: 12),
            Text(
              _confirmationMessage,
              style: const TextStyle(color: cinemaBrand),
            ),
          ],
        );
      } else {
        content = _buildEmptyState();
      }
    } else {
      content = _buildBasketList(basket, items);
    }

    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}
