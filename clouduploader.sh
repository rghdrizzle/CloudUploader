#! /bin/bash
Help()
{
   echo "A tool to Upload your files to Azure Blob"
   echo
   echo "Syntax: clouduploader upload [-n]"
   echo "Note: Login using the below before uploading files"
   echo "Sytanx: clouduploader login"
   echo "options:"
   echo "-n  <Storage Name>"
   echo "-c <Connection String>"
   echo
}

if [ "$1" == "login" ]; then
az login;
elif [ "$1" == "upload" ]; then
	read -p "Enter the path:" path;
	if [ -f $path ]; then
		echo "uploading"
	else echo "File not Found.....Please enter a valid file path";
	fi 
fi

while getopts ":h" flag; do
   case $flag in
      h) 
         Help
         exit;;
     \?) 
         echo "Error: Invalid option"
         exit;;
   esac
done
