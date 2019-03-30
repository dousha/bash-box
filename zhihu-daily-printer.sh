#!/bin/bash

output_dir="${HOME}/Documents/news/"
printer_name="HP_Remote"

if [[ -z $1 ]]; then
	date_string=`date '+%Y%m%d'`
else
	date_string=$1
fi

if ./zhihu-daily ${date_string}; then
	if [[ -d "${output_dir}zhihu-${date_string}" ]]; then
		find "${output_dir}zhihu-${date_string}" -name \*.html | while read f; do
			wkhtmltopdf -q -g "$f" "${f}.pdf"
		done
		find "${output_dir}zhihu-${date_string}" -name \*.pdf -exec lp -o outputorder=reverse -d "$printer_name" {} \;
	else
		echo "!> Print cancelled due to fetch failed"
		exit -1
	fi
else
	echo "!> Print cancelled due to fetch error"
	exit -1
fi

