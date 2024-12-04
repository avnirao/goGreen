/// Represents the available subtypes of emissions as maps.
/// Each map has keys that represent the display names of the emission factor, and values that are the IDs for the API.
class EmissionSubtypes {
  /// Available Energy Type options:
  ///  - Leather
  ///  - Footwear
  ///  - New Clothing
  ///  - Used Clothing
  ///  - Infant Clothing
  final Map<String, String> clothingTypes = {
    'Leather' : 'consumer_goods-type_leather_leather_products',
    'Footwear' : 'consumer_goods-type_footwear',
    'New Clothing' : 'consumer_goods-type_mens_womens_boys_and_girls_clothing',
    'Used Clothing' : 'consumer_goods-type_clothing_reused',
    'Infant Clothing' : 'consumer_goods-type_infant_clothing',
  };
  
  /// Available Electrical Waste Type options:
  ///  - Batteries: Recycled
  ///  - Batteries: Landfilled
  ///  - Monitors: Recycled
  ///  - Monitors: Landfilled
  ///  - Other Small Devices: Recycled
  ///  - Other Small Devices: Landfilled
  final Map<String, String> electricalWasteTypes = {
    'Batteries: Recycled' : 'waste-type_batteries-disposal_method_open_loop',
    'Batteries: Landfilled' : 'waste-type_batteries-disposal_method_landfill',
    'Monitors: Recycled' : 'waste-type_flat_panel_displays-disposal_method_recycled',
    'Monitors: Landfilled' : 'waste-type_flat_panel_displays-disposal_method_landfilled',
    'Other Small Devices: Recycled' : 'waste-type_electronic_peripherals-disposal_method_recycled',
    'Other Small Devices: Landfilled' : 'waste-type_electronic_peripherals-disposal_method_landfilled',
  };

  /// Available Energy Type options:
  ///  - Electricity
  ///  - Natural Gas
  final Map<String, String> energyTypes = {
    'Electricity' : 'electricity-supply_grid-source_supplier_mix',
    'Natural Gas' : 'fuel-type_natural_gas-fuel_use_residential_construction_commercial_institutional_agriculture'
  };

  /// Available Food Type options:
  ///  - Beef
  ///  - Pork
  ///  - Fish
  ///  - Other Food
  ///  - Beverages
  ///  - Dairy
  ///  - Sugar
  ///  - Tobacco
  final Map<String, String> foodTypes = {
    'Beef' : 'consumer_goods-type_meat_products_beef',
    'Pork' : 'consumer_goods-type_meat_products_pork',
    'Fish' : 'consumer_goods-type_fish_products',
    'Other Food' : 'consumer_goods-type_food_products_not_elsewhere_specified',
    'Beverages' : 'consumer_goods-type_beverages',
    'Dairy' : 'consumer_goods-type_dairy_products',
    'Sugar' : 'consumer_goods-type_sugar',
    'Tobacco' : 'consumer_goods-type_sugar',
  };
  
  /// Must specify whether this was 
  /// Available Food Waste options:
  ///  - Meat: Composted
  ///  - Meat: Landfilled
  ///  - Grain: Composted
  ///  - Grain: Landfilled
  ///  - Dairy: Composted
  ///  - Dairy: Landfilled
  ///  - Fruits and Vegetables: Composted
  ///  - Fruits and Vegetables: Landfilled
  ///  - Mixed Food: Composted
  ///  - Mixed Food: Landfilled
  ///  - Other Food Waste: Composted
  ///  - Other Food Waste: Landfilled
  final Map<String, String> foodWasteTypes = {
    'Meat: Composted' : 'waste-type_food_waste_meat_only-disposal_method_composted',
    'Meat: Landfilled' : 'waste-type_food_waste_meat_only-disposal_method_landfilled',
    'Grain: Composted' : 'waste-type_grains-disposal_method_composted',
    'Grain: Landfilled' : 'waste-type_grains-disposal_method_landfilled',
    'Dairy: Composted' : 'waste-type_dairy_products-disposal_method_composted',
    'Dairy: Landfilled' : 'waste-type_dairy_products-disposal_method_landfilled',
    'Fruits and Vegetables: Composted' : 'waste-type_fruits_and_vegetables-disposal_method_composted',
    'Fruits and Vegetables: Landfilled' : 'waste-type_fruits_and_vegetables-disposal_method_landfilled',
    'Mixed Food: Composted' : 'waste-type_mixed_organics-disposal_method_composted',
    'Mixed Food: Landfilled' : 'waste-type_mixed_organics-disposal_method_landfilled',
    'Other Food Waste: Composted' : 'waste-type_food_waste-disposal_method_composted',
    'Other Food Waste: Landfilled' : 'waste-type_food_waste-disposal_method_landfilled',
  };
  
  /// Available Furniture Type options:
  ///  - Blinds
  ///  - Matress
  ///  - Office Furniture
  ///  - Wood Cabinet
  ///  - Wood Countertop
  ///  - Carpet
  ///  - Other Furniture
  final Map<String, String> furnitureTypes = {
    'Blinds' : 'consumer_goods-type_blinds_shades_and_curtain_fixtures',
    'Matress' : 'consumer_goods-type_mattresses_and_foundations',
    'Office Furniture' : 'consumer_goods-type_office_furniture',
    'Wood Cabinet' : 'consumer_goods-type_wood_cabinets_and_counter_tops',
    'Wood Countertop' : 'consumer_goods-type_wood_cabinets_and_counter_tops',
    'Carpet' : 'consumer_goods-type_carpets_rugs',
    'Other Furniture' : 'consumer_goods-type_household_furniture',
  };
  
