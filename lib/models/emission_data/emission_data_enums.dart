// Enums used by multiple Emission Factors

/// Represents each of the categories of emissions
enum EmissionCategory{
  clothing, energy, food, furniture, personalCareAndAccessories, travel, 
  foodWaste, generalWaste, electricalWaste;

  /// Returns the value of this enum as a String.
  @override
  String toString() {
    String result = super.toString();
    if (result.isEmpty) return result;

    // get rid of the enum type at the beginning of the string
    final int startIndex = result.indexOf('.') + 1;
    result = result.substring(startIndex);

    // Check for uppercase letters - that means that the name contains multiple words
    for (int i = 0; i < result.length; i++) {
      final String copy = result;
      if (copy[i] == copy[i].toUpperCase()) {
        // uppercase letter found, add space before it
        result = '${result.substring(0, i)} ${result.substring(i, result.length)}';
        // increment since a character was added to the string
        i++; 
      }
    }

    // Make the 1st letter uppercase
    return result[0].toUpperCase() + result.substring(1);
  }
}

// Full list of available currencies, if we want to add more: 
// https://www.climatiq.io/docs/api-reference/models/parameters#supported-currencies
/// Units to use for money.
///  - `usd`: United States Dollar
///  - `cad`: Canadian Dollar
///  - `eur`: European Euro
///  - `gbd`: British Pound
///  - `nok`: Norwegian Krone
///  - `gtq`: Guatemalan Quetzal
///  - `mxn`: Mexican Peso
enum MoneyUnit{usd, cad, eur, gbd, nok, gtq, mxn}

/// Units to use for weight.
///  - `g`: gram
///  - `kg`: kilogram
///  - `t`: metric ton
///  - `lb`: pound
///  - `ton`: US short ton
enum WeightUnit{g, kg, t, lb, ton}

/// Units to use for distance.
///  - `m`: meter
///  - `km`: kilometer
///  - `ft`: foot
///  - `mi`: mile
///  - `nmi`: nautical mile
enum DistanceUnit{m, km, ft, mi, nmi}
