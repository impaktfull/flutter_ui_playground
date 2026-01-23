#!/bin/bash

cd ui_playground
flutter packages get
cd ..

cd ui_playground_generator
dart pub get
cd ..