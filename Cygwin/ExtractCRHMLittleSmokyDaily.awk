# extracts CRHM output for Smoky River and removes header
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


{
  if (NR>1){
    dt=$1
    sum1=sum1+$2
# find end of day, and output mean Q
    if (dt==int(dt)){
      avg1=sum1/(24.0*3600)
      printf "%1.1f\r\n", avg1
      sum1=0
    }
  }
}
