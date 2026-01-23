#!/bin/bash

cd ui_playground_annotations
dart pub get
cd ..

cd ui_playground
flutter packages get
cd ..

cd ui_playground_generator
dart pub get
cd ..

cd ui_playground_example
flutter packages get
cd ..