// Enums used by multiple Emission Factors

/// Represents each of the categories of emissions
enum EmissionCategory{clothing, food, energy, householdItems, shopping, travel}

// Full list of available currencies, if we want to add more: 
// https://www.climatiq.io/docs/api-reference/models/parameters#supported-currencies
/// Units to use for money.
///  - usd: United States Dollar
///  - cad: Canadian Dollar
///  - eur: European Euro
///  - gbd: British Pound
///  - nok: Norwegian Krone
///  - gtq: Guatemalan Quetzal
///  - mxn: Mexican Peso
enum MoneyUnit{usd, cad, eur, gbd, nok, gtq, mxn}

/// Units to use for weight.
///  - g: gram
///  - kg: kilogram
///  - t: metric ton
///  - lb: pound
///  - ton: US short ton
enum WeightUnit{g, kg, t, lb, ton}

/// Units to use for distance.
///  - m: meter
///  - km: kilometer
///  - ft: foot
///  - mi: mile
///  - nmi: nautical mile
enum DistanceUnit{m, km, ft, mi, nmi}