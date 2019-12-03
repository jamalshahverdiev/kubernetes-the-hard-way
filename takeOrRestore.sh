#!/usr/bin/env bash

if [ $# -lt 1 ]
then
    echo "Usage: $(basename $0) takeSnapshots/restoreSnapshots"
    exit 100
fi 

takeSnapshots(){
    for machine in kubecontroller1 kubecontroller2 kubecontroller3 kubeworker1 kubeworker2 kubeworker3 apilb
    do
        vagrant.exe snapshot save $machine $machine
    done 
}

restoreSnapshots(){
    for machine in kubecontroller1 kubecontroller2 kubecontroller3 kubeworker1 kubeworker2 kubeworker3 apilb
    do
        vagrant.exe snapshot restore $machine $machine
    done
}


if [ $1 == takeSnapshots ]
then 
     takeSnapshots
elif [ $1 == restoreSnapshots ]
then
     restoreSnapshots
else
     echo "Please type **takeSnapshots** of **restoreSnapshots**"
fi
