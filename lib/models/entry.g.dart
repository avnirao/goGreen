// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEntryCollection on Isar {
  IsarCollection<Entry> get entrys => this.collection();
}

const EntrySchema = CollectionSchema(
  name: r'Entry',
  id: 744406108402872943,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.byte,
      enumMap: _EntrycategoryEnumValueMap,
    ),
    r'co2': PropertySchema(
      id: 2,
      name: r'co2',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'distanceUnit': PropertySchema(
      id: 4,
      name: r'distanceUnit',
      type: IsarType.byte,
      enumMap: _EntrydistanceUnitEnumValueMap,
    ),
    r'emissionsDate': PropertySchema(
      id: 5,
      name: r'emissionsDate',
      type: IsarType.dateTime,
    ),
    r'energyAmount': PropertySchema(
      id: 6,
      name: r'energyAmount',
      type: IsarType.byte,
      enumMap: _EntryenergyAmountEnumValueMap,
    ),
    r'moneyUnit': PropertySchema(
      id: 7,
      name: r'moneyUnit',
      type: IsarType.byte,
      enumMap: _EntrymoneyUnitEnumValueMap,
    ),
    r'notes': PropertySchema(
      id: 8,
      name: r'notes',
      type: IsarType.string,
    ),
    r'passengerAmount': PropertySchema(
      id: 9,
      name: r'passengerAmount',
      type: IsarType.byte,
      enumMap: _EntrypassengerAmountEnumValueMap,
    ),
    r'passengers': PropertySchema(
      id: 10,
      name: r'passengers',
      type: IsarType.long,
    ),
    r'size': PropertySchema(
      id: 11,
      name: r'size',
      type: IsarType.byte,
      enumMap: _EntrysizeEnumValueMap,
    ),
    r'subtype': PropertySchema(
      id: 12,
      name: r'subtype',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 13,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'weightUnit': PropertySchema(
      id: 14,
      name: r'weightUnit',
      type: IsarType.byte,
      enumMap: _EntryweightUnitEnumValueMap,
    )
  },
  estimateSize: _entryEstimateSize,
  serialize: _entrySerialize,
  deserialize: _entryDeserialize,
  deserializeProp: _entryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _entryGetId,
  getLinks: _entryGetLinks,
  attach: _entryAttach,
  version: '3.1.0+1',
);

int _entryEstimateSize(
  Entry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.subtype.length * 3;
  return bytesCount;
}

void _entrySerialize(
  Entry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeByte(offsets[1], object.category.index);
  writer.writeDouble(offsets[2], object.co2);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeByte(offsets[4], object.distanceUnit.index);
  writer.writeDateTime(offsets[5], object.emissionsDate);
  writer.writeByte(offsets[6], object.energyAmount.index);
  writer.writeByte(offsets[7], object.moneyUnit.index);
  writer.writeString(offsets[8], object.notes);
  writer.writeByte(offsets[9], object.passengerAmount.index);
  writer.writeLong(offsets[10], object.passengers);
  writer.writeByte(offsets[11], object.size.index);
  writer.writeString(offsets[12], object.subtype);
  writer.writeDateTime(offsets[13], object.updatedAt);
  writer.writeByte(offsets[14], object.weightUnit.index);
}

Entry _entryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Entry(
    amount: reader.readDoubleOrNull(offsets[0]),
    category: _EntrycategoryValueEnumMap[reader.readByteOrNull(offsets[1])] ??
        EmissionCategory.clothing,
    co2: reader.readDoubleOrNull(offsets[2]) ?? 0,
    createdAt: reader.readDateTime(offsets[3]),
    distanceUnit:
        _EntrydistanceUnitValueEnumMap[reader.readByteOrNull(offsets[4])] ??
            DistanceUnit.km,
    emissionsDate: reader.readDateTime(offsets[5]),
    energyAmount:
        _EntryenergyAmountValueEnumMap[reader.readByteOrNull(offsets[6])] ??
            EnergyAmount.average,
    id: id,
    moneyUnit: _EntrymoneyUnitValueEnumMap[reader.readByteOrNull(offsets[7])] ??
        MoneyUnit.usd,
    notes: reader.readString(offsets[8]),
    passengerAmount:
        _EntrypassengerAmountValueEnumMap[reader.readByteOrNull(offsets[9])] ??
            PassengerAmount.average,
    passengers: reader.readLongOrNull(offsets[10]),
    size: _EntrysizeValueEnumMap[reader.readByteOrNull(offsets[11])] ??
        VehicleSize.medium,
    subtype: reader.readString(offsets[12]),
    updatedAt: reader.readDateTime(offsets[13]),
    weightUnit:
        _EntryweightUnitValueEnumMap[reader.readByteOrNull(offsets[14])] ??
            WeightUnit.kg,
  );
  return object;
}

