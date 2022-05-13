import 'package:custom_app/forthpage/model/diary.dart';
import 'package:custom_app/secondpage/model/peroid_data.dart';
import 'package:custom_app/secondpage/model/peroid_day.dart';
import 'package:custom_app/thirdpage/model/Treatments.dart';
import 'package:custom_app/thirdpage/model/cycle_period.dart';
import 'package:custom_app/thirdpage/model/investigation.dart';
import 'package:custom_app/thirdpage/model/medikamente.dart';
import 'package:custom_app/thirdpage/model/time_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomDB {
  static final CustomDB instance = CustomDB._init();

  static Database _database;

  var cyclePeriod = 'cycle_period';
  var perioddata = 'period_data';
  var periodday = 'period_day';
  var investigation = 'investigation';
  var treatments = 'treatments';
  var diary = 'diary';
  var medikamente = 'medikamente';
  var timelist = 'time_list';

  CustomDB._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('my_custom_app.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    //final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    // final integerTypeWithNull = 'INTEGER NULL';

    await db.execute('''CREATE TABLE $investigation (
    ${InvestigationsField.id} $idType, 
    ${InvestigationsField.investigations} $textType,
    ${InvestigationsField.date} $textType,
    ${InvestigationsField.time} $textType,
    ${InvestigationsField.alarmTime} $textType,
    ${InvestigationsField.text} $textType,
    ${InvestigationsField.cycleNumber} $integerType,
    ${InvestigationsField.notificationId} $integerType,
    ${InvestigationsField.isChecked} $integerType
    )''');

    await db.execute('''CREATE TABLE $periodday (
    ${PeriodDayField.id} $idType, 
    ${PeriodDayField.startDate} $textType,
    ${PeriodDayField.endDate} $textType
    )''');

    await db.execute('''CREATE TABLE $treatments (
    ${TreatmentsField.id} $idType, 
    ${TreatmentsField.date} $textType,
    ${TreatmentsField.time} $textType,
    ${TreatmentsField.alarmTime} $textType,
    ${TreatmentsField.text} $textType,
    ${TreatmentsField.treatment} $textType,
    ${TreatmentsField.cycleNumber} $integerType,
    ${TreatmentsField.notificationId} $integerType,
    ${TreatmentsField.isChecked} $integerType
    )''');

    await db.execute('''CREATE TABLE $diary (
    ${DiaryField.id} $idType, 
    ${DiaryField.date} $textType,
    ${DiaryField.text} $textType,
    ${DiaryField.image} $textType
    )''');

    await db.execute('''CREATE TABLE $medikamente (
    ${MedikamenteDataField.id} $idType, 
    ${MedikamenteDataField.drugController} $textType,
    ${MedikamenteDataField.dosageController} $textType,
    ${MedikamenteDataField.typeOfExpenditureText} $textType,
    ${MedikamenteDataField.typeOfExpenditureImage} $textType,
    ${MedikamenteDataField.startDate} $textType,
    ${MedikamenteDataField.endDate} $textType,
    ${MedikamenteDataField.time} $textType,
    ${MedikamenteDataField.alarmTime} $textType,
    ${MedikamenteDataField.otherTime} $textType,
    ${MedikamenteDataField.cycleNumber} $integerType,
    ${MedikamenteDataField.notificationId} $integerType,
     ${MedikamenteDataField.isChecked} $int
    )''');

    await db.execute('''CREATE TABLE $cyclePeriod (
    ${CyclePeriodField.id} $idType, 
    ${CyclePeriodField.startDate} $textType,
    ${CyclePeriodField.cycleNumber} $integerType,
    ${CyclePeriodField.endDate} $textType,
     ${CyclePeriodField.typeOfTreatment} $textType
    )''');

    await db.execute('''CREATE TABLE $perioddata (
    ${PeriodDataField.id} $idType, 
    ${PeriodDataField.text} $textType,
    ${PeriodDataField.imageName} $textType, 
    ${PeriodDataField.value} $textType, 
    ${PeriodDataField.type} $integerType, 
    ${PeriodDataField.date} $textType
    )''');

    await db.execute('''CREATE TABLE $timelist (
    ${TimeDataField.id} $idType, 
    ${TimeDataField.time} $textType,
    ${TimeDataField.medikamentsId} $integerType,
    ${TimeDataField.notificationId} $integerType
    )''');
  }

  // ========== Time List ==========================

  Future<int> addTimeData(TimeData timeData) async {
    final db = await instance.database;
    final id = await db.insert(timelist, timeData.toMap());
    return id;
  }

  Future<List<TimeData>> getTimeList(int medikamentsId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      timelist,
      where: TimeDataField.medikamentsId + ' = ?',
      whereArgs: [medikamentsId],
    );

    return List.generate(maps.length, (i) {
      TimeData timeData = new TimeData();

      timeData.id = maps[i][TimeDataField.id];
      timeData.time = maps[i][TimeDataField.time];
      timeData.notificationId = maps[i][TimeDataField.notificationId];
      timeData.medikamentsId = maps[i][TimeDataField.medikamentsId];

      return timeData;
    });
  }

  Future<void> updateOtherTime(TimeData timeData) async {
    final db = await database;

    await db.update(
      timelist,
      timeData.toMap(),
      where: 'id = ?',
      whereArgs: [timeData.id],
    );
  }

  Future<void> deleteOtherTime(int id) async {
    final db = await database;
    await db.delete(
      timelist,
      where: TimeDataField.id + ' = ?',
      whereArgs: [id],
    );
  }

  // ========== Time List End==========================

  Future<int> addPeriodData(PeriodData periodData) async {
    final db = await instance.database;
    final id = await db.insert(perioddata, periodData.toMap());
    return id;
  }

  Future<List<PeriodData>> getPeriodData(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      perioddata,
      where: PeriodDataField.date + ' = ?',
      whereArgs: [date],
    );

    return List.generate(maps.length, (i) {
      PeriodData periodDay = new PeriodData();

      periodDay.id = maps[i][PeriodDataField.id];
      periodDay.text = maps[i][PeriodDataField.text];
      periodDay.imageName = maps[i][PeriodDataField.imageName];
      periodDay.type = maps[i][PeriodDataField.type];
      periodDay.date = maps[i][PeriodDataField.date];
      periodDay.value = maps[i][PeriodDataField.value];

      return periodDay;
    });
  }

  Future<List<PeriodData>> getDataForChart(int type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      perioddata,
      where: PeriodDataField.type + ' = ?',
      whereArgs: [type],
    );

    return List.generate(maps.length, (i) {
      PeriodData periodDay = new PeriodData();

      periodDay.id = maps[i][PeriodDataField.id];
      periodDay.text = maps[i][PeriodDataField.text];
      periodDay.imageName = maps[i][PeriodDataField.imageName];
      periodDay.type = maps[i][PeriodDataField.type];
      periodDay.date = maps[i][PeriodDataField.date];
      periodDay.value = maps[i][PeriodDataField.value];

      return periodDay;
    });
  }

  Future<List<PeriodData>> getPeriodDataWithType(String date, int type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      perioddata,
      where: PeriodDataField.date + ' = ? and ' + PeriodDataField.type + ' = ?',
      whereArgs: [date, type],
    );

    return List.generate(maps.length, (i) {
      PeriodData periodDay = new PeriodData();

      periodDay.id = maps[i][PeriodDataField.id];
      periodDay.text = maps[i][PeriodDataField.text];
      periodDay.imageName = maps[i][PeriodDataField.imageName];
      periodDay.type = maps[i][PeriodDataField.type];
      periodDay.date = maps[i][PeriodDataField.date];
      periodDay.value = maps[i][PeriodDataField.value];

      return periodDay;
    });
  }

  Future<List<PeriodData>> getOvulationDay(String date, int type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      perioddata,
      where:
          PeriodDataField.value + ' = ? and ' + PeriodDataField.type + ' = ?',
      whereArgs: [date, type],
    );

    return List.generate(maps.length, (i) {
      PeriodData periodDay = new PeriodData();

      periodDay.id = maps[i][PeriodDataField.id];
      periodDay.text = maps[i][PeriodDataField.text];
      periodDay.imageName = maps[i][PeriodDataField.imageName];
      periodDay.type = maps[i][PeriodDataField.type];
      periodDay.date = maps[i][PeriodDataField.date];
      periodDay.value = maps[i][PeriodDataField.value];

      return periodDay;
    });
  }

  Future<void> deletePeriodDataWithID(int id) async {
    final db = await database;
    await db.delete(
      perioddata,
      where: PeriodDataField.id + ' = ?',
      whereArgs: [id],
    );
  }

  Future<void> deletePeriodData() async {
    final db = await database;
    await db.delete(
      perioddata,
    );
  }

  Future<int> addPeriodDay(PeriodDay periodDayData) async {
    final db = await instance.database;
    final id = await db.insert(periodday, periodDayData.toMap());
    return id;
  }

  Future<List<PeriodDay>> getPeriodDay() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      periodday,
    );

    return List.generate(maps.length, (i) {
      PeriodDay periodDay = new PeriodDay();

      periodDay.id = maps[i][PeriodDayField.id];

      periodDay.startDate = DateTime.parse(maps[i][PeriodDayField.startDate]);
      periodDay.endDate = DateTime.parse(maps[i][PeriodDayField.endDate]);
      return periodDay;
    });
  }

  Future<void> deletePeriodDay() async {
    final db = await database;
    await db.delete(
      periodday,
    );
  }

  Future<int> addInvestigation(InvestigationsData cyclePeriodData) async {
    final db = await instance.database;
    final id = await db.insert(investigation, cyclePeriodData.toMap());
    return id;
  }

  Future<int> addInvestigationWithString(
      Map<String, dynamic> cyclePeriodData) async {
    final db = await instance.database;
    final id = await db.insert(investigation, cyclePeriodData);
    return id;
  }

  Future<void> updateInvestigation(
      InvestigationsData investigationsData) async {
    final db = await database;

    await db.update(
      investigation,
      investigationsData.toMap(),
      where: 'id = ?',
      whereArgs: [investigationsData.id],
    );
  }

  Future<List<InvestigationsData>> getInvestigation(int cycleNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      investigation,
      where: InvestigationsField.cycleNumber + ' = ?',
      whereArgs: [cycleNumber],
    );

    return List.generate(maps.length, (i) {
      InvestigationsData cyclePeriod = new InvestigationsData();
      cyclePeriod.investigations = maps[i][InvestigationsField.investigations];
      cyclePeriod.date = maps[i][InvestigationsField.date];
      cyclePeriod.time = maps[i][InvestigationsField.time];
      cyclePeriod.alarmTime = maps[i][InvestigationsField.alarmTime];
      cyclePeriod.text = maps[i][InvestigationsField.text];
      cyclePeriod.id = maps[i][InvestigationsField.id];
      cyclePeriod.cycleNumber = maps[i][InvestigationsField.cycleNumber];
      cyclePeriod.notificationId = maps[i][InvestigationsField.notificationId];
      cyclePeriod.isChecked = maps[i][InvestigationsField.isChecked];

      return cyclePeriod;
    });
  }

  Future<List<InvestigationsData>> getAllInvestigation() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      investigation,
    );

    return List.generate(maps.length, (i) {
      InvestigationsData cyclePeriod = new InvestigationsData();
      cyclePeriod.investigations = maps[i][InvestigationsField.investigations];
      cyclePeriod.date = maps[i][InvestigationsField.date];
      cyclePeriod.time = maps[i][InvestigationsField.time];
      cyclePeriod.alarmTime = maps[i][InvestigationsField.alarmTime];
      cyclePeriod.text = maps[i][InvestigationsField.text];
      cyclePeriod.id = maps[i][InvestigationsField.id];
      cyclePeriod.cycleNumber = maps[i][InvestigationsField.cycleNumber];
      cyclePeriod.notificationId = maps[i][InvestigationsField.notificationId];
      cyclePeriod.isChecked = maps[i][InvestigationsField.isChecked];

      return cyclePeriod;
    });
  }

  Future<List<InvestigationsData>> getInvestigationWithDate(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      investigation,
      where: InvestigationsField.date + ' = ?',
      whereArgs: [date],
    );

    return List.generate(maps.length, (i) {
      InvestigationsData cyclePeriod = new InvestigationsData();
      cyclePeriod.investigations = maps[i][InvestigationsField.investigations];
      cyclePeriod.date = maps[i][InvestigationsField.date];
      cyclePeriod.time = maps[i][InvestigationsField.time];
      cyclePeriod.alarmTime = maps[i][InvestigationsField.alarmTime];
      cyclePeriod.text = maps[i][InvestigationsField.text];
      cyclePeriod.id = maps[i][InvestigationsField.id];
      cyclePeriod.cycleNumber = maps[i][InvestigationsField.cycleNumber];
      cyclePeriod.isChecked = maps[i][InvestigationsField.isChecked];
      cyclePeriod.notificationId = maps[i][InvestigationsField.notificationId];

      return cyclePeriod;
    });
  }

  Future<int> addTreatment(Treatments treatmentsData) async {
    final db = await instance.database;
    final id = await db.insert(treatments, treatmentsData.toMap());
    return id;
  }

  Future<int> addTreatmentWithString(
      Map<String, dynamic> treatmentsData) async {
    final db = await instance.database;
    final id = await db.insert(treatments, treatmentsData);
    return id;
  }

  Future<void> updateTreatment(Treatments treatmentsData) async {
    final db = await database;

    await db.update(
      treatments,
      treatmentsData.toMap(),
      where: 'id = ?',
      whereArgs: [treatmentsData.id],
    );
  }

  Future<List<Treatments>> getTreatment(int cycleNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      treatments,
      where: TreatmentsField.cycleNumber + ' = ?',
      whereArgs: [cycleNumber],
    );
    return List.generate(maps.length, (i) {
      Treatments treatments = new Treatments();

      treatments.date = maps[i][TreatmentsField.date];
      treatments.time = maps[i][TreatmentsField.time];
      treatments.alarmTime = maps[i][TreatmentsField.alarmTime];
      treatments.text = maps[i][TreatmentsField.text];
      treatments.isChecked = maps[i][TreatmentsField.isChecked];
      treatments.treatment = maps[i][TreatmentsField.treatment];
      treatments.id = maps[i][TreatmentsField.id];
      treatments.cycleNumber = maps[i][TreatmentsField.cycleNumber];
      treatments.notificationId = maps[i][TreatmentsField.notificationId];

      return treatments;
    });
  }

  Future<List<Treatments>> getAllTreatment() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      treatments,
    );
    return List.generate(maps.length, (i) {
      Treatments treatments = new Treatments();

      treatments.date = maps[i][TreatmentsField.date];
      treatments.alarmTime = maps[i][TreatmentsField.alarmTime];
      treatments.text = maps[i][TreatmentsField.text];
      treatments.isChecked = maps[i][TreatmentsField.isChecked];
      treatments.treatment = maps[i][TreatmentsField.treatment];
      treatments.id = maps[i][TreatmentsField.id];
      treatments.cycleNumber = maps[i][TreatmentsField.cycleNumber];
      treatments.notificationId = maps[i][TreatmentsField.notificationId];

      return treatments;
    });
  }

  Future<List<Treatments>> getAllTreatmentWithDate(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      treatments,
      where: TreatmentsField.date + ' = ?',
      whereArgs: [date],
    );
    return List.generate(maps.length, (i) {
      Treatments treatments = new Treatments();

      treatments.date = maps[i][TreatmentsField.date];
      treatments.time = maps[i][TreatmentsField.time];
      treatments.alarmTime = maps[i][TreatmentsField.alarmTime];
      treatments.text = maps[i][TreatmentsField.text];
      treatments.isChecked = maps[i][TreatmentsField.isChecked];
      treatments.treatment = maps[i][TreatmentsField.treatment];
      treatments.id = maps[i][TreatmentsField.id];
      treatments.cycleNumber = maps[i][TreatmentsField.cycleNumber];
      treatments.notificationId = maps[i][TreatmentsField.notificationId];

      return treatments;
    });
  }

  Future<void> deleteDiary(int id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      diary,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> addDiary(Diary diaryData) async {
    final db = await instance.database;
    final id = await db.insert(diary, diaryData.toJson());
    return id;
  }

  Future<void> updateDiary(Diary diaryData) async {
    final db = await database;

    await db.update(
      diary,
      diaryData.toMap(),
      where: 'id = ?',
      whereArgs: [diaryData.id],
    );
  }

  Future<List<Diary>> getDiary() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(diary);
    return List.generate(maps.length, (i) {
      Diary diary = new Diary();

      diary.id = maps[i][DiaryField.id];
      diary.date = maps[i][DiaryField.date];
      diary.text = maps[i][DiaryField.text];
      diary.image = maps[i][DiaryField.image];

      return diary;
    });
  }

  Future<void> deleteInvestigations(int id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      investigation,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteMedikament(int id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      medikamente,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteTreatments(int id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      treatments,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> addMedikaments(MedikamenteData medikamenteData) async {
    final db = await instance.database;
    final id = await db.insert(medikamente, medikamenteData.toMap());
    return id;
  }

  Future<int> addMedikamentsWithString(
      Map<String, dynamic> medikamenteData) async {
    final db = await instance.database;
    final id = await db.insert(medikamente, medikamenteData);
    return id;
  }

  Future<void> updateMedikamente(MedikamenteData medikamenteData) async {
    final db = await database;

    await db.update(
      medikamente,
      medikamenteData.toMap(),
      where: 'id = ?',
      whereArgs: [medikamenteData.id],
    );
  }

  Future<List<MedikamenteData>> getMedikaments(int cycleNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      medikamente,
      where: MedikamenteDataField.cycleNumber + ' = ?',
      whereArgs: [cycleNumber],
    );

    return List.generate(maps.length, (i) {
      MedikamenteData data = new MedikamenteData();

      data.id = maps[i][CyclePeriodField.id];
      data.drugController = maps[i][MedikamenteDataField.drugController];
      data.dosageController = maps[i][MedikamenteDataField.dosageController];
      data.typeOfExpenditureText =
          maps[i][MedikamenteDataField.typeOfExpenditureText];
      data.typeOfExpenditureImage =
          maps[i][MedikamenteDataField.typeOfExpenditureImage];
      data.startDate = maps[i][MedikamenteDataField.startDate];
      data.endDate = maps[i][MedikamenteDataField.endDate];
      data.time = maps[i][MedikamenteDataField.time];
      data.alarmTime = maps[i][MedikamenteDataField.alarmTime];
      data.otherTime = maps[i][MedikamenteDataField.otherTime];
      data.cycleNumber = maps[i][MedikamenteDataField.cycleNumber];
      data.notificationId = maps[i][MedikamenteDataField.notificationId];
      data.isChecked = maps[i][MedikamenteDataField.isChecked];

      return data;
    });
  }

  Future<List<MedikamenteData>> getAllMedikaments() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(medikamente);

    return List.generate(maps.length, (i) {
      MedikamenteData data = new MedikamenteData();

      data.id = maps[i][CyclePeriodField.id];
      data.drugController = maps[i][MedikamenteDataField.drugController];
      data.dosageController = maps[i][MedikamenteDataField.dosageController];
      data.typeOfExpenditureText =
          maps[i][MedikamenteDataField.typeOfExpenditureText];
      data.typeOfExpenditureImage =
          maps[i][MedikamenteDataField.typeOfExpenditureImage];
      data.startDate = maps[i][MedikamenteDataField.startDate];
      data.endDate = maps[i][MedikamenteDataField.endDate];
      data.time = maps[i][MedikamenteDataField.time];
      data.alarmTime = maps[i][MedikamenteDataField.alarmTime];
      data.otherTime = maps[i][MedikamenteDataField.otherTime];
      data.cycleNumber = maps[i][MedikamenteDataField.cycleNumber];
      data.notificationId = maps[i][MedikamenteDataField.notificationId];
      data.isChecked = maps[i][MedikamenteDataField.isChecked];

      return data;
    });
  }

  Future<int> addCyclePeriod(CyclePeriodData cyclePeriodData) async {
    final db = await instance.database;
    final id = await db.insert(cyclePeriod, cyclePeriodData.toMap());
    return id;
  }

  Future<int> addCyclePeriodWithString(
      Map<String, dynamic> cyclePeriodData) async {
    final db = await instance.database;
    final id = await db.insert(
      cyclePeriod,
      cyclePeriodData,
    );
    return id;
  }

  Future<List<CyclePeriodData>> getCyclePeriod() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(cyclePeriod);
    return List.generate(maps.length, (i) {
      CyclePeriodData data = new CyclePeriodData();
      data.id = maps[i][CyclePeriodField.id];
      data.startDate = maps[i][CyclePeriodField.startDate];
      data.endDate = maps[i][CyclePeriodField.endDate];
      data.cycleNumber = maps[i][CyclePeriodField.cycleNumber];
      data.typeOfTreatment = maps[i][CyclePeriodField.typeOfTreatment];

      return data;
    });
  }

  Future<List<CyclePeriodData>> getSingleCyclePeriod(int cycleNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      cyclePeriod,
      where: CyclePeriodField.cycleNumber + ' = ?',
      whereArgs: [cycleNumber],
    );
    return List.generate(maps.length, (i) {
      CyclePeriodData data = new CyclePeriodData();
      data.id = maps[i][CyclePeriodField.id];
      data.startDate = maps[i][CyclePeriodField.startDate];
      data.endDate = maps[i][CyclePeriodField.endDate];
      data.cycleNumber = maps[i][CyclePeriodField.cycleNumber];
      data.typeOfTreatment = maps[i][CyclePeriodField.typeOfTreatment];

      return data;
    });
  }

  Future<void> deleteCyclePeriod(int cycleNumber) async {
    final db = await database;
    await db.delete(
      cyclePeriod,
      where: CyclePeriodField.cycleNumber + ' = ?',
      whereArgs: [cycleNumber],
    );
  }

  Future<void> deleteInvestigation(int cycleNumber) async {
    final db = await database;
    await db.delete(
      investigation,
      where: InvestigationsField.cycleNumber + ' = ?',
      whereArgs: [cycleNumber],
    );
  }

  Future<void> deleteTreatment(int cycleNumber) async {
    final db = await database;
    await db.delete(
      treatments,
      where: TreatmentsField.cycleNumber + ' = ?',
      whereArgs: [cycleNumber],
    );
  }

  Future<void> deleteMedikaments(int cycleNumber) async {
    final db = await database;
    await db.delete(
      medikamente,
      where: MedikamenteDataField.cycleNumber + ' = ?',
      whereArgs: [cycleNumber],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
