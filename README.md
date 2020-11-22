# flutter_turkiye_firebase

[Kendi YouTube Kanalıma ulaşarak mevcut veye gelecekte eklenecek eğitimlere erişebilirsiniz.](https://www.youtube.com/channel/UCwmEwO6SSJnOU-eNohD-4Jw)

[Flutter Türkiye](https://www.twitter.com/Flutter_Turkiye) ve [Developer Multicamp](https://twitter.com/devmulticamp) tarafından düzenlenen ve [Google Developer Communities Turkey](https://www.youtube.com/c/GoogleDevelopersTurkey) YouTube kanalında yayınlanan **Flutter için Firebase Kurulum ve Kullanım Eğitimi** kodlarına buradan ulaşabilirsiniz.

## Önemli Bilgilendirme
Eğitim sırasında eş zamanlı gitmek istiyorsanız [başlangıç projesini](https://github.com/bgoktugozdemir/flutter_turkiye_firebase/tree/starter) indirip editörünüzde çalıştırabilirsiniz.

## Başlamadan önce

**Bir proje aynı anda sadece bir Firebase projesine entegre edilebilir.**
Bu sebeple sırasıyla aşağıdaki adımları gerçekleştirmeniz gerekmektedir.
 1. Kendi **Flutter Projenizi** oluşturun.
 2. **/lib** dizini altındaki dosyaları kendi projenize aynı konuma taşıyın.
 3. **pubspec.yaml** dosyasında **dependencies** altında bulunan paketleri aynı şekilde kopyalayıp yapıştırın. _(cupertino_icons dan iki tane olmamasına dikkat edin.)_
 4. **flutter pub get** komutu ile paketleri yükleyin.
 
**NOT!** Kullandığınız paketlerin sürümlerinin birebir aynı olduğundan emin olun! Yeni sürümlerde komutlar veya uygulama şekilleri değişiklik gösterebilir.
**NOT!** Firebase bağlantısını yapıp **google-services.json** dosyasını **android/app/** altına eklemeyi unutmayın.

## Bazı Komutlar
SHA1 İmza
* ```keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android```

## Yayın ve Kayıdı

Canlı yayına ve kaydına [bu bağlantıya](https://www.youtube.com/watch?v=4Vf6_qNhpXc) tıklayarak ulaşabilirsiniz.
