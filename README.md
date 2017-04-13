# LowerSmokyRiverModelScripts
Scripts to download, pre-process and post-process files for the Lower Smoky River CRHM model

The scripts are written in bash and therefore require either Cygwin on Windows or a Unix-type OS (such as Linux or OSX).
You can get Cygwin from https://www.cygwin.com/.
Note that there are 2 sets of scripts, one for Cygwin and the other for Linux/OSX. The difference is that the Cygwin versions
have the directories hard-coded and specified using the Cygwin notation to spcify the drive letter. Cygwin is assumed to be installed in the directory c:\cygwin.
The Unix versions can be run from any directory and will create the subdirectories for the output files if they do not exist. Note that the Unix versions have only been tested on Linux Mint.

These scripts require several standard bash programs (sed, gawk, wget) to be installed - if you are running under Cygwin, make sure that these programs are in your cygwin\bin directory. The scripts also require wgrib2, which is described at http://www.cpc.noaa.gov/products/wesley/wgrib2/ and can be donwloaded from http://opengrads.org/. Note that if you are using Cygwin the executable file must be copied to cygwin\bin.

Script file types

*  *.cmd    Windows command files. These files are only present in the Cygwin version. Each calls a bash .sh file with the same name.
*  *.sh     Bash script files. Note that these files must use Unix end of line characters. If you are editing on Windows, user an editor such as Notepad++ which will handle Unix files properly.
*  *.awk    Gawk files. These are also Unix files.

In the examples below 'X' refers to the meteorological variable:
AT = air temperature at 2m, 
PR = surface precipitation,
RH = relative humidity at 2m,
U  = easting wind speed at 10m,
V =  northing wind speed at 10m.

* get_X_forecast.sh  Downloads the forecast grib files from http://dd.weatheroffice.gc.ca/ensemble/naefs/grib2/raw and processes the output to produce a WISKI compliant time series for a single variable type at each of the specified locations. Note that these files take a VERY long time to execute. The original forecasts have a resolution of 0.5 x 0.5 degrees which is quite coarse.

* ExtractX.awk  A gawk script to process the temporary files produced by the get_X_forecast.sh script. The variables require massaging including deaccumulation and unit conversions to be useful, and need to be converted to the WISKI model format.

* SmokyDaily*.sh Performs post-processing on the output of the CRHM Lower Smoky River model, producing daily summaries, and WISKI model 
