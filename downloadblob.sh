#!/bin/bash

#This file is to download pretrained model file and associate synset.txt file. It is assumed that these two files are already in a blob
#container, if you want to use a pretrained image classification model and associated synset file, you can download them from the links below
# and put them in storage container
# wget http://data.dmlc.ml/mxnet/models/imagenet/synset.txt
# wget https://www.cntk.ai/resnet/ResNet_152.model

# Downloading Azure CLI on the VSTS build agent machine
apt-get update -y && apt-get install -y python libssl-dev libffi-dev python-dev build-essential
curl -L https://azurecliprod.blob.core.windows.net/install.py -o install.py
printf "/usr/azure-cli\n/usr/bin" | python install.py
az

#Setting environment variables to access the blob container
export AZURE_STORAGE_ACCOUNT=$1
export AZURE_STORAGE_KEY=$2
export container_name=$3
export blob_name1=$4
export blob_name2=$5

echo "Azure Storage Account" $AZURE_STORAGE_ACCOUNT
echo "Azure Storage key" $AZURE_STORAGE_KEY
echo "Azure BLOB Container name" $container_name
echo "Azure File Name 1" $blob_name1
echo "Azure File Name 2" $blob_name2


# Downloading Blob
#mkdir -p flaskwebapp 

#if [ $? -ne 0 ]; then
#   echo "creation of flaskwebb dir is unsuccessful !!"
#fi 

#echo "Checking what is inside  flaskwebapp !!"
#cd flaskwebapp
#echo $(ls)

#dir = "flaskwebapp" ;
#if [[ ! -e $dir ]]; then
#    mkdir $dir
#elif [[ ! -d $dir ]]; then
#    echo "$dir already exists but is not a directory" 1>&2
#fi  

#echo "==========================================="

az storage blob download --container-name $container_name --name $blob_name1 --file flaskwebapp/$blob_name1 --output table

#if [ $? != 0 ]; then
#   echo "Download of model file 1 from Azure Stoage Blob Unsuccessful !!"
#fi 

az storage blob download --container-name $container_name --name $blob_name2 --file flaskwebapp/$blob_name2 --output table

#if [ $? != 0 ]; then
#   echo "Download of model file 2 from Azure Stoage Blob Unsuccessful !!"
#fi 

az storage blob list --container-name $container_name --output table

#if [ $? != 0 ]; then
#   echo "List command after downloading models failed !!"
#fi 