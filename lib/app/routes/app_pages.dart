import 'package:crud_flutter_api/app/modules/menu/monitoring/bindings/monitoring_binding.dart';
import 'package:crud_flutter_api/app/modules/menu/monitoring/views/monitoring_view.dart';
import 'package:crud_flutter_api/app/modules/menu/ternak_saya/bindings/ternak_saya_binding.dart';
import 'package:crud_flutter_api/app/modules/menu/ternak_saya/views/ternak_saya_view.dart';
import 'package:get/get.dart';

import '../modules/CRUD/hewan/add_hewan/bindings/add_hewan_binding.dart';
import '../modules/CRUD/hewan/add_hewan/views/add_hewan.dart';
import '../modules/CRUD/hewan/detail_hewan/bindings/detail_hewan_binding.dart';
import '../modules/CRUD/hewan/detail_hewan/views/detail_hewan_view.dart';
import '../modules/CRUD/inseminasi/add_inseminasi/bindings/add_inseminasi_binding.dart';
import '../modules/CRUD/inseminasi/add_inseminasi/views/add_inseminasi.dart';
import '../modules/CRUD/inseminasi/detail_inseminasi/bindings/detail_inseminasi_binding.dart';
import '../modules/CRUD/inseminasi/detail_inseminasi/views/detail_inseminasi_view.dart';
import '../modules/CRUD/kandang/add_kandang/bindings/add_kandang_binding.dart';
import '../modules/CRUD/kandang/add_kandang/views/add_kandang.dart';
import '../modules/CRUD/kandang/detail_kandang/bindings/detail_kandang_binding.dart';
import '../modules/CRUD/kandang/detail_kandang/views/detail_kandang_view.dart';
import '../modules/CRUD/kelahiran/add_kelahiran/bindings/add_kelahiran_binding.dart';
import '../modules/CRUD/kelahiran/add_kelahiran/views/add_kelahiran.dart';
import '../modules/CRUD/kelahiran/detail_kelahiran/bindings/detail_kelahiran_binding.dart';
import '../modules/CRUD/kelahiran/detail_kelahiran/views/detail_kelahiran_view.dart';
import '../modules/CRUD/pengobatan/add_pengobatan/bindings/add_pengobatan_binding.dart';
import '../modules/CRUD/pengobatan/add_pengobatan/views/add_pengobatan.dart';
import '../modules/CRUD/pengobatan/detail_pengobatan/bindings/detail_pengobatan_binding.dart';
import '../modules/CRUD/pengobatan/detail_pengobatan/views/detail_pengobatan_view.dart';
import '../modules/CRUD/peternak/add_peternak/bindings/add_peternak_binding.dart';
import '../modules/CRUD/peternak/add_peternak/views/add_peternak.dart';
import '../modules/CRUD/peternak/detail_peternak/bindings/detail_peternak_binding.dart';
import '../modules/CRUD/peternak/detail_peternak/views/detail_peternak_view.dart';
import '../modules/CRUD/petugas/add_petugas/bindings/add_petugas_binding.dart';
import '../modules/CRUD/petugas/add_petugas/views/add_petugas.dart';
import '../modules/CRUD/petugas/detail_petugas/bindings/detail_petugas_binding.dart';
import '../modules/CRUD/petugas/detail_petugas/views/detail_petugas_view.dart';
import '../modules/CRUD/pkb/add_pkb/bindings/add_pkb_binding.dart';
import '../modules/CRUD/pkb/add_pkb/views/add_pkb.dart';
import '../modules/CRUD/pkb/detail_pkb/bindings/detail_pkb_binding.dart';
import '../modules/CRUD/pkb/detail_pkb/views/detail_pkb_view.dart';
import '../modules/CRUD/vaksin/add_vaksin/bindings/add_vaksin_binding.dart';
import '../modules/CRUD/vaksin/add_vaksin/views/add_vaksin.dart';
import '../modules/CRUD/vaksin/detail_vaksin/bindings/detail_vaksin_binding.dart';
import '../modules/CRUD/vaksin/detail_vaksin/views/detail_vaksin_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menu/PKB/bindings/pkb_binding.dart';
import '../modules/menu/PKB/views/pkb_view.dart';
import '../modules/menu/hewan/bindings/hewan_binding.dart';
import '../modules/menu/hewan/views/hewan_view.dart';
import '../modules/menu/inseminasi/bindings/inseminasi_binding.dart';
import '../modules/menu/inseminasi/views/inseminasi_view.dart';
import '../modules/menu/kandang/bindings/kandang_binding.dart';
import '../modules/menu/kandang/views/kandang_view.dart';
import '../modules/menu/kelahiran/bindings/kelahiran_binding.dart';
import '../modules/menu/kelahiran/views/kelahiran_view.dart';
import '../modules/menu/pengobatan/bindings/pengobatan_binding.dart';
import '../modules/menu/pengobatan/views/pengobatan_view.dart';
import '../modules/menu/peternak/bindings/peternak_binding.dart';
import '../modules/menu/peternak/views/peternak_view.dart';
import '../modules/menu/petugas/bindings/petugas_binding.dart';
import '../modules/menu/petugas/views/petugas_view.dart';
import '../modules/menu/vaksin/bindings/vaksin_binding.dart';
import '../modules/menu/vaksin/views/vaksin_view.dart';
import '../modules/navigation/bindings/navigation_binding.dart';
import '../modules/navigation/views/navigation_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/start/bindings/start_binding.dart';
import '../modules/start/views/start_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.START;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.START,
      page: () => const StartView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    // GetPage(
    //   name: _Paths.REGISTER,
    //   page: () => const RegisterView(),
    //   binding: RegisterBinding(),
    // ),

    GetPage(
      name: _Paths.PKB,
      page: () => const PKBView(),
      binding: PkbBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.NAVIGATION,
      page: () => NavigationView(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.HEWAN,
      page: () => const HewanView(),
      binding: HewanBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.PENGOBATAN,
      page: () => const PengobatanView(),
      binding: PengobatanBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.KELAHIRAN,
      page: () => const KelahiranView(),
      binding: KelahiranBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.PEMILIK,
      page: () => const PeternakView(),
      binding: PeternakBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.INSEMINASI,
      page: () => const InseminasiView(),
      binding: InseminasiBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.VAKSIN,
      page: () => const VaksinView(),
      binding: VaksinBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.PETUGAS,
      page: () => const PetugasView(),
      binding: PetugasBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.KANDANG,
      page: () => const KandangView(),
      binding: KandangBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.MONITORING,
      page: () => const MonitoringView(),
      binding: MonitoringBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.TERNAKSAYA,
      page: () => const TernakSayaView(),
      binding: TernakSayaBinding(),
      transition: Transition.rightToLeft,
    ),

    // ADD Data

    GetPage(
      name: _Paths.ADDHEWAN,
      page: () => const AddHewanView(),
      binding: AddHewanBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ADDPETERNAK,
      page: () => const AddPeternakView(),
      binding: AddPeternakBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ADDPETUGAS,
      page: () => const AddPetugasView(),
      binding: AddPetugasBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ADDVAKSIN,
      page: () => const AddVaksinView(),
      binding: AddVaksinBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ADDINSEMINASI,
      page: () => const AddInseminasiView(),
      binding: AddInseminasiBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ADDPENGOBATAN,
      page: () => const AddPengobatanView(),
      binding: AddPengobatanBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ADDPKB,
      page: () => const AddPkbView(),
      binding: AddPkbBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ADDKELAHIRAN,
      page: () => const AddKelahiranView(),
      binding: AddkelahiranBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ADDKANDANG,
      page: () => const AddKandangView(),
      binding: AddKandangBinding(),
      transition: Transition.rightToLeft,
    ),

    //DETAIL POST

    GetPage(
      name: _Paths.DETAILPETUGAS,
      page: () => const DetailPetugasView(),
      binding: DetailPetugasBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAILHEWAN,
      page: () => const DetailHewanView(),
      binding: DetailHewanBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAILPETERNAK,
      page: () => DetailPeternakView(),
      binding: DetailPeternakBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAILINSEMINASI,
      page: () => const DetailInseminasiView(),
      binding: DetailInseminasiBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAILVAKSIN,
      page: () => const DetailVaksinView(),
      binding: DetailVaksinBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAILPKB,
      page: () => const DetailPkbView(),
      binding: DetailPkbBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAILKELAHIRAN,
      page: () => const DetailKelahiranView(),
      binding: DetailKelahiranBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAILPENGOBATAN,
      page: () => const DetailPengobatanView(),
      binding: DetailPengobatanBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.DETAILKANDANG,
      page: () => const DetailKandangView(),
      binding: DetailKandangBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