  /// Available General Waste Type options:
  ///  - Cardboard: Recycled
  ///  - Cardboard: Landfilled
  ///  - Paper: Recylced
  ///  - Paper: Landfilled
  ///  - Glass: Recycled
  ///  - Glass: Landfilled
  ///  - Books: Recycled
  ///  - Books: Landfilled
  ///  - Clothing: Recycled
  ///  - Clothing: Landfilled
  ///  - Plastic: Recycled
  ///  - Plastic: Landfilled
  ///  - Carpet
  ///  - Metal Cans: Recycled
  ///  - Metal Cans: Landfilled
  ///  - Mixed Waste: Recycled
  ///  - Mixed Waste: Landfilled
  final Map<String, String> generalWasteTypes = {
    'Cardboard: Recycled' : 'waste-type_cardboard-disposal_method_composting',
    'Cardboard: Landfilled' : 'waste-type_cardboard-disposal_method_landfill',
    'Paper: Recylced' : 'waste-type_mixed_paper_general-disposal_method_recycled',
    'Paper: Landfilled' : 'waste-type_mixed_paper_general-disposal_method_landfilled',
    'Glass: Recycled' : 'waste-type_glass-disposal_method_recycled',
    'Glass: Landfilled' : 'waste-type_glass-disposal_method_landfill',
    'Books: Recycled' : 'waste-type_books-disposal_method_closed_loop',
    'Books: Landfilled' : 'waste-type_books-disposal_method_landfill',
    'Clothing: Recycled' : 'waste-type_clothing-disposal_method_closed_loop',
    'Clothing: Landfilled' : 'waste-type_clothing-disposal_method_landfill',
    'Plastic: Recycled' : 'waste-type_mixed_plastics-disposal_method_recycled',
    'Plastic: Landfilled' : 'waste-type_mixed_plastics-disposal_method_landfilled',
    'Carpet' : 'waste-type_carpet-disposal_method_landfilled',
    'Metal Cans: Recycled' : 'waste-type_metal_mixed_cans-disposal_method_open_loop',
    'Metal Cans: Landfilled' : 'waste-type_metal_mixed_cans-disposal_method_landfill',
    'Mixed Waste: Recycled' : 'waste-type_mixed_msw-disposal_method_landfilled',
    'Mixed Waste: Landfilled' : 'waste-type_mixed_recyclables-disposal_method_recycled',
  };

  /// Available Personal Care Type options:
  ///  - Jewelery
  ///  - Perfume
  ///  - Toiletries
  ///  - Soap
  ///  - Toilet Paper
  ///  - Feminine Hygiene
  ///  - Disposable Diapers
  final Map<String, String> personalCareTypes = {
    'Jewelery' : 'consumer_goods-type_jewellery_and_silverware',
    'Perfume' : 'consumer_goods-type_perfumes_and_toiletries',
    'Toiletries' : 'consumer_goods-type_perfumes_and_toiletries',
    'Soap' : 'consumer_goods-type_soaps_and_cleaning_compounds',
    'Toilet Paper' : 'consumer_goods-type_sanitary_paper_products',
    'Feminine Hygiene' : 'consumer_goods-type_disposable_diapers_and_feminine_hygiene_products',
    'Disposable Diapers' : 'consumer_goods-type_disposable_diapers_and_feminine_hygiene_products',
  };

  /// Available Travel Type options:
  ///  - Bus
  ///  - Light Rail/Tram
  ///  - Train
  ///  - Ferry: On Foot
  ///  - Ferry: With a Car
  ///  - Gas Car
  ///  - Electric Car
  ///  - Hybrid Car
  ///  - Domestic Flight
  ///  - International Flight
  final Map<String, String> travelTypes = {
    'Bus' : 'passenger_vehicle-vehicle_type_local_bus_not_london-fuel_source_na-distance_na-engine_size_na',
    'Light Rail/Tram' : 'passenger_train-route_type_light_rail_and_tram-fuel_source_na',
    'Train' : 'passenger_train-route_type_national_rail-fuel_source_na',
    'Ferry: On Foot' : 'passenger_ferry-route_type_foot_passenger-fuel_source_na',
    'Ferry: With a Car' : 'passenger_ferry-route_type_car_passenger-fuel_source_na',
    'Gas Car' : 'passenger_vehicle-vehicle_type_car-fuel_source_bio_petrol-distance_na-engine_size_medium',
    'Electric Car' : 'passenger_vehicle-vehicle_type_car-fuel_source_bev-distance_na-engine_size_na',
    'Hybrid Car' : 'passenger_vehicle-vehicle_type_coach-fuel_source_na-distance_na-engine_size_na',
    'Domestic Flight' : 'passenger_flight-route_type_domestic-aircraft_type_na-distance_na-class_na-rf_included-distance_uplift_included',
    'International Flight' : 'passenger_flight-route_type_international-aircraft_type_na-distance_long_haul_gt_3700km-class_economy-rf_included-distance_uplift_included',
  };
}