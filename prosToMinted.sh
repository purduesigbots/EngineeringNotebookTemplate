#!/bin/bash

# Must be run in the root directory of a PROS project
# The input should be the root directory of a LaTeX project

OUTPUT="codeToLaTeX.tex"
if [ -e "project.pros" ]
then
	if [ "$1" != "" ]
	then 
		echo "Transferring code..."
		printf "%%-----------------------------------------\n" > $OUTPUT
		printf "\\section[Iteration   Code]{Code}\n\n" >> $OUTPUT
	
		#add to minted section
        	for i in ./include/*.h
		do
			if [ "${i##*/}" == "API.h" ]
			then 
				continue; #don't add the PROS API to the notebook
			fi
			printf "\\subsection{include/%s}\n" "${i##*/}" >> $OUTPUT
			printf "\\inputminted{c}{Code/include/%s}\n" "${i##*/}" >> $OUTPUT
			printf "\\pagebreak\n\n" >> $OUTPUT
		done
		printf "\n\n" >> $OUTPUT
		echo "Added headers"
	
		for i in ./include/scripts/*.h
		do
       	        	printf "\\subsection{include/scripts/%s}\n" "${i##*/}" >> $OUTPUT
       	        	printf "\\inputminted{c}{Code/include/scripts/%s}\n" "${i##*/}" >> $OUTPUT
                	printf "\\pagebreak\n\n" >> $OUTPUT
        	done
		printf "\n\n" >> $OUTPUT
		echo "Added Scripts"

		for i in ./src/*.c
		do
                	printf "\\subsection{src/%s}\n" "${i##*/}" >> $OUTPUT
                	printf "\\inputminted{c}{Code/src/%s}\n" "${i##*/}" >> $OUTPUT
                	printf "\\pagebreak\n\n" >> $OUTPUT
        	done
		echo "Added Source Files"
		if [ -d "../$1/Code" ]
		then
			rm -rf ../$1/Code
		fi
		mkdir ../$1/Code
		mkdir ../$1/Code/src
		mkdir ../$1/Code/include 
		cp -r src/*.c ../$1/Code/src
		cp -r include/. ../$1/Code/include
	else
		echo "You must specify a destination for the files"
	fi
else
	echo "Selected directory is not a PROS directory"
fi
