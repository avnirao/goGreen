import 'package:go_green/models/emission_factors/emission_data_enums.dart';
import 'package:go_green/models/emission_factors/emission_factors.dart';

/// Reresents how full a vehicle is based on how many passengers there are.
/// 
/// Options: empty, almostEmpty, average, almostFull, full, overloaded
enum PassengerAmount{empty, almostEmpty, average, almostFull, full, overloaded}

/// Represents how large a vehicle is.
/// 
/// Options: personal, small, medium, large
enum VehicleSize{
  personal, // personal is intended to be used for air travel (e.g., a personal plane with 2 seats)
  small, medium, large
}

/// Represents types of travel.
/// TravelType should be the same as the name of the constructor it's used with.
enum TravelType{
  bus, lightRailTram, train, ferryOnFoot, ferryWithCar, // public transit
  gasCar, fullElectricCar, hybridCar, // cars
  domesticFlight, internationalFlight, // flights
} 

/// Represents the emissions from travel
class TravelEmissions extends EmissionFactor{
  /// The distance traveled
  final double distance;
  /// The units for the distance traveled
  final DistanceUnit distanceUnit;
  /// The number of passengers
  final int? passengers;
  /// The type of travel
  final TravelType travelType;
  
  
  /// API Reference: https://www.climatiq.io/data/activity/passenger_vehicle-vehicle_type_car-fuel_source_bio_petrol-distance_na-engine_size_medium
  /// Note: this is currently for medium sized cars only
  TravelEmissions.gasCar({
    required this.distance, 
    required this.distanceUnit,
    required this.passengers,
  }): travelType = TravelType.gasCar,
      super(category: EmissionCategory.travel,
          id: "passenger_vehicle-vehicle_type_car-fuel_source_bio_petrol-distance_na-engine_size_medium");

  /// API Reference: https://www.climatiq.io/data/activity/passenger_vehicle-vehicle_type_car-fuel_source_bev-distance_na-engine_size_na
  /// Note: this is currently for medium sized cars only
  TravelEmissions.fullElectricCar({
    required this.distance, 
    required this.distanceUnit,
    required this.passengers,
  }): travelType = TravelType.fullElectricCar,
      super(category: EmissionCategory.travel,
          id: "passenger_vehicle-vehicle_type_car-fuel_source_bev-distance_na-engine_size_na");

  /// API Referece: https://www.climatiq.io/data/activity/passenger_vehicle-vehicle_type_car-fuel_source_phev-engine_size_na-vehicle_age_na-vehicle_weight_na
  TravelEmissions.hybridCar({
    required this.distance, 
    required this.distanceUnit,
  }): passengers = null, // not required for this API call
      travelType = TravelType.hybridCar,
      super(category: EmissionCategory.travel,
          id: "passenger_vehicle-vehicle_type_coach-fuel_source_na-distance_na-engine_size_na");

  // API Reference: https://www.climatiq.io/data/activity/passenger_vehicle-vehicle_type_local_bus_not_london-fuel_source_na-distance_na-engine_size_na
  /// Creates an emission factor for bus travel.
  /// 
  /// Parameters:
  ///  - distance: the distance traveled
  ///  - distanceUnit: the units of measurement for distance
  TravelEmissions.bus({
    required this.distance, 
    required this.distanceUnit,
    required PassengerAmount passengerAmt, 
    }): passengers = switch (passengerAmt) {
          PassengerAmount.empty => 2,
          PassengerAmount.almostEmpty => 10,
          PassengerAmount.average => 32,
          PassengerAmount.almostFull => 50,
          PassengerAmount.full => 63,
          PassengerAmount.overloaded => 85,
        },
        travelType = TravelType.bus,
        super(category: EmissionCategory.travel,
          id: "passenger_vehicle-vehicle_type_local_bus_not_london-fuel_source_na-distance_na-engine_size_na");

