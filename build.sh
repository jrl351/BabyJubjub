#!/bin/bash

echo "Cleaning..."
rm -rf libs/libbabyjubjub*.a
rm -rf BabyJubjub.xcframework
rm -f libbabyjubjub.zip

echo "Building libraries..."
cargo build --release --lib --target aarch64-apple-darwin
cargo build --release --lib --target x86_64-apple-darwin
lipo -create \
  target/x86_64-apple-darwin/release/libbabyjubjub.a \
  target/aarch64-apple-darwin/release/libbabyjubjub.a \
  -output libs/libbabyjubjub-macos.a

cargo build --release --lib --target aarch64-apple-ios-sim &&
cargo build --release --lib --target aarch64-apple-ios && 
cargo build --release --lib --target x86_64-apple-ios &&

cp target/aarch64-apple-ios/release/libbabyjubjub.a libs/libbabyjubjub-ios.a
lipo -create \
    target/aarch64-apple-ios-sim/release/libbabyjubjub.a \
    target/x86_64-apple-ios/release/libbabyjubjub.a \
    -output libs/libbabyjubjub-ios-sim.a \

echo "Building xcframework..."

xcodebuild -create-xcframework \
    -library libs/libbabyjubjub-macos.a \
    -headers ./include/ \
    -library libs/libbabyjubjub-ios-sim.a \
    -headers ./include/ \
    -library libs/libbabyjubjub-ios.a \
    -headers ./include/ \
    -output BabyJubjub.xcframework

echo "Zipping..."
zip -r libbabyjubjub.zip BabyJubjub.xcframework
