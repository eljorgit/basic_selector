# Basic selector

[![pub package](https://img.shields.io/pub/v/basic_selector.svg)](https://pub.dev/packages/basic_selector)

## How to use
The `BasicSelector` widget has three constructors. The `BasicSelector()` will use the default style. Also `BasicSelector.items()` which just uses the items list as formal parameter and `BasicSelector.loop()` which enables loop by default and just scrolls infinitely through the items provided.

Add this to your package's pubspec.yaml file, use the latest version [![Pub](https://img.shields.io/pub/v/basic_selector.svg)](https://pub.dartlang.org/packages/basic_selector):

```yaml
dependencies:
  basic_selector: ^latest_version
```

```dart
import 'package:basic_selector/basic_selector.dart';

// Generate a list of numbers with BuildSelectorHelpers
static final List<int> _numbers = BasicSelectorHelpers.generateNumbers(end: 10);
int _selectedNumber = 0;

// Then build this widget
BasicSelector<int>(
    items: _numbers,
    value: _selectedNumber,
    textFormatter: (item) { // Example of conditional formatting
        if (item == 1) {
          return '1 item';
        } else {
          return '$item items';
        }
    },
    onChanged: (item) {
        setState(() {
          _selectedNumber = item;
        });
    },
),
```

`BasicSelector` uses `<T>` for setting the type for the selected value, list items and onChange function.
#### Some examples are:
* `BasicSelector<int>`
* `BasicSelector<double>`
* `BasicSelector<String>`
* `BasicSelector<DateTime>`
* `BasicSelector<TimeOfDay>`
* And some other `Type`s

## Other functionalities
`basic_selector` also provides another widget built with `BasicSelector`, one for selecting times (`TimeOfDay`): `BasicTimeSelector`. <br />
As well as some `static` helpers on `BasicSelectorHelpers` and some `extensions` on `TimeOfDay` (See below).

### Usage for `BasicTimeSelector` <a id="basic_time_selector_usage"></a>
See [Properties](#basic_time_selector_properties) for more details.
```dart
import 'package:basic_selector/basic_selector.dart';

// Generate a list of numbers with BuildSelectorHelpers
TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0);

// Then build this widget
BasicTimeSelector(
    time: _selectedTime,
    currentTime: const TimeOfDay(hour: 13, minute: 30),
    config: const BasicTimeSelectorConfig(showOnlyToCurrentType: true),
    textFormatter: (item) {
        return item.formatted();
    },
    onChanged: (item) {
        setState(() {
            _selectedTime = item;
        });
    },
),
```

### Usage for `BasicTimeSelector.showModalDialog()`
This method shows a basic dialog for selecting a `TimeOfDay`
```dart
import 'package:basic_selector/basic_selector.dart';

// Generate a list of numbers with BuildSelectorHelpers
TimeOfDay _selectedTime = const TimeOfDay(hour: 0, minute: 0);

// Then build this widget
FilledButton(
    onPressed: () => BasicTimeSelector.showModalDialog(
        context,
        time: _selectedTime,
    ).then((value) {
        if (value != null) {
            setState(() {
                _selectedTime = value;
        });

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(
              'Date selected: ${_selectedTime.formatted()}',
            ),
            behavior: SnackBarBehavior.floating,
          ));
      }
    }),
    child: const Text('Open dialog'),
),
```

## Helper methods (`BasicSelectorHelpers`)
This package provides some static methods for generating some very basic values.

### `List<T> generateNumbers<T extends num>()`
Generates a list of `<T>` that extends num, so it must be a number, typically of type `int` or `double`.
```dart
static final List<int> _numbers = BasicSelectorHelpers.generateNumbers(start: 25, end: 50, step: 5);
// Returns a list of type int
// [25, 30, 35, 40, 45, 50]
```
| Property | Type | Description | Default Value | Required |
|:---------|:-----|:------------|:--------------|:---------|
| **start** | `num` | The start number of the generated list | `null` ?? `0` | |
| **start** | `num` | The end number of the generated list | | :heavy_check_mark: |
| **start** | `num` | The interval of number of the generated list | `1` | |

### `List<String> generateAlphabet()`
Generates a list of `<String>` with the letters of the alphabet.
```dart
static final List<String> _alphabet = BasicSelectorHelpers.generateAlphabet();
// Returns a list of type String
// ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
```
_No properties needed for this method_

### `List<TimeOfDay> generateTimes()`
Generates a list of `<TimeOfDay>` with all times from `00:00` to `23:59` if no properties used.
```dart
static final List<TimeOfDay> _times = BasicSelectorHelpers.generateTimes(minuteStep: 30);
// Returns a list of type TimeOfDay with a step of 30 mins
// [TimeOfDay(0, 0), TimeOfDay(0, 30), TimeOfDay(1, 0), TimeOfDay(1, 30), ..., TimeOfDay(23, 30)]
```
| Property | Type | Description | Default Value | Required |
|:---------|:-----|:------------|:--------------|:---------|
| **from** | `TimeOfDay` | From time to generate list | `null` ?? `const TimeOfDay(hour: 00, minute: 00)` | |
| **to** | `TimeOfDay` | To time to generate list | `null` ?? `const TimeOfDay(hour: 23, minute: 59)` | |
| **minuteStep** | `int` | The interval of minutes to generate list | `1` | |

# Examples
If you want to see some usage examples, clone the [example app](https://github.com/eljorgit/basic_selector/tree/main/example) with usages like:
* [**Numeric selector**](https://github.com/eljorgit/basic_selector/blob/main/example/lib/src/screens/numeric_example_screen.dart)
* [**Text selector**](https://github.com/eljorgit/basic_selector/blob/main/example/lib/src/screens/text_example_screen.dart)
* [**Time selector**](https://github.com/eljorgit/basic_selector/blob/main/example/lib/src/screens/time_example_screen.dart), see [`BasicTimeSelector`](#basic_time_selector_usage)

# Properties
### `BasicSelector`
| Property | Type | Description | Default Value | Required |
|:---------|:-----|:------------|:--------------|:---------|
| **items** | `List<T>` | The list of items to be iterated on the selector | | :heavy_check_mark: |
| **value** | `T` | The selected value | | :heavy_check_mark: |
| **onChanged** | `ValueChanged<T>` | A void callback function that runs when the selector changes | | :heavy_check_mark: |
| **textFormatter** | `String Function(T item)` | A way to format the text shown on the selector | `null` | |
| **height** | `double` | The height of the selector | `200` | |
| **styles** | [`BasicSelectorStyle`](#basic_selector_style_properties) | A way to style the `BasicSelector` | `const BasicSelectorStyle()` | |
| **loop** | `bool` | Enables infinite scroll for `items` | `false` | |
| **reversed** | `bool` | To reverse the `items` | `false` | |

### `BasicSelectorStyle` <a id="basic_selector_style_properties"></a>
| Property | Type | Description | Default Value | Required |
|:---------|:-----|:------------|:--------------|:---------|
| **selectedValueTextStyle** | `TextStyle` | Style for the selected value | `const TextStyle(fontWeight: FontWeight.bold)` | |
| **notSelectedValueTextStyle** | `TextStyle` | Style for the rest of the values that are not selected | `const TextStyle(fontWeight: FontWeight.normal)` | |
| **selectedValueContainerDecoration** | `BoxDecoration` | Style for the container around the selected value | `null` ?? `BoxDecoration(color: Theme.of(context).colorScheme.surface,borderRadius: BorderRadius.circular(10),border: Border.all(color: Theme.of(context).colorScheme.primary,),)` | |
| **bordersGradientBackgroundColor** | `Color` | Color for gradient on the edges of the selector  | `null` ?? `Theme.of(context).scaffoldBackgroundColor` | |

### `BasicTimeSelector` <a id="basic_time_selector_properties"></a>
| Property | Type | Description | Default Value | Required |
|:---------|:-----|:------------|:--------------|:---------|
| **time** | `TimeOfDay` | The selected time value | | :heavy_check_mark: |
| **currentTime** | `TimeOfDay` | In case is needed a different time from `TimeOfDay.now()` | `null` ?? `TimeOfDay.now()` | |
| **onChanged** | `ValueChanged<TimeOfDay>` | A void callback function that runs when the selector changes | | :heavy_check_mark: |
| **textFormatter** | `String Function(T item)` | A way to format the text shown on the selector | `null` | |
| **height** | `double` | The height of the selector | `200` | |
| **styles** | [`BasicTimeSelectorStyle`](#basic_time_selector_style_properties) | A way to style the `BasicTimeSelector` | `const BasicTimeSelectorStyle()` | |
| **config** | [`BasicTimeSelectorConfig`](#basic_time_selector_config_properties) | A way to configure the `BasicTimeSelector` | `const BasicTimeSelectorConfig()` | |
| **loop** | `bool` | Enables infinite scroll for `items` | `false` | |

### `BasicTimeSelector.showModalDialog()`
| Property | Type | Description | Default Value | Required |
|:---------|:-----|:------------|:--------------|:---------|
| **context** | `BuildContext` | Current context | | :heavy_check_mark: |
| **time** | `TimeOfDay` | The selected time value | | :heavy_check_mark: |
| **currentTime** | `TimeOfDay` | In case is needed a different time from `TimeOfDay.now()` | `null` ?? `TimeOfDay.now()` | |
| **textFormatter** | `String Function(T item)` | A way to format the text shown on the selector on the dialog | `null` | |
| **height** | `double` | The height of the selector | `200` | |
| **styles** | [`BasicTimeSelectorStyle`](#basic_time_selector_style_properties) | A way to style the `BasicTimeSelector` on the dialog | `const BasicTimeSelectorStyle()` | |
| **config** | [`BasicTimeSelectorConfig`](#basic_time_selector_config_properties) | A way to configure the `BasicTimeSelector`  on the dialog | `const BasicTimeSelectorConfig()` | |
| **dialogConfig** | [`BasicTimeSelectorDialogConfig`](#basic_time_selector_dialog_config_properties) | A way to configure the `BasicTimeSelector.showModalDialog()` on the dialog | `const BasicTimeSelectorDialogConfig()` | |
| **loop** | `bool` | Enables infinite scroll for `items` | `false` | |

### `BasicTimeSelectorStyle` <a id="basic_time_selector_style_properties"></a>
Extends all properties from `BasicSelectorStyle` and also
| Property | Type | Description | Default Value | Required |
|:---------|:-----|:------------|:--------------|:---------|
| **twoDotSeparatorStyle** | `TextStyle` | Style for ':' that is in the middle of the two selectors | `const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,)` | |

### `BasicTimeSelectorConfig` <a id="basic_time_selector_config_properties"></a>
| Property | Type | Description | Default Value | Required |
|:---------|:-----|:------------|:--------------|:---------|
| **showOnlyFromCurrentType** | `bool` | Shows only the times from the selected `currentTime` | `false` | |
| **showOnlyToCurrentType** | `bool` | Shows only the times to the selected `currentTime` | `false` | |
| **minuteStep** | `int` | Interval for the generated minutes (**must be a divider of 60**) | `1` | |
| **startTime** | `TimeOfDay` | The start date when generating times | `null` | |
| **endTime** | `TimeOfDay` | The end date when generating times | `null` | |

### `BasicTimeSelectorDialogConfig` <a id="basic_time_selector_dialog_config_properties"></a>
| Property | Type | Description | Default Value | Required |
|:---------|:-----|:------------|:--------------|:---------|
| **title** | `String` | A title for the dialog | `'Select a time'` | |
| **titleStyle** | `TextStyle` | A way to style the title for the dialog | `const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,)` | |
| **description** | `String` | A description for the dialog, that goes below the `title` | `null` | |
| **titleStyle** | `TextStyle` | A way to style the title for the dialog | `null` ?? `TextStyle(fontSize: 12, color: Colors.grey[600])` | |
| **backgroundColor** | `Color` | The background color for the dialog | `null` | |
| **elevation** | `double` | The elevation for the dialog | `null` | |
| **shape** | `ShapeBorder` | The shape for the dialog | `null` ?? `RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),)` | |
| **confirmButtonBuilder** | `Widget Function(TimeOfDay value)` | A builder for the confirm button, if not provided a default `TextButton` will be used | `null` | |
| **confirmButtonText** | `String` | The text used for the confirm button (ignored if `confirmButtonBuilder` is used) | `'Confirm'` | |
| **cancelButtonBuilder** | `Widget Function()` | A builder for the cancel button, if not provided a default `TextButton` will be used | `null` | |
| **cancelButtonText** | `String` | The text used for the cancel button (ignored if `cancelButtonBuilder` is used) | `'Cancel'` | |

<br />
<br />
<br />

If you like this package, consider supporting it by giving it a star on [GitHub](https://github.com/eljorgit/basic_selector) and a like on [pub.dev](https://pub.dev/packages/basic_selector) :heart:
