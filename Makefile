# Generatsiya pakagelari uchun, bir martalik generatsiya
gen:
	dart run build_runner build


# Generatsiya pakagelari uchun, o'zgarishlarni eshitib turadi
gen_auto:
	dart run build_runner watch --delete-conflicting-outputs

# Generatsiya localization uchun, bir martalik generatsiya
lang_auto:
	flutter pub run intl_utils:generate

# Clean qilish uchun
clean:
	flutter clean
	flutter pub get


# Build ios qilish uchun
build_ios:
	flutter clean
	flutter build ios


# Apk build qilish uchun:
# apk build qiladi, nomini bir_qadam_sana.apk ko'rinisiga o'tkazadi
# papkani ochadi, gitdagi joriy branchdagi ohirgi 5 commitni, changes.txtga saqlaydi
build_android:
	flutter clean
	flutter build apk --release
	mv ./build/app/outputs/flutter-apk/app-release.apk "./build/app/outputs/flutter-apk/tma-mobile-`date +%d.%m.%Y`.apk"
	git log -n 5 --pretty=format:"%s" > ./build/app/outputs/flutter-apk/changes.txt
	echo "`git log -n 5 --pretty=format:"%s"`" | pbcopy
	open ./build/app/outputs/flutter-apk/


# iosda uchrab turadigan odatiy xatoliklarni oldini oladi
fix_ios:
	cd ios; pod cache clean --all;
	pod clean;
	pod deintegrate;
	sudo gem install cocoapods-deintegrate cocoapods-clean;
	sudo arch -x86_64 gem install ffi;
	arch -x86_64 pod repo update;
	arch -x86_64 pod install



//profile proto generated \
    -Ilib/features/profile/data/proto \
    --dart_out=grpc:lib/features/profile/data/generated \
    lib/features/profile/data/proto/profile.proto



 protoc  -Ilib/features/profile/data/proto \
    --dart_out=grpc:lib/features/profile/data/generated/tariff \
    lib/features/profile/data/proto/tariff.proto


// payment proto generated
protoc "-Ilib/features/money/data/proto" \
  --dart_out=grpc:lib/features/money/data/generated \
  lib/features/money/data/proto/payment.proto

// address proto generated
 protoc "-Ilib/features/map/data/protos" \
  --dart_out=grpc:lib/features/map/data/generated/address \
  lib/features/map/data/protos/address.proto


// To create a patch for this release, run
shorebird patch --platforms=android --release-version=1.0.0+7

//order proto generated \
    protoc "-Ilib/features/map/data/protos" \
      --dart_out=grpc:lib/features/map/data/generated/order \
      lib/features/map/data/protos/order.proto