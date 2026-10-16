import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

const String filmTitle = "Nosferatu";
const String filmDescription =
    "An American Gothic horror film written and directed by Robert Eggers. "
    "It is a remake of Nosferatu: A Symphony of Horror (1922), which was in "
    "turn inspired by Bram Stoker's novel Dracula (1897); the film combines "
    "elements of both. A gothic tale of obsession between a haunted young "
    "woman and the terrifying vampire infatuated with her, causing untold "
    "horror in its wake.";

const int filmYear = 2024;
const String filmAgeRating = "18";
const int filmRuntimeMinutes = 133;
const String filmDirector = "Robert Eggers";
const String filmCast =
    "Bill Skarsgård, Nicholas Hoult, Lily-Rose Depp, Aaron Taylor-Johnson";
const String filmVenue = "Southsea Cinema Room";
const String filmScreening = 'Sunday 18 Oct 2026, 14:00 - ends at 16:13';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

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
          // Wraps the content in a SingleChildScrollView to make it scrollable
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$filmTitle ($filmYear) ($filmAgeRating)',
                  style: cinemaFilmTitleStyle,
                ),
                SizedBox(
                    height:
                        4), // Adds a small space between the title and the next line
                Text(
                  '$filmRuntimeMinutes min · Dir. $filmDirector',
                  style: cinemaMutedStyle,
                ), // Displays the runtime and director information
                SizedBox(height: 12),
                Text(filmDescription, style: cinemaBodyStyle),
                SizedBox(height: 8),
                Text('Starring: $filmCast', style: cinemaMutedStyle),
                SizedBox(height: 16),
                Text('BOOK TICKETS', style: cinemaHeaderStyle),
                Divider(),
                Text(filmVenue, style: cinemaBodyStyle),
                SizedBox(height: 4),
                Text(filmScreening, style: cinemaBodyStyle),
                SizedBox(height: 12),
                BookingSection(), // Custom widget for booking tickets
              ],
            ),
          ),
        ));
  }
}

class BookingSection extends StatefulWidget {
  const BookingSection({super.key});

  @override
  State<BookingSection> createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {
  // State class for the BookingSection widget
  int _ticketQuantity = 1; // Default ticket quantity
  String _bookingFeedback = '';

  void _addToOrder() {
    final String ticketWord = _ticketQuantity == 1 ? 'ticket' : 'tickets';
    setState(() {
      _bookingFeedback =
          'Added $_ticketQuantity $ticketWord for $filmTitle to your order.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Quantities (Up to $maxTickets in total)',
          style: cinemaBodyStyle,
        ),
        const SizedBox(height: 16),
        Text(
          'Tickets',
          style: cinemaBodyStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
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
                // Update the ticket quantity when a new value is selected
                if (value != null) {
                  setState(() {
                    _ticketQuantity = value;
                  });
                }
              },
            ),
            const SizedBox(width: 12),
            Text(
              'Adult (£${adultTicketPrice.toStringAsFixed(2)})',
              style: cinemaBodyStyle,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text('Tickets selected: $_ticketQuantity', style: cinemaMutedStyle),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addToOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: cinemaBrand,
            foregroundColor: cinemaFontWhite,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
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
    );
  }
}
