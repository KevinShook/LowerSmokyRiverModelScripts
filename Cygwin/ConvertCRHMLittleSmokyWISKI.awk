# converts CRHM output for Smoky River to WISKI .tsf
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

#19/03/2014@05:00:00 -0.5 Q130  T1
{
  if (NR>1){
    dt=$1
    interval=$3
    codes="Q130  T1"
  # convert from Excel to Unix date timestamp, then format as WISKI date and time
    dt=dt-25569
    dt_secs=dt*24*3600
    dt_f=strftime("%d/%m/%Y@%H:%M:00",dt_secs)
    # convert flow from m3/hr to m3/s
    Q=interval/3600.0
    printf "%s %1.1f %s\r\n", dt_f,Q,codes
    }
}