P _entryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (_EntrycategoryValueEnumMap[reader.readByteOrNull(offset)] ??
          EmissionCategory.clothing) as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (_EntrydistanceUnitValueEnumMap[reader.readByteOrNull(offset)] ??
          DistanceUnit.km) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (_EntryenergyAmountValueEnumMap[reader.readByteOrNull(offset)] ??
          EnergyAmount.average) as P;
    case 7:
      return (_EntrymoneyUnitValueEnumMap[reader.readByteOrNull(offset)] ??
          MoneyUnit.usd) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (_EntrypassengerAmountValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PassengerAmount.average) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (_EntrysizeValueEnumMap[reader.readByteOrNull(offset)] ??
          VehicleSize.medium) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    case 14:
      return (_EntryweightUnitValueEnumMap[reader.readByteOrNull(offset)] ??
          WeightUnit.kg) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _EntrycategoryEnumValueMap = {
  'clothing': 0,
  'energy': 1,
  'food': 2,
  'furniture': 3,
  'personalCareAndAccessories': 4,
  'travel': 5,
  'foodWaste': 6,
  'generalWaste': 7,
  'electricalWaste': 8,
};
const _EntrycategoryValueEnumMap = {
  0: EmissionCategory.clothing,
  1: EmissionCategory.energy,
  2: EmissionCategory.food,
  3: EmissionCategory.furniture,
  4: EmissionCategory.personalCareAndAccessories,
  5: EmissionCategory.travel,
  6: EmissionCategory.foodWaste,
  7: EmissionCategory.generalWaste,
  8: EmissionCategory.electricalWaste,
};
const _EntrydistanceUnitEnumValueMap = {
  'm': 0,
  'km': 1,
  'ft': 2,
  'mi': 3,
  'nmi': 4,
};
const _EntrydistanceUnitValueEnumMap = {
  0: DistanceUnit.m,
  1: DistanceUnit.km,
  2: DistanceUnit.ft,
  3: DistanceUnit.mi,
  4: DistanceUnit.nmi,
};
const _EntryenergyAmountEnumValueMap = {
  'wellBelowAverage': 0,
  'belowAverage': 1,
  'average': 2,
  'aboveAverage': 3,
  'wellAboveAverage': 4,
};
const _EntryenergyAmountValueEnumMap = {
  0: EnergyAmount.wellBelowAverage,
  1: EnergyAmount.belowAverage,
  2: EnergyAmount.average,
  3: EnergyAmount.aboveAverage,
  4: EnergyAmount.wellAboveAverage,
};
const _EntrymoneyUnitEnumValueMap = {
  'usd': 0,
  'cad': 1,
  'eur': 2,
  'gbd': 3,
  'nok': 4,
  'gtq': 5,
  'mxn': 6,
};
const _EntrymoneyUnitValueEnumMap = {
  0: MoneyUnit.usd,
  1: MoneyUnit.cad,
  2: MoneyUnit.eur,
  3: MoneyUnit.gbd,
  4: MoneyUnit.nok,
  5: MoneyUnit.gtq,
  6: MoneyUnit.mxn,
};
const _EntrypassengerAmountEnumValueMap = {
  'empty': 0,
  'almostEmpty': 1,
  'average': 2,
  'almostFull': 3,
  'full': 4,
  'overloaded': 5,
};
const _EntrypassengerAmountValueEnumMap = {
  0: PassengerAmount.empty,
  1: PassengerAmount.almostEmpty,
  2: PassengerAmount.average,
  3: PassengerAmount.almostFull,
  4: PassengerAmount.full,
  5: PassengerAmount.overloaded,
};
const _EntrysizeEnumValueMap = {
  'personal': 0,
  'small': 1,
  'medium': 2,
  'large': 3,
};
const _EntrysizeValueEnumMap = {
  0: VehicleSize.personal,
  1: VehicleSize.small,
  2: VehicleSize.medium,
  3: VehicleSize.large,
};
const _EntryweightUnitEnumValueMap = {
  'g': 0,
  'kg': 1,
  'lb': 2,
  't': 3,
  'ton': 4,
};
const _EntryweightUnitValueEnumMap = {
  0: WeightUnit.g,
  1: WeightUnit.kg,
  2: WeightUnit.lb,
  3: WeightUnit.t,
  4: WeightUnit.ton,
};

