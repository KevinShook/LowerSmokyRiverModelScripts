#!/bin/bash
#    Copyright (C) 2013, Kevin Shook, Centre for Hydrology
#    University of Saskatchewan, 12 Kirk Hall, 117 Science Place, Saskatoon, SK, S7N 5C8

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

#    This script downloads AT forecasts for 12h (GMT) and creates .tsf files
#    This version uses wildcards to prevent changes in the file names screwing up
#    the scripts

# define paths and other variables
# use ABSOLUTE paths
remote_location='http://dd.weather.gc.ca/ensemble/naefs/grib2/raw'
site_file='MetStations.txt'
run_time='12'
awk_script_path='/cygdrive/m/OPS/OIB/RFS/RiverEng/ICE/CRHM/LSRM-DMS/Scripts/'
grib_file_path='/cygdrive/m/OPS/OIB/RFS/RiverEng/ICE/CRHM/LSRM-DMS/GRIB/'
temp_file_path='/cygdrive/m/OPS/OIB/RFS/RiverEng/ICE/CRHM/LSRM-DMS/TempFiles/'
output_file_path='/cygdrive/m/OPS/OIB/RFS/RiverEng/ICE/CRHM/LSRM-DMS/TimeSeries/'
site_file_path='/cygdrive/m/OPS/OIB/RFS/RiverEng/ICE/CRHM/LSRM-DMS/Scripts/'
remote_variable='CMC_naefs-geps-raw_TMP_TGL_2m_latlon0p5x0p5_'
variable_type='AT'
maxhours=384
# download air temps
echo 'Downloading air temps'
# get today's date
dt=$(date -u +%Y%m%d)
yest=$(date --date='yesterday' -u +%Y%m%d)
for hour in `seq -f %03.0f 0 6 $maxhours`
  do
   wget -r -l1 --no-parent -nd -A $remote_variable$yest'*' $remote_location'/'$run_time'/'$hour'/'
  done
# move files to directory

cp *.grib2 $grib_file_path 
rm *.grib2 

# read file names, lats and lons from tab delimited file
index=0
while IFS=$'\t' read -r -a SiteArray
do
 names[$index]=${SiteArray[0]}
 lons[$index]=${SiteArray[1]}
 lats[$index]=${SiteArray[2]}
 index=$index+1
done < $site_file_path$site_file

#extract data from files; repeat for as many sites as necessary
echo 'Extracting data from files'
for hour in `seq -f %03.0f 0 6 $maxhours`
do
 for index in ${!names[*]}
  do
# get GRIB file using wildcards to uniquely identify each hour
   FILES=$remote_variable
   for f in $grib_file_path$FILES'*P'$hour'*.grib2'
    do 
     lat=${lats[$index]}
     lon=${lons[$index]}
     wgrib2 $f -start_FT -lon $lon $lat > $temp_file_path$variable_type$index'.tmp'
    # extract each line to a separate file
     for l in `seq 1 1 1`
      do
       sed -n $l'p' $temp_file_path$variable_type$index'.tmp' >> $temp_file_path$variable_type$index'scenario'$l'.tmp'
      done
    done
  done
done

#convert air temp to C and adjust time to be MST for each scenario
 for index in ${!names[*]}
  do
   site=${names[$index]}
   for l in `seq 1 1 1`
     do
       gawk -f $awk_script_path'Extract'$variable_type'.awk'  $temp_file_path$variable_type$index'scenario'$l'.tmp' > $output_file_path$site'_'$variable_type'_Forecast.tsf'
     done
 done

# delete temporary files
rm "$temp_file_path"*.tmp
# delete GRIB files
rm "$grib_file_path"*.grib2