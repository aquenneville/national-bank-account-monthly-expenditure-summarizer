#!/bin/bash
###############################################################################
#
# Author: aquenneville
#
# Description: 
# National bank account summarizer
# identical lines with same description are sumarized together
#
# Works on CSV exports from National bank  
# CSV header {
# Date,Description,Référence,Retraits,Dépôts,Solde,Transit émetteur,Contrepartie
# }
###############################################################################
# Default values
readonly _tps=0.05 # goods and services tax (canada)
readonly _tvq=0.09975 # goods and services tax (Quebec) 

_dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/"
let _tttx=((1+${_tps}+${_tvq}))

# 
# usage: 2014-01 20140330180751.csv
#
usage () 
{
    echo "Usage: $0 -y year -m month -f file.csv"
    exit 1;
}

# 
# read the options and arguments provided by the command line
# options: -y -m -f 
# see: usage
#
while getopts ":y:m:f:" o; do
  case "${o}" in
  y)
    _year=${OPTARG}
    ;;
  m)
    _month=${OPTARG}
    ;;
  f)
    _filename=${OPTARG}
    ;;
  *)
    usage
    ;;
  esac
done

#
# manage the number of arguments
# 
if [ $# -ne 6 ];
then
  echo "Error, illegal number of parameters."
  usage
fi

#
# check the arguments are not empty
#
[[ -z ${_year} ]] || [[ ! -z ${_month} ]] && [[ ! -z ${_filename} && {
  echo "Error, one the arguments is empty: (year:${_year} month: ${_month} filename: ${_filename}). \
  The arguments cannot be empty."
  usage
}

#
# start summarizing lines
# month has to be in the range [0..12]
[[ ${_month} -gt 0 ]] && [[ ${_month} -lt 13 ]] && {

  #
  # check if the month is less than 10 and
  # does not start with a "0"
  [[ ${_month} -lt 10 ]] && [[ ${_month} != "0"* ]] && {
    _month="0"${_month}
  }

  _year_month="${_year}-${month}"
  _SEP=",\t"
  
  echo "-----------------------------------------------------------------------"
  echo "Starting $0"
  echo "Timestamp: $(date +%Y%m%d-%H%M)"
  echo "Year-month: ${_year_month}"
  echo "-----------------------------------------------------------------------"
  echo -e "YYYY-MM\tAmount\tTPS\tTVQ"
  #
  # for all lines with same description summarize
  #
  # case: paid out 
  grep ${_year_month} ${_filename} | \
  awk -F, \
    '{array[$2]+=$4} \
    END { \
    for (i in array) \
    {print i${_SEP} array[i]${_SEP} (array[i]/${_tttx})*${_tps}${_SEP} (array[i]/${_tttx})*${_tvq}}} \
    ' | \
  sort -t, -k 2 -n | \
  awk -F, '$2{print $1,$2,$3,$4}'

  #
  # case: deposits summarize
  grep $MONTH $FILE | \
  awk -F, \
    '{array[$2]+=$5} 
    END { \
    for (i in array) \
    {print i${_SEP} array[i]${_SEP} (array[i]/${_tttx})*${_tps}${_SEP} (array[i]/${_tttx})*${_tvq}}} \
    ' | \
    awk -F, '$2{print $1,$2,$3,$4}'

} || {
  echo "Error, the month ${_month} is invalid."
  exit 1
}