Id _entryGetId(Entry object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _entryGetLinks(Entry object) {
  return [];
}

void _entryAttach(IsarCollection<dynamic> col, Id id, Entry object) {
  object.id = id;
}

extension EntryQueryWhereSort on QueryBuilder<Entry, Entry, QWhere> {
  QueryBuilder<Entry, Entry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EntryQueryWhere on QueryBuilder<Entry, Entry, QWhereClause> {
  QueryBuilder<Entry, Entry, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Entry, Entry, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Entry, Entry, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Entry, Entry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EntryQueryFilter on QueryBuilder<Entry, Entry, QFilterCondition> {
  QueryBuilder<Entry, Entry, QAfterFilterCondition> amountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> amountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> amountEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> amountGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> amountLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> amountBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> categoryEqualTo(
      EmissionCategory value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> categoryGreaterThan(
    EmissionCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> categoryLessThan(
    EmissionCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> categoryBetween(
    EmissionCategory lower,
    EmissionCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> co2EqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'co2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> co2GreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'co2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> co2LessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'co2',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> co2Between(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'co2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> distanceUnitEqualTo(
      DistanceUnit value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanceUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> distanceUnitGreaterThan(
    DistanceUnit value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanceUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> distanceUnitLessThan(
    DistanceUnit value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanceUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> distanceUnitBetween(
    DistanceUnit lower,
    DistanceUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanceUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> emissionsDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emissionsDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> emissionsDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emissionsDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> emissionsDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emissionsDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> emissionsDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emissionsDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> energyAmountEqualTo(
      EnergyAmount value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'energyAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> energyAmountGreaterThan(
    EnergyAmount value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'energyAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> energyAmountLessThan(
    EnergyAmount value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'energyAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> energyAmountBetween(
    EnergyAmount lower,
    EnergyAmount upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'energyAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> moneyUnitEqualTo(
      MoneyUnit value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'moneyUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> moneyUnitGreaterThan(
    MoneyUnit value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'moneyUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> moneyUnitLessThan(
    MoneyUnit value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'moneyUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> moneyUnitBetween(
    MoneyUnit lower,
    MoneyUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'moneyUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengerAmountEqualTo(
      PassengerAmount value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passengerAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengerAmountGreaterThan(
    PassengerAmount value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'passengerAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengerAmountLessThan(
    PassengerAmount value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'passengerAmount',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengerAmountBetween(
    PassengerAmount lower,
    PassengerAmount upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'passengerAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengersIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'passengers',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengersIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'passengers',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengersEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passengers',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengersGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'passengers',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengersLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'passengers',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> passengersBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'passengers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> sizeEqualTo(
      VehicleSize value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> sizeGreaterThan(
    VehicleSize value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> sizeLessThan(
    VehicleSize value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> sizeBetween(
    VehicleSize lower,
    VehicleSize upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subtype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subtype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subtype',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subtype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subtype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subtype',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subtype',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subtype',
        value: '',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> subtypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subtype',
        value: '',
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> weightUnitEqualTo(
      WeightUnit value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> weightUnitGreaterThan(
    WeightUnit value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> weightUnitLessThan(
    WeightUnit value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightUnit',
        value: value,
      ));
    });
  }

  QueryBuilder<Entry, Entry, QAfterFilterCondition> weightUnitBetween(
    WeightUnit lower,
    WeightUnit upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EntryQueryObject on QueryBuilder<Entry, Entry, QFilterCondition> {}

extension EntryQueryLinks on QueryBuilder<Entry, Entry, QFilterCondition> {}

extension EntryQuerySortBy on QueryBuilder<Entry, Entry, QSortBy> {
  QueryBuilder<Entry, Entry, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByCo2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'co2', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByCo2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'co2', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByDistanceUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceUnit', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByDistanceUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceUnit', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByEmissionsDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emissionsDate', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByEmissionsDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emissionsDate', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByEnergyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyAmount', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByEnergyAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyAmount', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByMoneyUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneyUnit', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByMoneyUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneyUnit', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByPassengerAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengerAmount', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByPassengerAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengerAmount', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByPassengers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengers', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByPassengersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengers', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortBySubtype() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtype', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortBySubtypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtype', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByWeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> sortByWeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.desc);
    });
  }
}

extension EntryQuerySortThenBy on QueryBuilder<Entry, Entry, QSortThenBy> {
  QueryBuilder<Entry, Entry, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByCo2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'co2', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByCo2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'co2', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByDistanceUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceUnit', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByDistanceUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceUnit', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByEmissionsDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emissionsDate', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByEmissionsDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emissionsDate', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByEnergyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyAmount', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByEnergyAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'energyAmount', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByMoneyUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneyUnit', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByMoneyUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'moneyUnit', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByPassengerAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengerAmount', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByPassengerAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengerAmount', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByPassengers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengers', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByPassengersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passengers', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenBySizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'size', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenBySubtype() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtype', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenBySubtypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subtype', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByWeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.asc);
    });
  }

  QueryBuilder<Entry, Entry, QAfterSortBy> thenByWeightUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightUnit', Sort.desc);
    });
  }
}

extension EntryQueryWhereDistinct on QueryBuilder<Entry, Entry, QDistinct> {
  QueryBuilder<Entry, Entry, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByCo2() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'co2');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByDistanceUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceUnit');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByEmissionsDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emissionsDate');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByEnergyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'energyAmount');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByMoneyUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'moneyUnit');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByPassengerAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'passengerAmount');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByPassengers() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'passengers');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctBySize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'size');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctBySubtype(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subtype', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<Entry, Entry, QDistinct> distinctByWeightUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightUnit');
    });
  }
}

