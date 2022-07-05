import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_counter.dart';
import 'package:reimink_zwembaden_admin/presentation/widgets/common/custom_loading_indicator.dart';

class AddSensorTile extends StatefulWidget {
  const AddSensorTile({
    Key? key,
    required this.name,
    required this.maxSensorCount,
    this.iconUrl,
  }) : super(key: key);
  final String name;
  final String? iconUrl;
  final int maxSensorCount;

  @override
  State<AddSensorTile> createState() => _AddSensorTileState();
}

class _AddSensorTileState extends State<AddSensorTile> {
  final TextEditingController _sensorCounterController =
      TextEditingController();
  bool _isChecked = false;

  @override
  void dispose() {
    _sensorCounterController.dispose();
    super.dispose();
  }

  void toggleChecked(bool value) {
    setState(() {
      value
          ? _sensorCounterController.text = "1"
          : _sensorCounterController.clear();
      _isChecked = value;
    });
  }

  void limitQuantity(String value) {
    if (value.trim().isNotEmpty) {
      int val = int.parse(value);
      if (val > widget.maxSensorCount) {
        setState(
          () {
            _sensorCounterController.value = TextEditingValue(
              text: widget.maxSensorCount.toString(),
              selection: TextSelection.fromPosition(
                TextPosition(
                    offset:
                        _sensorCounterController.value.selection.baseOffset),
              ),
            );
            FocusScope.of(context).unfocus();
          },
        );
      } else {
        FocusScope.of(context).unfocus();
      }
    }
  }

  void decreaseCount(sensorCounterController) {
    FocusManager.instance.primaryFocus?.unfocus();
    int value = sensorCounterController.text.isNotEmpty
        ? int.parse(sensorCounterController.text)
        : 1;
    setState(() {
      value > 1 ? sensorCounterController.text = (--value).toString() : 1;
    });
  }

  void increaseCount(sensorCounterController) {
    FocusManager.instance.primaryFocus?.unfocus();
    int value = sensorCounterController.text.isNotEmpty
        ? int.parse(sensorCounterController.text)
        : 1;
    setState(() {
      value < widget.maxSensorCount
          ? sensorCounterController.text = (++value).toString()
          : widget.maxSensorCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        // vertical: 8.0,
        horizontal: 2.0,
      ).copyWith(
        right: 8.0,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 4.0,
        // horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  toggleChecked(value!);
                },
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: widget.iconUrl != null
                      ? Image.network(widget.iconUrl!)
                      : const Icon(
                          Icons.info,
                          color: AppColors.primary,
                        ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: SizedBox(
                  child: Text(widget.name),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              AbsorbPointer(
                absorbing: !_isChecked,
                child: CustomCounter(
                  controller: _sensorCounterController,
                  active: _isChecked,
                  onChanged: limitQuantity,
                  onDecrement: () {
                    decreaseCount(_sensorCounterController);
                  },
                  onIncrement: () {
                    increaseCount(_sensorCounterController);
                  },
                ),
              )
            ],
          ),
          _sensorCounterController.text.isNotEmpty &&
                  int.parse(_sensorCounterController.text) ==
                      widget.maxSensorCount
              ? Text(
                  Strings.maxSelected,
                  style: AppStyles.extraSmallLabel.copyWith(
                    color: AppColors.error,
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class AddSensorTileLoader extends StatelessWidget {
  const AddSensorTileLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ).copyWith(
          right: 8.0,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          // horizontal: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: AppColors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            CustomLoadingIndicator(width: 150, height: 24, radius: 4),
            CustomCounterLoader()
          ],
        ),
      ),
    );
  }
}
