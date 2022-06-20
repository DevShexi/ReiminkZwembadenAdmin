import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/data/models/pools_listing_screen_args.dart';

class PoolsListingScreen extends StatefulWidget {
  const PoolsListingScreen({Key? key}) : super(key: key);

  @override
  State<PoolsListingScreen> createState() => _PoolsListingScreenState();
}

class _PoolsListingScreenState extends State<PoolsListingScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PoolsListingScreenArgs;
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        title: Text(
          args.clientName,
        ),
        centerTitle: true,
        actions: [
          Center(
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              elevation: 3.0,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PagePath.addPool,
                    arguments: args,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SizedBox(
                height: 10.0,
              ),
              PoolSensorsExpansionTile(
                poolName: "Wedstrijdbad",
              ),
              PoolSensorsExpansionTile(
                poolName: "Deolgroepenbad",
              ),
              PoolSensorsExpansionTile(
                poolName: "Peuterbad",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SensorSwitchTile extends StatefulWidget {
  const SensorSwitchTile({
    Key? key,
    required this.sensorName,
    required this.isOn,
    this.leadingIcon,
  }) : super(key: key);
  final String sensorName;
  final Widget? leadingIcon;
  final bool isOn;

  @override
  State<SensorSwitchTile> createState() => _SensorSwitchTileState();
}

class _SensorSwitchTileState extends State<SensorSwitchTile> {
  bool? _isOn;
  @override
  void initState() {
    _isOn = widget.isOn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6.0,
        // vertical: 8.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(
          color: AppColors.grey,
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_rounded,
            color: AppColors.primary,
            size: 34.0,
          ),
          const SizedBox(width: 10.0),
          Text(
            widget.sensorName,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const Spacer(),
          Switch(
            onChanged: (value) {
              setState(() {
                _isOn != !_isOn!;
              });
            },
            value: _isOn!,
            activeColor: AppColors.blue,
            activeTrackColor: AppColors.lightBlue,
            inactiveThumbColor: AppColors.error,
            inactiveTrackColor: AppColors.errorLight,
          )
        ],
      ),
    );
  }
}

class PoolActionIconButton extends StatelessWidget {
  const PoolActionIconButton(
      {Key? key,
      required this.label,
      required this.icon,
      required this.action,
      this.color})
      : super(key: key);
  final IconData icon;
  final String label;
  final Color? color;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Material(
          borderRadius: BorderRadius.circular(7.0),
          elevation: 3.0,
          child: InkWell(
            onTap: action,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                border: Border.all(
                  color: color ?? AppColors.blue,
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      color: color ?? AppColors.primary,
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: AppColors.white,
                        size: 16.0,
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          label,
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    fontSize: 12.0,
                                  ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      height: 1,
      decoration: BoxDecoration(
          color: AppColors.textGrey.withOpacity(0.2),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 2.0),
              blurRadius: 5.0,
              // spreadRadius: 2.0,
              // color: Colors.green,
            ),
          ]),
    );
  }
}

class PoolSensorsExpansionTile extends StatefulWidget {
  const PoolSensorsExpansionTile({
    Key? key,
    required this.poolName,
  }) : super(key: key);
  final String poolName;

  @override
  State<PoolSensorsExpansionTile> createState() =>
      _PoolSensorsExpansionTileState();
}

class _PoolSensorsExpansionTileState extends State<PoolSensorsExpansionTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          7.0,
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            backgroundColor: AppColors.white,
            collapsedBackgroundColor: AppColors.white,
            textColor: AppColors.primary,
            collapsedTextColor: AppColors.black,
            title: Text(
              widget.poolName,
            ),
            // subtitle: const Text('Custom expansion arrow icon'),
            trailing: Icon(
              _customTileExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
            ),
            children: <Widget>[
              const CustomDivider(),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PoolActionIconButton(
                      label: Strings.duplicate,
                      icon: Icons.copy,
                      action: () {},
                    ),
                    PoolActionIconButton(
                      label: Strings.edit,
                      icon: Icons.edit,
                      action: () {},
                    ),
                    PoolActionIconButton(
                      label: Strings.delete,
                      icon: Icons.delete,
                      color: AppColors.error,
                      action: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              const SensorSwitchTile(
                sensorName: "Free Chlorine",
                isOn: true,
              ),
              const SensorSwitchTile(
                sensorName: "Bound Chlorine",
                isOn: true,
              ),
              const SensorSwitchTile(
                sensorName: "pH",
                isOn: false,
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() => _customTileExpanded = expanded);
            },
          ),
        ),
      ),
    );
  }
}
