import 'package:flutter/material.dart';

class NumberPaginatorController extends ChangeNotifier {
  int _currentPage = 0;
  final int numberOfPages;
  int get currentPage => _currentPage;

  NumberPaginatorController({required this.numberOfPages});

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  /// Decreases page by 1 and notifies listeners
  prev() {
    _currentPage--;
    notifyListeners();
  }

  /// Increases page by 1 and notifies listeners
  next() {
    _currentPage++;
    notifyListeners();
  }

  /// Alias for setter
  navigateToPage(int index) {
    currentPage = index;
    notifyListeners();
  }

  first() {
    _currentPage = 0;
    notifyListeners();
  }

  last() {
    _currentPage = numberOfPages - 1;
    notifyListeners();
  }
}
