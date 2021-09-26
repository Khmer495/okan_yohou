const bool kReleaseMode = false;
// bool.fromEnvironment('dart.vm.product', defaultValue: false);

String apiDomain() {
  /// リリースモードならtrue
  // if (kReleaseMode) {
  //   return 'http://ec2-54-85-124-97.compute-1.amazonaws.com:8000/api/';
  // }

  //自分自身のwifiのIPアドレスを使用
  // return 'http://192.168.3.3:8000/api/';
  // return 'http://192.168.1.4:8000/api/';
  return 'http://192.168.3.2:8002/api/';
  // return 'http://gamehub.electoria.jp:8002/api/';
}

String version() {
  return 'v0/';
}
