%% D8 flow direction toy example

! Grid definition: projected coordinates are Wisconsin Transverse Mercator (83/91), meters
!      nx    ny     xll          yll     resolution
GRID    5     5  545300       432200       45.0
BASE_PROJECTION_DEFINITION +proj=tmerc +lat_0=0.0 +lon_0=-90.0 +k=0.9996 +x_0=520000 +y_0=-4480000 +datum=NAD83 +units=m

%% Define methods
-----------------

INTERCEPTION_METHOD              BUCKET
EVAPOTRANSPIRATION_METHOD        HARGREAVES
RUNOFF_METHOD                    CURVE_NUMBER
SOIL_MOISTURE_METHOD             FAO56_TWO_STAGE
PRECIPITATION_METHOD             GRIDDED
GROWING_DEGREE_DAY_METHOD        BASKERVILLE_EMIN
FOG_METHOD                       NONE
FLOW_ROUTING_METHOD              D8
IRRIGATION_METHOD                NONE
CROP_COEFFICIENT_METHOD          FAO-56
DIRECT_RECHARGE_METHOD           NONE
SOIL_STORAGE_MAX_METHOD          CALCULATED
AVAILABLE_WATER_CONTENT_METHOD   GRIDDED

GROWING_SEASON 133 268 TRUE


%% define location, projection, and conversions for weather data
----------------------------------------------------------------

PRECIPITATION NETCDF ../COMMON/prcp_Daymet_v3_%y.nc
PRECIPITATION_GRID_PROJECTION_DEFINITION +proj=lcc +lat_1=25.0 +lat_2=60.0 +lat_0=42.5 +lon_0=-100.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs
PRECIPITATION_NETCDF_Z_VAR                prcp
PRECIPITATION_SCALE_FACTOR          0.03937008
PRECIPITATION_MISSING_VALUES_CODE      -9999.0
PRECIPITATION_MISSING_VALUES_OPERATOR      <=
PRECIPITATION_MISSING_VALUES_ACTION       zero

TMAX NETCDF ../COMMON/tmax_Daymet_v3_%y.nc
TMAX_GRID_PROJECTION_DEFINITION +proj=lcc +lat_1=25.0 +lat_2=60.0 +lat_0=42.5 +lon_0=-100.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs
TMAX_SCALE_FACTOR                 1.8
TMAX_ADD_OFFSET                  32.0
TMAX_MISSING_VALUES_CODE      -9999.0
TMAX_MISSING_VALUES_OPERATOR      <=
TMAX_MISSING_VALUES_ACTION       mean

TMIN NETCDF ../COMMON/tmin_Daymet_v3_%y.nc
TMIN_GRID_PROJECTION_DEFINITION +proj=lcc +lat_1=25.0 +lat_2=60.0 +lat_0=42.5 +lon_0=-100.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs
TMIN_SCALE_FACTOR                 1.8
TMIN_ADD_OFFSET                  32.0
TMIN_MISSING_VALUES_CODE      -9999.0
TMIN_MISSING_VALUES_OPERATOR      <=
TMIN_MISSING_VALUES_ACTION       mean

INITIAL_CONTINUOUS_FROZEN_GROUND_INDEX CONSTANT 100.0
UPPER_LIMIT_CFGI 83.
LOWER_LIMIT_CFGI 55.

%% specify location and projection for input GIS grids
------------------------------------------------------

FLOW_DIRECTION ARC_GRID input/d8_flow_direction_northeast.asc
FLOW_DIRECTION_PROJECTION_DEFINITION  +proj=tmerc +lat_0=0.0 +lon_0=-90.0 +k=0.9996 +x_0=520000 +y_0=-4480000 +datum=NAD83 +units=m

HYDROLOGIC_SOILS_GROUP    CONSTANT    1
LAND_USE                  CONSTANT    1
AVAILABLE_WATER_CONTENT   CONSTANT    2.8

%% specify location and names for all lookup tables
---------------------------------------------------

LAND_USE_LOOKUP_TABLE     std_input/Landuse_lookup_D8_toy.txt
FAO_56_LOOKUP_TABLE       std_input/FAO_56_crop_coefficients_lookup.txt

%% initial conditions for soil moisture and snow storage amounts
%% may be specified as grids, but using a constant amount and
%% allowing the model to "spin up" for a year is also acceptable.

INITIAL_PERCENT_SOIL_MOISTURE CONSTANT 100.0
INITIAL_SNOW_COVER_STORAGE CONSTANT 2.0

DUMP_VARIABLES INDEX_RANGE 1 25

%% start and end date may be any valid dates in SWB version 2.0
%% remember to allow for adequate model spin up; running the
%% model for just a month or two will give questionable results

START_DATE 01/01/2012
END_DATE 12/31/2013
