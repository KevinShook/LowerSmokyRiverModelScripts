# extracts date, time and preip from decoded GRIB2 data
# output is in kg/m2, i.e. in mm, per interval
#    Copyright (C) 2012, Kevin Shook, Centre for Hydrology
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

BEGIN {FS = ":"}

{
# get date
 dt_string=$3
# separate date from cruft
 split(dt_string,d,"=")
 dt=d[2]

# get precip string
 pr_string=$4
# separate temp from cruft
 split(pr_string,p,"=")
 pr=p[4]
# deaccumulate precip.
 if (NR > 1)
  out_pr=pr-old_pr
 else
  out_pr=pr

# convert time string to time stamp using format "YYYY MM DD HH MM SS"
 dt=substr(dt,1,4) " " substr(dt,5,2) " " substr(dt,7,2) " " substr(dt,9,2) " 00 00 00"
 gmt=mktime(dt)

# convert date/time from GMT to MST
 delta=-7
 mdt=strftime("%d/%m/%Y@%H:00:00", gmt+(60*60*delta))

 # set quality code to 130 (fabricated) and type to 5 (total over inteval)
 printf "%s %5.1f Q130  T5\r\n",mdt,out_pr
 old_pr=pr
}
