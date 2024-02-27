class UrlConstant {
  static const String LOCAL_BE = '192.168.1.14:8181';
  static const String SERVER_BE = '210.245.96.229:18686';
  static const String API_URL = 'http://${LOCAL_BE}/api';
  static const String SIGN_IN = 'users/login';
  static const String GET_USER_INFO = 'users/getProfile';
  static const String REFRESH_TOKEN = 'users/refresh-token';
  static const String GET_ALL_USER_BY_IS_SELLER = 'users/getAllUserByIsSeller';
  static const String GET_ALL_ORDER = 'notify/listNotiAndUser';
  static const String GET_ALL_PRODUCT = 'items/listItem';
  static const String GET_ALL_RECEIVED = 'orders/getDataXacNhan';
  static const String GET_ALL_COMPLETE = 'orders/getDataComplete';
  static const String CONFIRM_SELLER = 'notify/confirmSeller';
  static const String GET_ALL_LIST_ORDER_BY_DATE_AND_STATUS = 'orders/findByOrdersDtoNewAAndActiveIAndIdShipper';
  static const String GET_ALL_LIST_ORDER_ORGANIC = 'orders/listOrderSinhHoatAndDate';
  static const String GET_ALL_LIST_ORDER_BY_STATUS = 'orders/findByOrdersDtoNewSAndStatusAndActive';
  static const String CONFIRM_HOUSEHOLD_GARBASE = 'orders/xacnhandonsinhHoat';
  static final String GET_LEADERBOARD = 'orders/listCompeteShipper';
  static final String GET_BOOKINGS = 'booking/getAllBooking';
  static const String REQUEST_CONFIRM_PLASTIC = 'booking/addItems';
  static const String CONFIRM_ORGANIC = 'booking/acceptOrganicBooking';
  static final String GET_INFO_CHART = 'orders/getInfoChart';
  static final String GET_DETAIL_BOOKING = 'booking/getDetail';
  static final String SHIPPER_REGISTER = 'booking/shipperRegister';

}
