#!/bin/bash

# This script post-processes the Smoky River CRHM scenario runs
# producing hourly files for the WISKI model

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
CRHM_output_path='/cygdrive/m/OPS/OIB/RFS/RiverEng/ICE/CRHM/LSRM-DMS/CRHMFiles/'
awk_script_path='/cygdrive/m/OPS/OIB/RFS/RiverEng/ICE/CRHM/LSRM-DMS/Scripts/'
temp_file_path='/cygdrive/m/OPS/OIB/RFS/RiverEng/ICE/CRHM/LSRM-DMS/TempFiles/'
final_file_path='/cygdrive/m/OPS/OIB/RFS/RiverEng/ICE/CRHM/LSRM-DMS/FinalResults/'

CRHM_runs=1
CRHM_run_filename='CRHM_output_'
CRHM_run_extension='.txt'

awk_convert_Smoky='ConvertCRHMSmokyWISKI.awk'
awk_convert_LittleSmoky='ConvertCRHMLittleSmokyWISKI.awk'
#awk_create_Ploticus='PloticusOutput.awk'

# Info for summary files
SmokyWISKIFile='LowerSmokyLocal.tsf'
LittleSmokyWISKIFile='LittleSmokyLocal.tsf'


#dos2unix $CRHM_output_path$CRHM_run_filename'1'$CRHM_run_extension 

# extract all of the CRHM flows for the Smoky and Little Smoky
 gawk -f $awk_script_path$awk_convert_Smoky $CRHM_output_path$CRHM_run_filename'1'$CRHM_run_extension > $final_file_path$SmokyWISKIFile
 gawk -f $awk_script_path$awk_convert_LittleSmoky $CRHM_output_path$CRHM_run_filename'1'$CRHM_run_extension > $final_file_path$LittleSmokyWISKIFile





