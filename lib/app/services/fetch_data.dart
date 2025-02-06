import 'package:crud_flutter_api/app/data/hewan_model.dart';
import 'package:crud_flutter_api/app/data/inseminasi_model.dart';
import 'package:crud_flutter_api/app/data/jenisvaksin_model.dart';
import 'package:crud_flutter_api/app/data/kandang_model.dart';
import 'package:crud_flutter_api/app/data/peternak_model.dart';
import 'package:crud_flutter_api/app/data/petugas_model.dart';
import 'package:crud_flutter_api/app/services/hewan_api.dart';
import 'package:crud_flutter_api/app/services/inseminasi_api.dart';
import 'package:crud_flutter_api/app/services/jenisvaksin_api.dart';
import 'package:crud_flutter_api/app/services/kandang_api.dart';
import 'package:crud_flutter_api/app/services/peternak_api.dart';
import 'package:crud_flutter_api/app/services/petugas_api.dart';
import 'package:crud_flutter_api/app/widgets/message/errorMessage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FetchData {
  RxString selectedPeternakId = ''.obs;
  RxList<PeternakModel> peternakList = <PeternakModel>[].obs;

  RxString selectedPetugasId = ''.obs;
  RxList<PetugasModel> petugasList = <PetugasModel>[].obs;

  RxString selectedKandangId = ''.obs;
  RxList<KandangModel> kandangList = <KandangModel>[].obs;
  RxList<KandangModel> filteredKandangList =
      <KandangModel>[].obs; // List filtered for the selected peternak

  RxString selectedHewanEartag = ''.obs;
  RxList<HewanModel> hewanList = <HewanModel>[].obs;
  RxList<HewanModel> filteredHewanList =
      <HewanModel>[].obs; // List filtered for the selected peternak

  RxString selectedJenisVaksin = ''.obs;
  RxList<JenisVaksinModel> jenisVaksinList = <JenisVaksinModel>[].obs;
  RxList<JenisVaksinModel> filteredJenisVaksinList = <JenisVaksinModel>[].obs;

  RxString selectedInseminasiId = ''.obs;
  RxList<InseminasiModel> inseminasiList = <InseminasiModel>[].obs;
  RxList<InseminasiModel> filteredInseminasiList = <InseminasiModel>[].obs;

  Future<List<PeternakModel>> fetchPeternaks() async {
    try {
      final PeternakListModel peternakListModel =
          await PeternakApi().loadPeternakApi();
      final List<PeternakModel> peternaks = peternakListModel.content ?? [];
      if (peternaks.isNotEmpty) {
        selectedPeternakId.value = peternaks.first.idPeternak ?? '';
      }
      peternakList.assignAll(peternaks);
      return peternaks;
    } catch (e) {
      print('Error fetching peternaks: $e');
      showErrorMessage("Error fetching peternaks: $e");
      return [];
    }
  }

  Future<List<PetugasModel>> fetchPetugas() async {
    try {
      final PetugasListModel petugasListModel =
          await PetugasApi().loadPetugasApi();
      final List<PetugasModel> petugass = petugasListModel.content ?? [];
      if (petugass.isNotEmpty) {
        selectedPetugasId.value = petugass.first.nikPetugas ?? '';
      }
      petugasList.assignAll(petugass);
      return petugass;
    } catch (e) {
      print('Error fetching Petugas: $e');
      showErrorMessage("Error fetching Petugas: $e");
      return [];
    }
  }

  Future<List<KandangModel>> fetchKandangs() async {
    try {
      final KandangListModel kandangListModel =
          await KandangApi().loadKandangApi();
      final List<KandangModel> kandangs = kandangListModel.content ?? [];
      if (kandangs.isNotEmpty) {
        selectedKandangId.value = kandangs.first.idKandang ?? '';
      }
      kandangList.assignAll(kandangs);
      filterKandangByPeternak(selectedPeternakId.value); // Apply initial filter
      return kandangs;
    } catch (e) {
      print('Error fetching kandangs: $e');
      showErrorMessage("Error fetching kandangs: $e");
      return [];
    }
  }

  Future<List<HewanModel>> fetchHewan() async {
    try {
      final HewanListModel hewanListModel = await HewanApi().loadHewanApi();
      final List<HewanModel> hewan = hewanListModel.content ?? [];
      if (hewan.isNotEmpty) {
        selectedHewanEartag.value = hewan.first.kodeEartagNasional ?? '';
      }
      hewanList.assignAll(hewan);
      filterHewanByPeternak(selectedPeternakId.value); // Apply initial filter
      return hewan;
    } catch (e) {
      print('Error fetching hewan: $e');
      showErrorMessage("Error fetching hewan: $e");
      return [];
    }
  }

  // Future<List<JenisVaksinModel>> fetchJenisVaksin() async {
  //   try {
  //     final JenisVaksinModel jenisVaksinModel = await JenisVaksinApi().loadJenisVaksinApi();
  //     final List<JenisVaksinModel> hewan = jenisVaksinModel.content ?? [];
  //     if (hewan.isNotEmpty) {
  //       selectedHewanEartag.value = hewan.first.kodeEartagNasional ?? '';
  //     }
  //     hewanList.assignAll(hewan);
  //     filterHewanByPeternak(selectedPeternakId.value); // Apply initial filter
  //     return hewan;
  //   } catch (e) {
  //     print('Error fetching hewan: $e');
  //     showErrorMessage("Error fetching hewan: $e");
  //     return [];
  //   }
  // }

  Future<List<InseminasiModel>> fetchInseminasi() async {
    try {
      final InseminasiListModel inseminasiListModel =
          await InseminasiApi().loadInseminasiAPI();
      final List<InseminasiModel> inseminasi =
          inseminasiListModel.content ?? [];

      // Log untuk memeriksa data yang diterima
      print('Data Inseminasi fetched: ${inseminasi.length} items');

      if (inseminasi.isNotEmpty) {
        selectedInseminasiId.value = inseminasi.first.idInseminasi ?? '';
      }
      inseminasiList.assignAll(inseminasi);

      // Log sebelum filter
      print('Inseminasi List before filtering: ${inseminasiList.length}');

      filterInseminasiByPeternak(
          selectedPeternakId.value); // Apply initial filter

      // Log setelah filter
      print('Filtered Inseminasi List: ${filteredInseminasiList.length}');

      return inseminasi;
    } catch (e) {
      print('Error fetching Inseminasi: $e');
      showErrorMessage("Error fetching Inseminasi: $e");
      return [];
    }
  }

