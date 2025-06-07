build_number=$(awk -F'+' '/version:/ {print $2}' pubspec.yaml); build_number=${build_number:-0};
sed -i '' -E "s/(version: [0-9]+\.[0-9]+\.[0-9]\+)[0-9]*/\1$((build_number + 1))/" pubspec.yaml