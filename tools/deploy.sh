#!/bin/bash

cd ui_playground_annotations
dart pub lish || exit 1
cd ..

cd ui_playground
dart pub lish || exit 1
cd ..

cd ui_playground_generator
dart pub lish || exit 1
cd ..