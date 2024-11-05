import 'package:basic_selector/src/models/models.dart';
import 'package:flutter/material.dart';

class BasicSelector<T> extends StatefulWidget {
  final List<T> items;
  final T value;
  final ValueChanged<T> onChanged;
  final String Function(T item)? textFormatter;
  final double height;
  final BasicSelectorStyle styles;
  final bool loop;

  const BasicSelector({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.textFormatter,
    this.height = 200,
    this.styles = const BasicSelectorStyle(),
    this.loop = false,
  });

  const BasicSelector.items(
    this.items, {
    super.key,
    required this.value,
    required this.onChanged,
    this.textFormatter,
    this.height = 200,
    this.styles = const BasicSelectorStyle(),
    this.loop = false,
  });

  const BasicSelector.loop({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.textFormatter,
    this.height = 200,
    this.styles = const BasicSelectorStyle(),
  }) : loop = true;

  @override
  State<BasicSelector<T>> createState() => _BasicSelectorState<T>();
}

class _BasicSelectorState<T> extends State<BasicSelector<T>> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.items.indexWhere((item) => item == widget.value);
  }

  BasicSelectorStyle get _styles => widget.styles;

  List<Widget> get _items {
    return [
      for (int index = 0; index < widget.items.length; index++)
        Center(
          child: Text(
            _getText(widget.items[index]),
            style: _selectedIndex == index
                ? _styles.selectedValueTextStyle
                : _styles.notSelectedValueTextStyle,
          ),
        ),
    ];
  }

  String _getText(T item) {
    if (widget.textFormatter != null) return widget.textFormatter!(item);

    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          IgnorePointer(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                decoration: _styles.selectedValueContainerDecoration ??
                    BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
              ),
            ),
          ),
          ListWheelScrollView.useDelegate(
            itemExtent: 40,
            diameterRatio: 3,
            physics: const FixedExtentScrollPhysics(),
            childDelegate: widget.loop
                ? ListWheelChildLoopingListDelegate(
                    children: _items,
                  )
                : ListWheelChildListDelegate(
                    children: _items,
                  ),
            onSelectedItemChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });

              widget.onChanged(widget.items[index]);
            },
          ),
          IgnorePointer(
            child: _BorderGradient(
              height: widget.height,
              styles: _styles,
            ),
          ),
          IgnorePointer(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _BorderGradient(
                height: widget.height,
                isBottomBorder: true,
                styles: _styles,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BorderGradient extends StatelessWidget {
  final double height;
  final bool isBottomBorder;
  final BasicSelectorStyle styles;

  const _BorderGradient({
    required this.height,
    this.isBottomBorder = false,
    required this.styles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.3,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          styles.bordersGradientBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          (styles.bordersGradientBackgroundColor ?? Theme.of(context).scaffoldBackgroundColor)
              .withAlpha(0),
        ],
        stops: const [0.3, 1],
        begin: isBottomBorder ? FractionalOffset.bottomCenter : FractionalOffset.topCenter,
        end: isBottomBorder ? FractionalOffset.topCenter : FractionalOffset.bottomCenter,
        tileMode: TileMode.repeated,
      )),
    );
  }
}
