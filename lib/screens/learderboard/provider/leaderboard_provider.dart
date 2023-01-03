import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/leaderboard.dart';
import 'package:app_shipper/services/leader_board_service.dart';
import 'package:flutter/material.dart';

class LeaderBoardProvider extends ChangeNotifier {
  final LeaderBoardService _leaderBoardService = new LeaderBoardService();
  dynamic _currentColor = kOrganicColor;
  List<Leaderboard> _listLeaderBoard = [];
  String _typeRecycle = ORGANIC;
  String _typeDate = DAY;


  setCurrentColor(color) => _currentColor = color;

  setTypeRecycle(String type) => _typeRecycle = type;

  setTypeDate(String type) => _typeDate = type;

  setListLeaderBoard(List<Leaderboard> listLeaderBoard) => _listLeaderBoard = listLeaderBoard;

  get currentColor => _currentColor;

  List<Leaderboard> get listLeaderBoard => _listLeaderBoard;

  getList() async {
    _listLeaderBoard = [];
    _listLeaderBoard = await _leaderBoardService.getListLeaderBoard(_typeRecycle, _typeDate);
    notifyListeners();
  }
}