import 'package:bookshop/data/offers/model.dart';
import 'package:flutter/material.dart';

class CartOffer extends StatefulWidget {
  final Offer bestOffer;
  final num totalPrice;

  const CartOffer(
      {super.key, required this.bestOffer, required this.totalPrice});

  @override
  State<CartOffer> createState() => _CartOfferState();
}

class _CartOfferState extends State<CartOffer> {
  @override
  Widget build(BuildContext context) {
    String offerText = "";

    switch (widget.bestOffer.type) {
      case OfferType.percentage:
        offerText = "-${widget.bestOffer.value}%";
        break;
      case OfferType.minus:
        offerText = "-${widget.bestOffer.value}€";
        break;
      case OfferType.slice:
        offerText =
            "-${widget.bestOffer.value}€ every ${widget.bestOffer.sliceValue}€";
        break;
    }

    return Container(
        padding: const EdgeInsets.all(4),
        color: Colors.grey[200],
        child: Row(children: [
          Expanded(
              flex: 1,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text("Order (${widget.totalPrice}€)")),
                Text("Applied offer: $offerText")
              ]))
        ]));
  }
}
