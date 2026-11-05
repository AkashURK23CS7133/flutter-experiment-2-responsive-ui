# Experiment 2 – Adaptive and Responsive UI Design

## Aim

To design and implement a responsive Flutter E-Commerce Product Catalog using reusable custom product widgets and responsive layout techniques that adapt the interface to different screen sizes.

## Features

- `LayoutBuilder` reads the available width
- `GridView.builder` with **2 columns (mobile < 600 px), 3 (tablet 600–899 px), 4 (desktop ≥ 900 px)**
- A chip shows the active layout (e.g. *Desktop • 4 columns*)
- 8 products with icon, category, price and rating
- Search box and category chips (All / Electronics / Fashion / Accessories)
- Add to Cart button with SnackBar and cart counter in the AppBar
- Reusable `ProductCard` widget

## Source files

`lib/main.dart`

## Dependencies

Only the Flutter SDK.

## Setup

Nothing extra – just run `flutter pub get`.

## Run

Open a terminal **in this folder** (VS Code: right-click the folder → *Open in Integrated Terminal*), then:

```powershell
flutter pub get        # download the packages listed in pubspec.yaml
flutter analyze        # check the code for problems (should say "No issues found!")
flutter test           # run the automated tests
flutter run -d chrome  # start the app in Chrome
```

While the app is running in the terminal: press `r` to hot-reload after editing code, `R` to restart, `q` to quit.

## Expected output

ShopEasy catalog. Resize the Chrome window: the grid changes between 2, 3 and 4 columns.

Screenshots of the running app: [`../OUTPUTS/Experiment_02/`](../OUTPUTS/Experiment_02/)

## Troubleshooting

- **`flutter` is not recognized** – Flutter is not on your PATH. See the master README, section *Installing Flutter*.
- **"Unable to determine engine version"** – PowerShell is picking up the empty file `C:\Windows\System32\git` instead of real Git. Put Git first on PATH (see master README).
- **No Chrome device** – run `flutter devices`; install Google Chrome if it is missing.
