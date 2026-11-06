import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

const String filmVenue = 'Southsea Cinema Room';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 1;
  String _bookingFeedback = '';

  void _addToOrder() {
    final String ticketWord = _ticketQuantity == 1 ? 'ticket' : 'tickets';
    setState(() {
      _bookingFeedback = 'Added $_ticketQuantity $ticketWord for '
          '${widget.movie.title} to your order.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
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
                    (index) => DropdownMenuEntry<int>(
                      value: index + 1,
                      label: '${index + 1}',
                    ),
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
            ElevatedButton(
              onPressed: _addToOrder,
              style: cinemaButtonStyle,
              child: const Text('ADD TO ORDER'),
            ),
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
