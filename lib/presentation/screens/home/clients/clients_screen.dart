import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/clients/client_display_tile.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
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
                      const ClientDisplayTileLoader(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) => const ClientDisplayTile(
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
