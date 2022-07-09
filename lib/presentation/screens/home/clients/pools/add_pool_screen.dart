import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reimink_zwembaden_admin/common/resources/colors.dart';
import 'package:reimink_zwembaden_admin/common/resources/strings.dart';
import 'package:reimink_zwembaden_admin/data/models/pools_listing_screen_args.dart';
import 'package:reimink_zwembaden_admin/presentation/providers/providers.dart';
import 'package:reimink_zwembaden_admin/presentation/screens/error/error_screen.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/clients/pools/add_sensor_tile.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/custom_input_field.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/primary_button.dart';

class AddPoolScreen extends StatefulWidget {
  const AddPoolScreen({Key? key}) : super(key: key);

  @override
  State<AddPoolScreen> createState() => _AddPoolScreenState();
}

class _AddPoolScreenState extends State<AddPoolScreen> {
  final TextEditingController _poolNameController = TextEditingController();
  final TextEditingController _poolTopicController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PoolsListingScreenArgs;
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          args.clientName,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10.0),
              CustomInputField(
                focusNode: _focusNode,
                controller: _poolNameController,
                label: Strings.poolName,
                isObscure: false,
                icon: Icons.pool,
              ),
              const SizedBox(height: 4.0),
              CustomInputField(
                controller: _poolTopicController,
                label: Strings.poolTopic,
                isObscure: false,
                icon: Icons.pool,
              ),
              const SizedBox(height: 4.0),
              Expanded(
                child: Consumer(
                  builder: ((context, ref, child) {
                    final sensors = ref.watch(sensorsSnapshotProvider);
                    return sensors.when(
                      data: (snapshot) {
                        _focusNode.requestFocus();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.docs.length,
                          itemBuilder: (context, index) => AddSensorTile(
                            name: snapshot.docs[index]["sensor_name"],
                            iconUrl: snapshot.docs[index]["icon_url"],
                            maxSensorCount: snapshot.docs[index]
                                ["max_sensor_count"],
                          ),
                        );
                      },
                      error: (err, _) {
                        return ErrorScreen(
                          error: err.toString(),
                          onRefresh: () {
                            ref.refresh(sensorsSnapshotProvider);
                          },
                        );
                      },
                      loading: () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) =>
                            const AddSensorTileLoader(),
                      ),
                    );
                  }),
                ),
              ),
              // const Spacer(),
              const SizedBox(
                height: 10.0,
              ),
              PrimaryButton(
                label: "Save",
                onPressed: () {},
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
