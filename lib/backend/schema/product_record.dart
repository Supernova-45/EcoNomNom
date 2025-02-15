import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductRecord extends FirestoreRecord {
  ProductRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "specifications" field.
  String? _specifications;
  String get specifications => _specifications ?? '';
  bool hasSpecifications() => _specifications != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "modified_at" field.
  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _modifiedAt;
  bool hasModifiedAt() => _modifiedAt != null;

  // "on_sale" field.
  bool? _onSale;
  bool get onSale => _onSale ?? false;
  bool hasOnSale() => _onSale != null;

  // "sale_price" field.
  double? _salePrice;
  double get salePrice => _salePrice ?? 0.0;
  bool hasSalePrice() => _salePrice != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "sustainability_score" field.
  double? _sustainabilityScore;
  double get sustainabilityScore => _sustainabilityScore ?? 0.0;
  bool hasSustainabilityScore() => _sustainabilityScore != null;

  // "carbon_footprint" field.
  double? _carbonFootprint;
  double get carbonFootprint => _carbonFootprint ?? 0.0;
  bool hasCarbonFootprint() => _carbonFootprint != null;

  // "green_score" field.
  String? _greenScore;
  String get greenScore => _greenScore ?? '';
  bool hasGreenScore() => _greenScore != null;

  // "green_score_rating" field.
  String? _greenScoreRating;
  String get greenScoreRating => _greenScoreRating ?? '';
  bool hasGreenScoreRating() => _greenScoreRating != null;

  // "contains_palm_oil" field.
  bool? _containsPalmOil;
  bool get containsPalmOil => _containsPalmOil ?? false;
  bool hasContainsPalmOil() => _containsPalmOil != null;

  // "country_of_origin" field.
  String? _countryOfOrigin;
  String get countryOfOrigin => _countryOfOrigin ?? '';
  bool hasCountryOfOrigin() => _countryOfOrigin != null;

  // "threatens_species" field.
  bool? _threatensSpecies;
  bool get threatensSpecies => _threatensSpecies ?? false;
  bool hasThreatensSpecies() => _threatensSpecies != null;

  // "packaging_impact" field.
  String? _packagingImpact;
  String get packagingImpact => _packagingImpact ?? '';
  bool hasPackagingImpact() => _packagingImpact != null;

  // "carbon_footprint_to_car" field.
  double? _carbonFootprintToCar;
  double get carbonFootprintToCar => _carbonFootprintToCar ?? 0.0;
  bool hasCarbonFootprintToCar() => _carbonFootprintToCar != null;

  // "responsibly_sourced" field.
  bool? _responsiblySourced;
  bool get responsiblySourced => _responsiblySourced ?? false;
  bool hasResponsiblySourced() => _responsiblySourced != null;

  // "animal_welfare_good" field.
  bool? _animalWelfareGood;
  bool get animalWelfareGood => _animalWelfareGood ?? false;
  bool hasAnimalWelfareGood() => _animalWelfareGood != null;

  // "no_chemicals" field.
  bool? _noChemicals;
  bool get noChemicals => _noChemicals ?? false;
  bool hasNoChemicals() => _noChemicals != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _specifications = snapshotData['specifications'] as String?;
    _price = castToType<double>(snapshotData['price']);
    _createdAt = snapshotData['created_at'] as DateTime?;
    _modifiedAt = snapshotData['modified_at'] as DateTime?;
    _onSale = snapshotData['on_sale'] as bool?;
    _salePrice = castToType<double>(snapshotData['sale_price']);
    _image = snapshotData['image'] as String?;
    _sustainabilityScore =
        castToType<double>(snapshotData['sustainability_score']);
    _carbonFootprint = castToType<double>(snapshotData['carbon_footprint']);
    _greenScore = snapshotData['green_score'] as String?;
    _greenScoreRating = snapshotData['green_score_rating'] as String?;
    _containsPalmOil = snapshotData['contains_palm_oil'] as bool?;
    _countryOfOrigin = snapshotData['country_of_origin'] as String?;
    _threatensSpecies = snapshotData['threatens_species'] as bool?;
    _packagingImpact = snapshotData['packaging_impact'] as String?;
    _carbonFootprintToCar =
        castToType<double>(snapshotData['carbon_footprint_to_car']);
    _responsiblySourced = snapshotData['responsibly_sourced'] as bool?;
    _animalWelfareGood = snapshotData['animal_welfare_good'] as bool?;
    _noChemicals = snapshotData['no_chemicals'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('product');

  static Stream<ProductRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProductRecord.fromSnapshot(s));

  static Future<ProductRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProductRecord.fromSnapshot(s));

  static ProductRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProductRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProductRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProductRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProductRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProductRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProductRecordData({
  String? name,
  String? description,
  String? specifications,
  double? price,
  DateTime? createdAt,
  DateTime? modifiedAt,
  bool? onSale,
  double? salePrice,
  String? image,
  double? sustainabilityScore,
  double? carbonFootprint,
  String? greenScore,
  String? greenScoreRating,
  bool? containsPalmOil,
  String? countryOfOrigin,
  bool? threatensSpecies,
  String? packagingImpact,
  double? carbonFootprintToCar,
  bool? responsiblySourced,
  bool? animalWelfareGood,
  bool? noChemicals,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'description': description,
      'specifications': specifications,
      'price': price,
      'created_at': createdAt,
      'modified_at': modifiedAt,
      'on_sale': onSale,
      'sale_price': salePrice,
      'image': image,
      'sustainability_score': sustainabilityScore,
      'carbon_footprint': carbonFootprint,
      'green_score': greenScore,
      'green_score_rating': greenScoreRating,
      'contains_palm_oil': containsPalmOil,
      'country_of_origin': countryOfOrigin,
      'threatens_species': threatensSpecies,
      'packaging_impact': packagingImpact,
      'carbon_footprint_to_car': carbonFootprintToCar,
      'responsibly_sourced': responsiblySourced,
      'animal_welfare_good': animalWelfareGood,
      'no_chemicals': noChemicals,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProductRecordDocumentEquality implements Equality<ProductRecord> {
  const ProductRecordDocumentEquality();

  @override
  bool equals(ProductRecord? e1, ProductRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.specifications == e2?.specifications &&
        e1?.price == e2?.price &&
        e1?.createdAt == e2?.createdAt &&
        e1?.modifiedAt == e2?.modifiedAt &&
        e1?.onSale == e2?.onSale &&
        e1?.salePrice == e2?.salePrice &&
        e1?.image == e2?.image &&
        e1?.sustainabilityScore == e2?.sustainabilityScore &&
        e1?.carbonFootprint == e2?.carbonFootprint &&
        e1?.greenScore == e2?.greenScore &&
        e1?.greenScoreRating == e2?.greenScoreRating &&
        e1?.containsPalmOil == e2?.containsPalmOil &&
        e1?.countryOfOrigin == e2?.countryOfOrigin &&
        e1?.threatensSpecies == e2?.threatensSpecies &&
        e1?.packagingImpact == e2?.packagingImpact &&
        e1?.carbonFootprintToCar == e2?.carbonFootprintToCar &&
        e1?.responsiblySourced == e2?.responsiblySourced &&
        e1?.animalWelfareGood == e2?.animalWelfareGood &&
        e1?.noChemicals == e2?.noChemicals;
  }

  @override
  int hash(ProductRecord? e) => const ListEquality().hash([
        e?.name,
        e?.description,
        e?.specifications,
        e?.price,
        e?.createdAt,
        e?.modifiedAt,
        e?.onSale,
        e?.salePrice,
        e?.image,
        e?.sustainabilityScore,
        e?.carbonFootprint,
        e?.greenScore,
        e?.greenScoreRating,
        e?.containsPalmOil,
        e?.countryOfOrigin,
        e?.threatensSpecies,
        e?.packagingImpact,
        e?.carbonFootprintToCar,
        e?.responsiblySourced,
        e?.animalWelfareGood,
        e?.noChemicals
      ]);

  @override
  bool isValidKey(Object? o) => o is ProductRecord;
}
