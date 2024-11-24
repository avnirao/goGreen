// Average amount of electricity used by US household: 899 kWh per month, or ~29.966 kWh per day
// source: https://www.eia.gov/tools/faqs/faq.php?id=97&t=3 

import 'package:go_green/models/emission_factors/base_emission_factors/emission_factors.dart';
import 'package:go_green/models/emission_factors/emission_data_enums.dart';

enum EnergyAmount{wellBelowAverage, belowAverage, average, aboveAverage, wellAboveAverage}

enum EnergyType{electricity, naturalGas}

/// Represents emissions from energy usage
class EnergyEmissions extends EmissionFactor {
  /// the amount of energy consumption
  final double energy;
  /// the units for energy consumption
  final String energyUnit = 'kWh';
  /// the units for volume
  final String volumeUnit = 'standard_cubic_feet';
  /// the type of energy consumed
  final EnergyType energyType;

  /// Creates an Emission Factor for electricity.
  /// 
  /// Parameters:
  ///  - energy: an estimate of the amount of energy consumed
  EnergyEmissions.electricity ({
    required EnergyAmount energy,
  }): energy = switch (energy) {
        // Average amount of electricity used by US household: 899 kWh per month, or ~29.966 kWh per day (https://www.eia.gov/tools/faqs/faq.php?id=97&t=3)
        // Typical family uses between 15-40 kWh per day (https://www.anker.com/blogs/home-power-backup/electricity-usage-how-much-energy-does-an-average-house-use)
        EnergyAmount.wellBelowAverage => 15,
        EnergyAmount.belowAverage => 22,
        EnergyAmount.average => 29.966,
        EnergyAmount.aboveAverage => 35,
        EnergyAmount.wellAboveAverage => 40
      },
      energyType = EnergyType.electricity,
      super(
        category: EmissionCategory.energy,
        id: 'electricity-supply_grid-source_supplier_mix'
      );

  /// Creates an Emission Factor for natural gas.
  /// 
  /// Parameters:
  ///  - volume: an estimate of the amount of natural gas consumed
  EnergyEmissions.naturalGas ({
    required EnergyAmount volume,
  }): energy = switch (volume) {
        // Average amount of natural gas used by US household: 196 cubic ft per day (https://northeastsupplyenhancement.com/wp-content/uploads/2016/11/Natural-Gas-Facts.pdf)
        EnergyAmount.wellBelowAverage => 100,
        EnergyAmount.belowAverage => 150,
        EnergyAmount.average => 196,
        EnergyAmount.aboveAverage => 220,
        EnergyAmount.wellAboveAverage => 250
      },
      energyType = EnergyType.naturalGas,
      super(
        category: EmissionCategory.energy,
        id: 'electricity-supply_grid-source_supplier_mix'
      );

  @override 
  String toString() {
    String result = '  ${super.toString()},\n';
    result += '  energy consumption: $energy,\n';
    result += '  energy unit: $energyUnit';
    return result;
  }
}