//FILTER HEWAN
  void filterHewanByPeternak(String peternakId) {
    print('Peternak ID selected: $peternakId');
    print('Total Hewan before filter: ${hewanList.length}');

    hewanList.forEach((hewan) {
      print(
          'Hewan ID: ${hewan.kodeEartagNasional}, Peternak ID: ${hewan.idPeternak?.idPeternak}');
    });

    // Filter hewan berdasarkan peternak ID
    filteredHewanList.value = hewanList.where((hewan) {
      return hewan.idPeternak?.idPeternak == peternakId;
    }).toList();

    // Jika filteredHewanList kosong, atur selectedHewanEartag ke null atau nilai default
    if (filteredHewanList.isNotEmpty) {
      selectedHewanEartag.value =
          filteredHewanList.first.kodeEartagNasional ?? '';
    } else {
      selectedHewanEartag.value = ''; // Nilai default jika tidak ada item
    }

    print('Total Hewan after filter: ${filteredHewanList.length}');
  }

//FILTER KANDANG
  void filterKandangByPeternak(String peternakId) {
    print('Peternak ID selected: $peternakId');
    print('Total Kandang before filter: ${kandangList.length}');

    kandangList.forEach((kandang) {
      print(
          'kandang ID: ${kandang.idKandang}, Peternak ID: ${kandang.idPeternak?.idPeternak}');
    });

    // Filter hewan berdasarkan peternak ID
    filteredKandangList.value = kandangList.where((kandang) {
      return kandang.idPeternak?.idPeternak == peternakId;
    }).toList();

    // Jika filteredHewanList kosong, atur selectedHewanEartag ke null atau nilai default
    if (filteredKandangList.isNotEmpty) {
      selectedKandangId.value = filteredKandangList.first.idKandang ?? '';
    } else {
      selectedKandangId.value = ''; // Nilai default jika tidak ada item
    }

    print('Total Kandang after filter: ${filteredKandangList.length}');
  }

