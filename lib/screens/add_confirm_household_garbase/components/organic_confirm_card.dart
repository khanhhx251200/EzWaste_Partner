import 'dart:math';

import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/model/login_response.dart';
import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/screens/add_confirm_household_garbase/provider/card_organic_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrganicConfirmCard extends StatefulWidget {
  const OrganicConfirmCard(
      {Key? key, required this.order, required this.isFront})
      : super(key: key);
  final Order order;
  final bool isFront;

  @override
  _OrganicConfirmCardState createState() => _OrganicConfirmCardState();
}

class _OrganicConfirmCardState extends State<OrganicConfirmCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;

      final provider = Provider.of<CardOrganicProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: widget.isFront ? buildFrontCard() : buildCard());
  }

  GestureDetector buildFrontCard() {
    final provider = Provider.of<CardOrganicProvider>(context);
    return GestureDetector(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final provider = Provider.of<CardOrganicProvider>(context);
          final position = provider.position;
          final milliseconds = provider.isDragging ? 0 : 400;

          final center = constraints.smallest.center(Offset.zero);
          final angle = provider.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);

          return AnimatedContainer(
            curve: Curves.easeInOut,
            transform: rotatedMatrix..translate(position.dx, position.dy),
            duration: Duration(milliseconds: milliseconds),
            child: Stack(
              children: [buildCard(), buildStamps()],
            ),
          );
        },
      ),
      // onPanStart: (details) => provider.startPosition(details),
      // onPanUpdate: (details) => provider.updatePosition(details),
      // onPanEnd: (details) => provider.endPosition(details),
    );
  }

  ClipRRect buildCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size20),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            image: DecorationImage(
                image: AssetImage('assets/images/bg_organic_confirm.png'),
                fit: BoxFit.cover,
                alignment: Alignment(-0.3, 0))),
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.transparent, kBlackColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.7, 1],
          )),
          padding: const EdgeInsets.all(size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildName(),
              const Spacer(),
              buildContact(),
              const SizedBox(height: size8),
              buildAddress()
            ],
          ),
        ),
      ),
    );
  }

  Text buildAddress() {
    return Text(
      'Địa chỉ: ${widget.order.address}',
      style: const TextStyle(fontSize: size20, color: kWhiteColor),
    );
  }

  Text buildName() {
    return Text(
      widget.order.userCreateFullName,
      style: const TextStyle(
          fontSize: 32, color: kWhiteColor, fontWeight: FontWeight.bold),
    );
  }

  Text buildContact() {
    return Text(
      widget.order.userCreate,
      style: const TextStyle(
          fontSize: 28, color: kWhiteColor, fontWeight: FontWeight.bold),
    );
  }

  Widget buildStamps() {
    final provider = Provider.of<CardOrganicProvider>(context);
    final status = provider.getStatus();

    switch (status) {
      case CardStatus.BACK:
        final child = buildStamp(angle: -0.5, color: Colors.red, text: 'Hủy');
        return Positioned(top: 64, right: 50, child: child);
      case CardStatus.CONFIRM:
        final child =
            buildStamp(angle: 0.5, color: kWhiteColor, text: 'Hoàn thành');
        return Positioned(top: 64, left: 50, child: child);
      case CardStatus.RELOAD:
        final child =
            buildStamp(angle: -0.5, color: kWarningColor, text: 'Chạy lại');
        return Positioned(bottom: 128, right: 0, left: 0, child: child);
      default:
        return Container();
    }
  }

  Widget buildStamp(
      {double angle = 0, required Color color, required String text}) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size12),
            border: Border.all(color: color, width: size8 / 2)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: color, fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
