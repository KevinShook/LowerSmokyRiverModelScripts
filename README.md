# Lower Smoky River Model Scripts
Scripts to download, pre-process and post-process files for the Lower Smoky River CRHM model

The scripts are written in bash and therefore require either Cygwin on Windows or a Unix-type OS (such as Linux or OSX).
You can get Cygwin from https://www.cygwin.com/.
Note that there are 2 sets of scripts, one for Cygwin and the other for Linux (and Unix/OSX). The difference is that the Cygwin versions have the directories hard-coded and specified using the Cygwin notation to specify the drive letter. Cygwin is assumed to be installed in the directory c:\cygwin. The Linux scripts are also more flexible as they are intended to be used for teaching, rather than a single operational use.
The Linux scripts can be run from any directory and will create the subdirectories for the output files if they do not exist. Note that the Linux scripts have only been tested on Linux Mint 18.2.

These scripts require several standard bash programs (sed, gawk, wget) to be installed - if you are running under Cygwin, make sure that these programs are in your cygwin\bin directory. The scripts also require wgrib2, which is described at http://www.cpc.noaa.gov/products/wesley/wgrib2/ and can be donwloaded from http://opengrads.org/. Note that if you are using Cygwin the executable file must be copied to cygwin\bin.

Script file types

*  *.cmd    Windows command files. These files are only present in the Cygwin version. Each calls a bash .sh file with the same name.
*  *.sh     Bash script files. Note that these files must use Unix end of line characters. If you are editing on Windows, user an editor such as Notepad++ which will handle Unix files properly.
*  *.awk    Gawk files. These are also Unix files.

In the examples below 'X' refers to the meteorological variable:
AT = air temperature at 2m, 
PR = surface precipitation,
RH = relative humidity at 2m,
U  = westing wind speed at 10m,
V =  southing wind speed at 10m.

* get_X_forecast.sh  Downloads the NAEFS ensemble forecast grib files from http://dd.weatheroffice.gc.ca/ensemble/naefs/grib2/raw and processes the output to produce a WISKI compliant time series for a single variable type at each of the specified locations. Note that these files take a VERY long time to execute. The original forecasts have a spatial resolution of 0.5 x 0.5 degrees which is quite coarse, and a temporal resolution of 6 hours. However these forecasts are for 384 hours (16 days) into the future.

* get_X_forecast_GEM.sh Downloads the forecasts from the GEM flobal model at http://dd.weather.gc.ca/model_gem_global/25km/grib2/lat_lon. The GEM model is higher spatial (25 km) and temporal resolution (3 hours) than NAEFS, but is only projected 240 hours (24 days) into the future. On the other 

* ExtractX.awk  A gawk script to process the temporary files produced by the get_X_forecast.sh script. The variables require massaging including deaccumulation and unit conversions to be useful, and need to be converted to the WISKI model format.

* SmokyDaily*.sh Performs post-processing on the output of the CRHM Lower Smoky River model, producing daily summaries, and WISKI model 
