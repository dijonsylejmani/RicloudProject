import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  List<int> selectedSeats = [];
  int? selectedRoute;
  Map<String, dynamic> passengerInfo = {};
  
  void toggleSeat(int seatNumber) {
    if (selectedSeats.contains(seatNumber)) {
      selectedSeats.remove(seatNumber);
    } else {
      selectedSeats.add(seatNumber);
    }
    notifyListeners();
  }
  
  void selectRoute(int routeId) {
    selectedRoute = routeId;
    notifyListeners();
  }
  
  void updatePassengerInfo(Map<String, dynamic> info) {
    passengerInfo = info;
    notifyListeners();
  }
  
  void resetBooking() {
    selectedSeats.clear();
    selectedRoute = null;
    passengerInfo.clear();
    notifyListeners();
  }
  
  double getTotalPrice(double pricePerSeat) {
    return selectedSeats.length * pricePerSeat;
  }
}