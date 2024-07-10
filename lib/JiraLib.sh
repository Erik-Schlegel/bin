
JiraLib_GetFormattedTicketString()
{
	returnValue=$
		for i in $1;
			do B=`
				echo -n "${i:0:1}" | tr "[:lower:]" "[:upper:]"
			`;
			echo -n "${B}${i:1} ";
		done
	echo $returnValue;
};



JiraLib_GetHyphenatedTicketString()
{
	echo $1 | tr -s ' ' '-'4
};
