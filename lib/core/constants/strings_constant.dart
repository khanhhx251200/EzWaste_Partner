import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Vui lòng nhập mật khẩu";
const String kShortPassError = "Mật khẩu quá ngắn";
const String kMatchPassError = "Mật khẩu không đúng";
const String kNamelNullError = "Vui lòng nhập họ và tên";
const String kPhoneNumberNullError = "Vui lòng nhập số điện thoại";
const String kAddressNullError = "Please Enter your address";
const String kRequired = "không được để trống";
const String kPhone = "Số điện thoại";
const String kPassword = "Mật khẩu";
const String kSignIn = "Đăng nhập";
const String kSignUp = "Đăng ký";
const String kRegisterAccount = "Đăng ký tài khoản";
const String kProfile = "Trang cá nhân";
const String kMyAccount = "Tài khoản của tôi";
const String kNotifications = "Thông báo";
const String kSettings = "Cài đặt";
const String kHelpCenter = "Trung tâm hỗ trợ";
const String kLogOut = "Đăng xuất";
const String kStart = "Bắt đầu";
const String kHome = "Trang chủ";
const String kHistory = "Lịch sử";
const String kMe = "Tôi";
const String kMenu = "Menu";
const String kSeeMore = "Xem thêm";
const String kMember = "Member";
const String kSave = "Lưu";
const String kUpdate = "Cập nhật";
const String kRewardPoints = "Điểm thưởng";
const String kSurplus = "Số dư";
const String kISell = "Tôi bán";
const String kBooking = "Đặt lịch";
const String kWallet = "Ví";
const String kChangePassword = "Thay đổi mật khẩu";
const String kDelete = "Xóa";
const String kAddress = "Địa chỉ";
const String kCopy = "Sao chép";
const String kCollapse = "Thu gọn";
const String kRate = "Đánh giá";
const String kLeaderboard = "Bảng xếp hạng";
const String kCreateOrder = "Tạo đơn thu gom";
const String kFollow = "Theo dõi";
const String kChart = "Thống kê";
const String kCalendarBooking = "Lịch thu gom";
const String kInfoBooking = "Thông tin thu gom";
const String kConfirmRecycle = "Xác nhận thu gom rác";
const String kOrganicRecycle = "Rác sinh hoạt";
const String kPlasticRecycle = "Rác tái chế";
const String kSendInfoCollect = "Gửi thông tin thu gom";
const String kBackToHome = "Quay về màn hình chính";
const String kFollowTracking = "Theo dõi lịch thu gom";
const String kFilter = "Bộ lọc";
const String kFilterTime = "Bộ lọc thời gian";
const String kSortBy = "Sắp xếp theo";
const String kNotReceived = "Chưa nhận đơn";
const String kNotDoing = "Chưa thu gom";
const String kDoAndWaitConfirm= "Đã thu gom - Chờ xác nhận";
const String kWaitConfirm= "Chờ xác nhận";
const String kCompleted = "Đã hoàn thành";
const String kClassifyRecycle = "Phân loại rác";
const String kStatus = "Trạng thái";
const String kMyChart = "Thống kê cá nhân";
const String kQuantityTaken = "Số lượng rác đã thu gom";
const String kApply = "Áp dụng";
const String kCollect = "Thu gom";
const String kAgree = "Đồng ý";
const String kInfoCustomer = "Thông tin khách hàng";
const String kSendInfo = "Gửi thông tin";
const String kNext = "Tiếp theo";

const String kNotCollect = "Chưa thu gom";
const String kRefuse = "Từ chối";
const String kComplete = "Hoàn thành";

const String kTOP = "TOP";
const String kBOTTOM = "BOTTOM";

const String PLASTIC = "PLASTIC";
const String ORGANIC = "ORGANIC";

const String YEAR = "YEAR";
const String MONTH = "MONTH";
const String DAY = "DAY";

//Filter Booking
const int FILTER_ORGANIC = 1;
const int FILTER_PLASTIC = 2;
const int FILTER_NOT_COLLECT = 2;
const int FILTER_WAIT_CONFIRM = 3;
const int FILTER_COMPLETE = 4;
const int FILTER_REFUSE = 5;
const String SORT_BY_NEAR = 'NEAR';
const String SORT_BY_FAR = 'FAR';
const String kNearestCollectTime = "Thời gian thu gom gần nhất";
const String kFurthestCollectTime = "Thời gian thu gom xa nhất";

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

convertIntToCurrency(int currency) {
  return NumberFormat.currency(locale: "vi").format(currency);
}

String convertDateDetail(int timeStamp) {
  final df = new DateFormat('kk:mm dd/MM/yyyy');
  var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return df.format(date).toString();
}

String convertTimeStampToString(int timeStamp) {
  final df = new DateFormat('dd/MM/yyyy');
  var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return df.format(date).toString();
}

String convertDateToString(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

DateTime convertStringToDateTime(String time) {
  return DateFormat('dd/MM/yyyy').parse(time);
}

String statusString(int status) {
  if (status == 1) {
    return kNotReceived;
  } else if (status == 2) {
    return kNotCollect;
  } else if (status == 3) {
    return kDoAndWaitConfirm;
  } else if (status == 4) {
    return kCompleted;
  } else {
    return kRefuse;
  }
}

IconData statusIcon(int status) {
  if (status == 1) {
    return Icons.error;
  } else if (status == 2 || status == 3) {
    return Icons.timelapse;
  } else if (status == 4) {
    return Icons.check_circle;
  } else {
    return Icons.cancel;
  }
}

