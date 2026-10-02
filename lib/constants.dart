import 'package:flutter/material.dart';

const String appTitle = 'Southsea Cinema';

const Color cinemaBrand = Color(0xFF55BEDE);
const Color cinemaBrandLight = Color(0xFF7FCEE6);
const Color cinemaBrandDark = Color(0xFF3FB5D9);

const Color cinemaBackground = Color(0xFF1B1E28);
const Color cinemaFontWhite = Color(0xFFFFFFFF);
const Color cinemaFontMuted = Color(0xFF8A90A0);
const Color cinemaSurface = Color(0xFF242936);

const TextStyle cinemaHeaderStyle = TextStyle(
  color: cinemaFontWhite,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const TextStyle cinemaFilmTitleStyle = TextStyle(
  color: cinemaFontWhite,
  fontSize: 28,
  fontWeight: FontWeight.w300,
);

const TextStyle cinemaBodyStyle = TextStyle(
  color: cinemaFontWhite,
  fontSize: 14,
);

const TextStyle cinemaMutedStyle = TextStyle(
  color: cinemaFontMuted,
  fontSize: 14,
);

const int maxTickets = 5; // Maximum number of tickets a user can book at once
const double adultTicketPrice = 8.00; // Price of an adult ticket
