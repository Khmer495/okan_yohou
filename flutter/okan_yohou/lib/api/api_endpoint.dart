enum API {
  alerts,
}

String endPoint(API api) {
  switch (api) {
      case API.alerts:
      return 'alerts';
  }
}
