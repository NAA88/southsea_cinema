import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

  @override
  State<MovieListing> createState() {
    return _MovieListingState();
  }
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 1;
  String _bookingFeedback = '';

  void _addToOrder() {
    final BasketItem item = BasketItem(
      movie: widget.movie,
      quantity: _ticketQuantity,
    );
    BasketRepository.instance.addItem(item);

    final String ticketWord;
    if (_ticketQuantity == 1) {
      ticketWord = 'ticket';
    } else {
      ticketWord = 'tickets';
    }
    setState(() {
      _bookingFeedback = 'Added $_ticketQuantity $ticketWord for '
          '${widget.movie.title} to your order.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.movie.title.toUpperCase()} (${widget.movie.ageRating})',
              style: cinemaFilmTitleStyle,
            ),
            const SizedBox(height: 12),
            Image.asset(
              widget.movie.posterPath,
              width: 150,
              height: 225,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            const Text(filmVenue, style: cinemaBodyStyle),
            const SizedBox(height: 4),
            Text(widget.movie.screeningTime, style: cinemaBodyStyle),
            const SizedBox(height: 12),
            Text(widget.movie.synopsis, style: cinemaBodyStyle),
            const SizedBox(height: 16),
            const Text(
              'Select Quantities (Up to $maxTickets in total)',
              style: cinemaBodyStyle,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DropdownMenu<int>(
                  width: 120,
                  initialSelection: _ticketQuantity,
                  dropdownMenuEntries: List.generate(
                    maxTickets,
                    (int index) {
                      return DropdownMenuEntry<int>(
                        value: index + 1,
                        label: '${index + 1}',
                      );
                    },
                  ),
                  onSelected: (int? value) {
                    if (value != null) {
                      setState(() {
                        _ticketQuantity = value;
                      });
                    }
                  },
                ),
                const SizedBox(width: 12),
                Text(
                  'Tickets (${widget.movie.formattedPrice} each)',
                  style: cinemaBodyStyle,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Tickets selected: $_ticketQuantity', style: cinemaMutedStyle),
            const SizedBox(height: 16),
            CinemaButton(label: 'ADD TO ORDER', onPressed: _addToOrder),
            if (_bookingFeedback.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                _bookingFeedback,
                style: const TextStyle(color: cinemaBrand),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
