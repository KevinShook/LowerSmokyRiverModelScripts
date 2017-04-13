#!/bin/bash

# This script post-processes the Smoky River CRHM scenario runs
# producing daily outputs
# If required, it can also create the data files for Ploticus and run the program
# to produce spaghetti plots

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

# define paths and other variables
CRHM_output_path='/LSRM-DMS/CRHMOutput/'
temp_file_path='/LSRM-DMS/TempFiles/'
awk_script_path='/LSRM-DMS/'
smoky_tempfile='smokytemp'
combined_tempfile='combinedtemp'
SmokyHeaderFile='SmokyOutputHeader.tmp'
CRHM_run_filename='CRHM_output_'
CRHM_run_extension='.txt'
#Ploticus_file_location='../ploticus'
#Ploticus_script_location='../'
#Ploticus_Smoky_plfile='SmokyPlot.pl'
#Ploticus_LittleSmoky_plfile='LittleSmokyPlot.pl'
#Ploticus_output_type='-png'
awk_extract_CHRM_date='ExtractCRHMDateNumber.awk'
awk_extract_Smoky='ExtractCRHMSmokyDaily.awk'
awk_extract_LittleSmoky='ExtractCRHMLittleSmokyDaily.awk'
#awk_create_Ploticus='PloticusOutput.awk'

# Info for summary files
Header1='CRHM Smoky River Forecast System, Copyright (C) 2013 Centre for Hydrology, University of Saskachewan\r'
Header2='Forecast Mean Daily Flows (m3/s) for Lower Smoky River Local Inflows at Watino and Little Smoky River Local Inflows near Guy\r'
Header3='Date\tSmoky Local\tLittle Smoky Local\r'
SmokyForecastFile='CRHM_Smoky_Adjusted_Forecasts.txt'


# strip useful data from CRHM runs and concatenate them
# extract dates and times
gawk -f $awk_script_path$awk_extract_CHRM_date $CRHM_output_path$CRHM_run_filename'1'$CRHM_run_extension > $temp_file_path'CRHM_dates.txt'
# convert output from Windows format to Linux
dos2unix $temp_file_path'CRHM_dates.txt'

#cp $temp_file_path'CRHM_dates.txt' $temp_file_path'Smoky.txt'


# extract all of the CRHM flows for the Smoky and Little Smoky
 gawk -f $awk_script_path$awk_extract_Smoky $CRHM_output_path$CRHM_run_filename'1'$CRHM_run_extension > $temp_file_path'CRHMSmoky.tmp'
 gawk -f $awk_script_path$awk_extract_LittleSmoky $CRHM_output_path$CRHM_run_filename'1'$CRHM_run_extension > $temp_file_path'CRHMLittleSmoky.tmp'

# convert output from Windows format to Linux
 dos2unix $temp_file_path'CRHMSmoky.tmp'
 dos2unix $temp_file_path'CRHMLittleSmoky.tmp'


# paste files together with dates
 paste $temp_file_path'CRHM_dates.txt' $temp_file_path'CRHMSmoky.tmp' > $temp_file_path$smoky_tempfile'.tmp'
 paste $temp_file_path$smoky_tempfile'.tmp' $temp_file_path'CRHMLittleSmoky.tmp' > $temp_file_path$combined_tempfile'.tmp'


#create header files
d=$(date)

echo -e $Header1 > $temp_file_path$SmokyHeaderFile
echo -e "Created: "$d'\r' >> $temp_file_path$SmokyHeaderFile
echo -e $Header2 >> $temp_file_path$SmokyHeaderFile
echo -e $Header3 >> $temp_file_path$SmokyHeaderFile

# convert summary files back to Windows format
unix2dos $temp_file_path$smoky_tempfile'.tmp' 

# add headers to summary files

cat $temp_file_path$SmokyHeaderFile $temp_file_path$combined_tempfile'.tmp' > $temp_file_path$SmokyForecastFile

# delete temporary files
rm $temp_file_path'CRHM_dates.txt'
rm $temp_file_path'*.tmp' 


