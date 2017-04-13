
# Input file for swb2, Maui low-res Test Case
# Base projection: Hawaii Albers Equal Area Conic
# (comment characters: !#$%*()-[] )
-------------------------------------------------

(0) PROJECT GRID DEFINITION
---------------------------

!                   Lower LH Corner              Grid
!                 |_________________________|    Cell
!       NX     NY       X0       Y0              Size
! "hi-res" version
#GRID  1582   1054  739800.    2276900.            50.

! "lo-res" version
GRID   316    210    739800.    2276900.           250.
BASE_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

(1) MODULE SPECIFICATION
-------------------------

INTERCEPTION_METHOD              GASH
EVAPOTRANSPIRATION_METHOD        MONTHLY_GRID
RUNOFF_METHOD                    RUNOFF_RATIO
SOIL_MOISTURE_METHOD             FAO-56
PRECIPITATION_METHOD             METHOD_OF_FRAGMENTS
FOG_METHOD                       MONTHLY_GRID
FLOW_ROUTING_METHOD              NONE
IRRIGATION_METHOD                FAO-56
CROP_COEFFICIENT_METHOD          FAO-56
DIRECT_RECHARGE_METHOD           GRIDDED
SOIL_STORAGE_MAX_METHOD          GRIDDED
AVAILABLE_WATER_CONTENT_METHOD   TABLE


(2) Initial conditions for soil moisture, snow
-----------------------------------------------

INITIAL_PERCENT_SOIL_MOISTURE    CONSTANT 50.0
INITIAL_SNOW_COVER_STORAGE       CONSTANT 0.0


(3) Daily rainfall-related grids and data
------------------------------------------

PRECIPITATION ARC_GRID input/month_year_rainfall/maui_prcp_%0m_%Y.asc
PRECIPITATION_GRID_PROJECTION_DEFINITION +proj=lonlat +datum=WGS84 +no_defs

FRAGMENTS_DAILY_FILE input/rain_fragments_maui_reduced_case.prn
FRAGMENTS_SEQUENCE_FILE input/frag_sequence_2yrs_5sims.out
FRAGMENTS_SEQUENCE_SIMULATION_NUMBER 1

RAINFALL_ZONE ARC_GRID input/maui_RAIN_ZONE__50m.asc
RAINFALL_ZONE_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

RAINFALL_ADJUST_FACTOR ARC_GRID input/Maui_RF_adj_factors/maui_RF_adj_%b__50m.asc
RAINFALL_ADJUST_FACTOR_PROJECTION_DEFINITION  +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs
RAINFALL_ADJUST_FACTOR_MONTHNAMES_LOWERCASE


(4) Monthly air temperature grids
----------------------------------

TMAX ARC_GRID input/Air_Temperature_Monthly/Tmax%b_250m_maui.asc
TMAX_GRID_PROJECTION_DEFINITION +proj=lonlat +datum=WGS84 +no_defs
TMAX_SCALE_FACTOR                 1.8
TMAX_ADD_OFFSET                  32.0
TMAX_MISSING_VALUES_CODE      -9999.0
TMAX_MISSING_VALUES_OPERATOR      <=
TMAX_MISSING_VALUES_ACTION       mean

TMIN ARC_GRID input/Air_Temperature_Monthly/Tmin%b_250m_maui.asc
TMIN_GRID_PROJECTION_DEFINITION +proj=lonlat +datum=WGS84 +no_defs
TMIN_SCALE_FACTOR                 1.8
TMIN_ADD_OFFSET                  32.0
TMIN_MISSING_VALUES_CODE      -9999.0
TMIN_MISSING_VALUES_OPERATOR      <=
TMIN_MISSING_VALUES_ACTION       mean


(5) Continuous Frozen-Ground Index initial value and parameters
---------------------------------------------------------------

INITIAL_CONTINUOUS_FROZEN_GROUND_INDEX CONSTANT 0.0

UPPER_LIMIT_CFGI 83.
LOWER_LIMIT_CFGI 55.


(6) "standard" GIS input grids: hydrologic soils group, available water capacity, soils, and flow direction
-----------------------------------------------------------------------------------------------------------

HYDROLOGIC_SOILS_GROUP ARC_GRID input/maui_HYDROLOGIC_SOILS_GROUP__50m.asc
HYDROLOGIC_SOILS_GROUP_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

LAND_USE ARC_GRID input/LU2010_w_2_season_sugarcane__simulation_1__50m.asc
LAND_USE_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

SOILS_CODE CONSTANT 1


%% in this case, the maximum soil storage is read in directly, so there is no need
%% for an available water capacity grid (soil_storage_max = awc * rooting_depth).

SOIL_STORAGE_MAX ARC_GRID input/maui_SOIL_MOISTURE_STORAGE__50m.asc
#MAX_SOIL_STORAGE_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs
SOIL_STORAGE_MAX_MISSING_VALUES_CODE          0.0
SOIL_STORAGE_MAX_MISSING_VALUES_OPERATOR      <
SOIL_STORAGE_MAX_MISSING_VALUES_ACTION       mean


(7) Other gridded datasets required for the Maui example
--------------------------------------------------------

REFERENCE_ET0 ARC_GRID input/gr0_in_month_ascii/gr0_in_%b__maui.asc
REFERENCE_ET0_PROJECTION_DEFINITION +proj=lonlat +datum=WGS84 +no_defs

FOG_RATIO ARC_GRID input/fog_fraction_grids/maui_fog_ratio_monthly_%0m__50m.asc
FOG_RATIO_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs
FOG_RATIO_MISSING_VALUES_CODE          0.0
FOG_RATIO_MISSING_VALUES_OPERATOR      <
FOG_RATIO_MISSING_VALUES_ACTION       zero

CESSPOOL_LEAKAGE ARC_GRID input/maui_CESSPOOL_EFFLUENT_INCHES_DAY__50m.asc
CESSPOOL_LEAKAGE_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

(8) Grids required for Gash Interception
-----------------------------------------

FRACTION_CANOPY_COVER ARC_GRID input/maui_CANOPY_COVER_FRACTION__50m.asc
FRACTION_CANOPY_COVER_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

EVAPORATION_TO_RAINFALL_RATIO ARC_GRID input/maui_EVAPORATION_TO_RAINFALL_RATIO__50m.asc
EVAPORATION_TO_RAINFALL_RATIO_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs


(9) Runoff-related data and grid
--------------------------------

RUNOFF_ZONE ARC_GRID input/maui_RUNOFF_ZONE__50m.asc
RUNOFF_ZONE_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs

RUNOFF_RATIO_MONTHLY_FILE input/monthly_runoff_ratios_maui_2000_2010_TRANSPOSED.txt

PERCENT_PERVIOUS_COVER ARC_GRID input/maui__PERCENT_PERVIOUS_COVER__50m.asc
PERCENT_PERVIOUS_COVER_PROJECTION_DEFINITION +proj=utm +zone=4 +ellps=WGS84 +datum=WGS84 +units=m +no_defs


(10) Lookup table(s)
--------------------

LAND_USE_LOOKUP_TABLE std_input/Landuse_lookup_maui.txt


(11) Start and end date for simulation
--------------------------------------

START_DATE 01/01/2001
END_DATE 12/31/2002
