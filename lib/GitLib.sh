
#Returns 1 if the currently selected branch is the main / master branch; 0 otherwise.
GitLib_IsCurrentBranchMaster()
{
	branchName=$(GitLib_GetCurrentBranchName);
	mainBranch=$(GitLib_GetMasterOrMain);
	if [ $branchName = $mainBranch ]
		then
			echo "1";
		else
			echo "0";
	fi
};


#Get the name of the currently checked-out branch.
GitLib_GetCurrentBranchName()
{
	name=$(git branch | grep \* | cut -d ' ' -f2);
	echo $name;
}


#Get a fully qualified branch name from a specified portion.
GitLib_GetBranchNameFromPartial()
{
	# Delete using a partial match. Only works if a single match is found.
	greppedBranches=$(git branch | grep $1 -i | sed 's/ //g' | sed 's/*//g');
	matchedBranchCount=$(git branch | grep $1 -i | wc -l | sed 's/ //g');

	case $matchedBranchCount in
		'0')
			echo '0';
		;;
		'1')
			echo $greppedBranches;
		;;
		*)
			echo '2';
		;;
	esac
};


#Delete branch with fully qualified name.
GitLib_DeleteLocalBranch() 
{
	mainBranch=$(GitLib_GetMasterOrMain);
	if [ $1 = $mainBranch ]
		then
			echo -e "\nDon't delete master!\n";
		else
			git branch -D $1;
			echo "";
	fi
};


#Determine which main branch syntax is used, and return it. e.g. returns "master" or "main".
GitLib_GetMasterOrMain()
{
	if [ $(GitLib_BranchExists "master") = 1 ]
		then
			echo "master";
		else
			echo "main";
	fi
}


#Returns 1 if a specified branch exists; 0 otherwise.
GitLib_BranchExists()
{
	exists=$(git show-ref refs/heads/$1);
	if [ -n "$exists" ];
		then
			echo '1';
		else
			echo '0';
	fi
}
