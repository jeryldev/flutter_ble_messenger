import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatesController extends GetxController {
  DateTime dateTimeNow = DateTime.now();
  var timeNow = 0.obs;
  var greeting = ''.obs;

  @override
  void onInit() {
    super.onInit();
    timeNow = RxInt(int.parse(DateFormat('kk').format(dateTimeNow)));
    setGreeting(timeNow.value);
    print('timenow:: $timeNow');
    print('greeting:: $greeting');
  }

  @override
  void onClose() {
    timeNow = RxInt(0);
    greeting = RxString('');
    print('testing on the dates controller');
    print('timenow:: $timeNow');
    print('greeting:: $greeting');
    super.onClose();
  }

  void setGreeting(int timeValue) {
    if (timeValue <= 12) {
      greeting = RxString('Good Morning');
    } else if ((timeValue > 12) && (timeValue <= 16)) {
      greeting = RxString('Good Afternoon');
    } else if ((timeValue > 16) && (timeValue < 20)) {
      greeting = RxString('Good Evening');
    } else {
      greeting = RxString('Good Night');
    }
  }

  String getVerboseDateTimeRepresentation(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'Just now';
    }

    String roughTimeString = DateFormat('jm').format(dateTime);

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }

    DateTime yesterday = now.subtract(Duration(days: 1));

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'Yesterday, ' + roughTimeString;
    }

    if (now.difference(localDateTime).inDays < 4) {
      String weekday = DateFormat('EEEE').format(localDateTime);

      return '$weekday, $roughTimeString';
    }

    return '${DateFormat('yMd').format(dateTime)}, $roughTimeString';
  }
}
