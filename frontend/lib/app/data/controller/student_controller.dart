import 'package:frontend/app/data/models/table/student_model.dart';
import 'package:frontend/app/data/services/student_services.dart';
import 'package:frontend/core/local_storage_service.dart';
import 'package:get/get.dart';

class StudentController extends GetxController{
  final Rxn<StudentModel> student = Rxn<StudentModel>();

  @override
  void onInit(){
    super.onInit();
    final cached = LocalStorageService.getStudent();
    if (cached != null) {
      student.value = cached;
      print('[STUDENT CONTROLLER] Data student dimuat dari cache');
    }
  }

  Future<void> getMyData() async {
    try {
      final student = await StudentServices().getMyData();
      LocalStorageService.saveStudent(student);
      this.student.value = student;
      print('[STUDENT CONTROLLER] Data student berhasil dimuat');
    } catch (e) {
      print('[STUDENT CONTROLLER] Error: $e]');
    }
  }

  Future<void> updateMyStudentData(int nim, String fullName, String majors, String studyProgram) async {
    try {
      final student = await StudentServices().updateMyData(nim, fullName, majors, studyProgram);
      this.student.value = student;
      print('[STUDENT CONTROLLER] Data student berhasil diupdate');
    } catch (e) {
      print('[STUDENT CONTROLLER] Error: $e]');
    }
  }

}