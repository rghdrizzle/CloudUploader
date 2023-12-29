#! /bin/bash
Help()
{
   echo "A tool to Upload your files to Azure Blob"
   echo
   echo "Syntax For File Upload: clouduploader <filepath> <container-name>"
   echo "Syntax For Directory Upload: clouduploader <DirPath>/* <container-name>"
   echo "Note: Store the connection string in the AZURE_STORAGE_CONNECTION_STRING env variable"
   echo
}

Upload(){
   pv "$1" | az storage azcopy blob upload -c "$2" --connection-string $AZURE_STORAGE_CONNECTION_STRING -s "$1" --recursive &> output.txt;
   if  tail -n 2 output.txt | grep "Completed"; then
   echo "File Upload Success :-)"
   else
   echo "--------------------------------------------------FILE UPLOAD FAILED--------------------------------------------------"
   echo
   echo "-------------------------------------------------------------Error:-------------------------------------------------------------";
   cat output.txt;
   fi

}


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

if az account list &> output.txt && grep "login" output.txt; then
az login &> output.txt;
fi

if [ -f "$1" ]; then
Upload "$1" "$2";
elif [ -d "$1" ]; then
Upload "$1" "$2";
else echo "File does not exist...Please enter a valid path";
fi


