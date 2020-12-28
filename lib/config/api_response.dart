import 'package:roomie/config/configs.dart';

class ApiResponse<T> {
  Status status;

  T data;

  String message;

  ApiResponse.uninitialized(this.message) : status = Status.Uninitialized;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { Uninitialized,LOADING, COMPLETED, ERROR }