extension EntryQueryProperty on QueryBuilder<Entry, Entry, QQueryProperty> {
  QueryBuilder<Entry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Entry, double?, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<Entry, EmissionCategory, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<Entry, double, QQueryOperations> co2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'co2');
    });
  }

  QueryBuilder<Entry, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Entry, DistanceUnit, QQueryOperations> distanceUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceUnit');
    });
  }

  QueryBuilder<Entry, DateTime, QQueryOperations> emissionsDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emissionsDate');
    });
  }

  QueryBuilder<Entry, EnergyAmount, QQueryOperations> energyAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'energyAmount');
    });
  }

  QueryBuilder<Entry, MoneyUnit, QQueryOperations> moneyUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'moneyUnit');
    });
  }

  QueryBuilder<Entry, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Entry, PassengerAmount, QQueryOperations>
      passengerAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'passengerAmount');
    });
  }

  QueryBuilder<Entry, int?, QQueryOperations> passengersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'passengers');
    });
  }

  QueryBuilder<Entry, VehicleSize, QQueryOperations> sizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'size');
    });
  }

  QueryBuilder<Entry, String, QQueryOperations> subtypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subtype');
    });
  }

  QueryBuilder<Entry, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<Entry, WeightUnit, QQueryOperations> weightUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightUnit');
    });
  }
}
