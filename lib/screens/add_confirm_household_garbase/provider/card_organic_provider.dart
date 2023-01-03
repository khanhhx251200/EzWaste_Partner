import 'package:app_shipper/core/model/order.dart';
import 'package:flutter/material.dart';

enum CardStatus { BACK, RELOAD, CONFIRM }

class CardOrganicProvider extends ChangeNotifier {
  List<Order> _listUserOrder = [];
  bool _isDragging = false;
  double _angle = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  Order? _orderSelected;

  Offset get position => _position;

  double get angle => _angle;

  bool get isDragging => _isDragging;

  Size get screenSize => _screenSize;

  List<Order> get listUserOrder => _listUserOrder;

  Order? get orderSelected => _orderSelected;

  void setListUserOrder(List<Order> listUserOrder) {
    if (listUserOrder.isNotEmpty) {
      _listUserOrder = listUserOrder;
      _orderSelected =_listUserOrder[_listUserOrder.length -1];
      notifyListeners();
    }
  }

  void setOrderSelected(Order order) => _orderSelected = _orderSelected;

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  startPosition(DragStartDetails details) {
    _isDragging = true;
  }

  updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = _position.dx;
    _angle = 45 * x / _screenSize.width;
    notifyListeners();
  }

  endPosition(DragEndDetails details) {
    _isDragging = false;
    notifyListeners();
    final status = getStatus();

    if (status != null) {
      // Fluttertoast.cancel();
      // Fluttertoast.showToast(
      //     msg: status.toString().split('.').last.toUpperCase(), fontSize: 32);
    }

    switch (status) {
      case CardStatus.CONFIRM:
        confirm();
        break;
      case CardStatus.RELOAD:
        reload();
        break;
      case CardStatus.BACK:
        back();
        break;
      default:
        resetPosition();
    }
    resetPosition();
  }

  void resetPosition() {
    _isDragging = false;
    _angle = 0;
    _position = Offset.zero;
    notifyListeners();
  }

  CardStatus? getStatus() {
    final x = _position.dx;
    final y = _position.dy;
    final forceRELOAD = x.abs() < 20;

    final delta = 120;

    if (x >= delta) {
      return CardStatus.CONFIRM;
    } else if (x <= -delta) {
      return CardStatus.BACK;
    } else if (y <= -delta / 2 && forceRELOAD) {
      return CardStatus.RELOAD;
    }
  }

  void back() {
    _angle = 220;
    _position -= Offset(2 * _screenSize.width, 0);
    notifyListeners();
  }

  void confirm() {
    _angle = 20;
    _position += Offset(_screenSize.width / 2, 0);
    _nextCard();
    notifyListeners();
  }

  void reload() {
    _angle = 0;
    _position -= Offset(_screenSize.width / 2, 0);
    notifyListeners();
  }

  Future _nextCard() async {
    if (_listUserOrder.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _listUserOrder.removeLast();
    if(_listUserOrder.isNotEmpty) {
      _orderSelected =_listUserOrder[_listUserOrder.length -1];
    }
    resetPosition();
  }
}
