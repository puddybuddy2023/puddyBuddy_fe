import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

const _API_PREFIX =
    'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/petsnalColors';

class PetsnalColorProvider with ChangeNotifier {
  Future<Map<dynamic, dynamic>> PetsnalColorStart(
      XFile? showImage, int preferId) async {
    dynamic sendImage = showImage!.path;
    var imageFormData =
        FormData.fromMap({'file': await MultipartFile.fromFile(sendImage)});

    print("사진을 서버에 업로드 합니다.");
    var photoDio = Dio();
    //dio.options.contentType = Headers.formUrlEncodedContentType;

    try {
      photoDio.options.contentType = Headers.jsonContentType;

      //dio.options.headers = {'token': token};
      var photoResponse = await photoDio.post(
        'http://ec2-13-124-164-167.ap-northeast-2.compute.amazonaws.com/uploadNewImg',
        data: imageFormData,
      );

      print('성공적으로 업로드했습니다');
      print(photoResponse.data['uploadImg']);

      /* 시작 정보 전달 */
      Response response;
      Dio dio = Dio();
      response = await dio.post("$_API_PREFIX/start",
          data: {'preferId': 1, 'photoUrl': photoResponse.data['uploadImg']},
          options: Options(contentType: Headers.jsonContentType));

      Map<dynamic, dynamic> result = (response.data)['result'];
      //print(result);
      return result;
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.response?.statusCode}');
        print('Response Data: ${e.response?.data}');
        print('Error: ${e.error}'); // 추가된 부분
        return {};
      } else {
        print('Unexpected Error: $e');
        return {};
      }
    }
  }
}

PetsnalColorProvider petsnalColorProvider = PetsnalColorProvider();
