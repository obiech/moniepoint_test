#!/bin/bash
set -e

flutter clean
flutter pub get
dart fix --apply
flutter build appbundle
flutter build ipa