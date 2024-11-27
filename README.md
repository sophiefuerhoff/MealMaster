# mealmaster

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## New release
1. Create a tag (e.g. 0.0.1)
2. Push the tag
3. GitHub will create a new apk + release automatically

# Database
We are using Isar v3 (Community) for our database.
Documentation: https://isar-community.dev/v3/de/

## Change database tables
1. Add a collection-class, or edit an existing one (e.g. lib/db/user.dart)
2. When adding a new class XYZ, add the code `part 'xyz.g.dart';`
3. Run the following command 
```shell
dart run build_runner build
```