import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/requests/client_request_tile.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      if (isLoading) {
        setState(() {
          isLoading = false;
        });
      }
    });
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        children: <Widget>[
          isLoading
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) =>
                      const ClientRequestTileLoader(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) => const ClientRequestTile(
                    name: "Lucy Freeman",
                    email: "freeman_lucy@example.com",
                    imageUrl: Strings.dummyImage,
                  ),
                ),
        ],
      ),
    );
  }
}