//FILTER INSEMINASI
  void filterInseminasiByPeternak(String peternakId) {
    print('Peternak ID selected: $peternakId');
    print('Total Hewan before filter: ${inseminasiList.length}');

    inseminasiList.forEach((inseminasi) {
      print(
          'Inseminasi ID: ${inseminasi.idInseminasi}, Peternak ID: ${inseminasi.idPeternak?.idPeternak}');
    });

    // Filter inseminasi berdasarkan peternak ID
    filteredInseminasiList.value = inseminasiList.where((inseminasi) {
      return inseminasi.idPeternak?.idPeternak == peternakId;
    }).toList();

    // Jika filteredHewanList kosong, atur selectedHewanEartag ke null atau nilai default
    if (filteredInseminasiList.isNotEmpty) {
      selectedInseminasiId.value =
          filteredInseminasiList.first.idInseminasi ?? '';
    } else {
      selectedInseminasiId.value = ''; // Nilai default jika tidak ada item
    }

    print('Total Inseminasi after filter: ${filteredInseminasiList.length}');
  }
}
// class FetchData {
//   RxString selectedPeternakId = ''.obs;
//   RxList<PeternakModel> peternakList = <PeternakModel>[].obs;

//   RxString selectedPetugasId = ''.obs;
//   RxList<PetugasModel> petugasList = <PetugasModel>[].obs;

//   RxString selectedKandangId = ''.obs;
//   RxList<KandangModel> kandangList = <KandangModel>[].obs;

//   RxString selectedHewanEartag = ''.obs;
//   RxList<HewanModel> hewanList = <HewanModel>[].obs;

// //get data peternak
//   Future<List<PeternakModel>> fetchPeternaks() async {
//     try {
//       final PeternakListModel peternakListModel =
//           await PeternakApi().loadPeternakApi();
//       final List<PeternakModel> peternaks = peternakListModel.content ?? [];
//       if (peternaks.isNotEmpty) {
//         selectedPeternakId.value = peternaks.first.idPeternak ?? '';
//       }
//       peternakList.assignAll(peternaks);
//       return peternaks;
//     } catch (e) {
//       print('Error fetching peternaks: $e');
//       showErrorMessage("Error fetching peternaks: $e");
//       return [];
//     }
//   }

// //get data petugas
//   Future<List<PetugasModel>> fetchPetugas() async {
//     try {
//       final PetugasListModel petugasListModel =
//           await PetugasApi().loadPetugasApi();
//       final List<PetugasModel> petugass = petugasListModel.content ?? [];
//       if (petugass.isNotEmpty) {
//         selectedPetugasId.value = petugass.first.nikPetugas ?? '';
//       }
//       petugasList.assignAll(petugass);
//       return petugass;
//     } catch (e) {
//       print('Error fetching Petugas: $e');
//       showErrorMessage("Error fetching Petugas: $e");
//       return [];
//     }
//   }

//   //get data kandang
//   Future<List<KandangModel>> fetchKandangs() async {
//     try {
//       final KandangListModel kandangListModel =
//           await KandangApi().loadKandangApi();
//       final List<KandangModel> kandangs = kandangListModel.content ?? [];
//       if (kandangs.isNotEmpty) {
//         selectedKandangId.value = kandangs.first.idKandang ?? '';
//       }
//       kandangList.assignAll(kandangs);
//       return kandangs;
//     } catch (e) {
//       print('Error fetching peternaks: $e');
//       showErrorMessage("Error fetching peternaks: $e");
//       return [];
//     }
//   }

//   Future<List<HewanModel>> fetchHewan() async {
//     try {
//       final HewanListModel hewanListModel = await HewanApi().loadHewanApi();
//       final List<HewanModel> hewan = hewanListModel.content ?? [];
//       if (hewan.isNotEmpty) {
//         selectedHewanEartag.value = hewan.first.kodeEartagNasional ?? '';
//       }
//       hewanList.assignAll(hewan);
//       return hewan;
//     } catch (e) {
//       print('Error fetching hewan: $e');
//       showErrorMessage("Error fetching hewan: $e");
//       return [];
//     }
//   }
//}