  /// API Reference: 
  ///  - Domestic: https://www.climatiq.io/data/activity/passenger_flight-route_type_domestic-aircraft_type_na-distance_na-class_na-rf_included-distance_uplift_included
  ///  - International: https://www.climatiq.io/data/activity/passenger_flight-route_type_international-aircraft_type_na-distance_long_haul_gt_3700km-class_economy-rf_included-distance_uplift_included
  TravelEmissions.flight({
    required this.distance, 
    required this.distanceUnit,
    required VehicleSize size,
    required PassengerAmount passengerAmt,
    required bool isDomestic,
  }): passengers = switch(size) {
        // Assumes personal planes have ~4-8 people
        VehicleSize.personal => switch(passengerAmt) {
          PassengerAmount.empty => 2,
          PassengerAmount.almostEmpty => 4,
          PassengerAmount.average => 6,
          PassengerAmount.almostFull => 7,
          PassengerAmount.full => 8,
          PassengerAmount.overloaded => 10,
        },
        // According to regulations, small planes carry 19 people max
        VehicleSize.small => switch(passengerAmt) {
          PassengerAmount.empty => 4,
          PassengerAmount.almostEmpty => 8,
          PassengerAmount.average => 12,
          PassengerAmount.almostFull => 16,
          PassengerAmount.full => 19,
          PassengerAmount.overloaded => 20,
        },
        // Assumes meduim commercial planes can carry about 175 people
        VehicleSize.medium => switch(passengerAmt) {
          PassengerAmount.empty => 25,
          PassengerAmount.almostEmpty => 50,
          PassengerAmount.average => 100,
          PassengerAmount.almostFull => 125,
          PassengerAmount.full => 175,
          PassengerAmount.overloaded => 200,
        },
        // Assumes large commercial planes can carry about 500 people
        VehicleSize.large => switch(passengerAmt) {
          PassengerAmount.empty => 50,
          PassengerAmount.almostEmpty => 100,
          PassengerAmount.average => 250,
          PassengerAmount.almostFull => 375,
          PassengerAmount.full => 500,
          PassengerAmount.overloaded => 600,
        },
      }, 
      // Uses the 2nd ID if this is an international flight
      travelType = isDomestic ? TravelType.domesticFlight : TravelType.internationalFlight,
      super(category: EmissionCategory.travel,
            id: isDomestic ? "passenger_flight-route_type_domestic-aircraft_type_na-distance_na-class_na-rf_included-distance_uplift_included"
                           : "passenger_flight-route_type_international-aircraft_type_na-distance_long_haul_gt_3700km-class_economy-rf_included-distance_uplift_included");

  /// API Reference: https://www.climatiq.io/data/activity/passenger_train-route_type_light_rail_and_tram-fuel_source_na
  TravelEmissions.lightRailTram({
    required this.distance, 
    required this.distanceUnit,
    required PassengerAmount passengerAmt, 
    }): passengers = switch (passengerAmt) {
          // The Seattle Light Rail can hold 194 passengers.
          // Full set to lower than 194 since the user won't know how many people were on the other train cars
          PassengerAmount.empty => 30,
          PassengerAmount.almostEmpty => 50,
          PassengerAmount.average => 75,
          PassengerAmount.almostFull => 100,
          PassengerAmount.full => 160,
          PassengerAmount.overloaded => 194,
        },
        travelType = TravelType.lightRailTram,
        super(category: EmissionCategory.travel,
          id: "passenger_train-route_type_light_rail_and_tram-fuel_source_na");
  
  /// API Reference: https://www.climatiq.io/data/activity/passenger_train-route_type_national_rail-fuel_source_na
  TravelEmissions.train({
    required this.distance, 
    required this.distanceUnit,
    required PassengerAmount passengerAmt, 
    }): passengers = switch (passengerAmt) {
          // Assumes the average passenger train can carry about 1000 people
          PassengerAmount.empty => 50,
          PassengerAmount.almostEmpty => 150,
          PassengerAmount.average => 400,
          PassengerAmount.almostFull => 700,
          PassengerAmount.full => 900,
          PassengerAmount.overloaded => 1000,
        },
        travelType = TravelType.train,
        super(category: EmissionCategory.travel,
          id: "passenger_train-route_type_national_rail-fuel_source_na");
  
  /// API Reference: 
  ///  - Board with car: https://www.climatiq.io/data/activity/passenger_ferry-route_type_car_passenger-fuel_source_na
  ///  - Board on foot: https://www.climatiq.io/data/activity/passenger_ferry-route_type_car_passenger-fuel_source_na
  TravelEmissions.ferry({
    required this.distance, 
    required this.distanceUnit,
    required PassengerAmount passengerAmt, 
    required bool withCar,
    }): passengers = switch (passengerAmt) {
          // Assumes the average ferry can carry about 309 people
          // Source: https://data.bts.gov/stories/s/Ferry-Vessels/57sz-yj2t/#:~:text=Vessel%20capacity%2C%20age%2C%20and%20speed,and%20the%20maximum%20is%205%2C200.
          PassengerAmount.empty => 25,
          PassengerAmount.almostEmpty => 75,
          PassengerAmount.average => 150,
          PassengerAmount.almostFull => 220,
          PassengerAmount.full => 309,
          PassengerAmount.overloaded => 350,
        },
        travelType = withCar ? TravelType.ferryWithCar : TravelType.ferryOnFoot,
        super(category: EmissionCategory.travel,
          id: "passenger_ferry-route_type_${withCar ? "car" : "foot"}_passenger-fuel_source_na");
  
  @override 
  String toString() {
    String result = 'type: ${travelType.toString()},\n';
    result += '  id: ${super.toString()},\n';
    result += '  distance: $distance,\n';
    result += '  distance unit: ${distanceUnit.toString()},\n';
    result += '  passengers: $passengers';
    return result;
  }
}