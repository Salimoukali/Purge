#!/bin/bash

#HORODATAGE : Savoir la date et heure du lancement du programme
HORODATAGE=$(date '+%Y%m%d%H%M%S')
#Variables de travail
DIR_SHL="$PWD"
DIR_HOME="${DIR_SHL%/*}"
DIR_WRK="$DIR_HOME/wrk"
DIR_LOG="$DIR_HOME/log"
DIR_TMP="$DIR_HOME/tmp"
DIR_CFG="$DIR_HOME/cfg"
FIC_LOG="$DIR_LOG/purges_$HORODATAGE.log"
#LIST_FIC : Liste des fichiers à supprimer
LIST_FIC="$DIR_WRK/purges_$HORODATAGE.lst"

#Ouverture de LOG
#exec 1> $FIC_LOG 2>&1

echo "initPurges [INFO] : 0. Debut programme $0"
# Check de parametrage passé au programme
# si rien passe en parametrage dans le programme principale
if [ $# -eq 0 ]
then echo "initPurges [INFO] : Aucun nom de fichier de configuration passe en paramètre"
     echo "initPurges [INFO] : FIC_PARAM=$DIR_CFG/purges.cfg (Valeur par defaut)"
     FIC_PARAM="$DIR_CFG/purges.cfg"
#Si un valeur a été passé en paramètre dans le programme principale
else FIC_PARAM=$1
     echo "initPurges [INFO] : FIC_PARAM=$1"
fi

# Creation des environnement de travail pour le script de purges ( Premier fois)
mkdir -p $DIR_WRK
mkdir -p $DIR_LOG
mkdir -p $DIR_TMP

if ! test -s "$FIC_PARAM"
then    echo "initPurges [ERROR] : Fichier $FIC_PARAM vide ou inexistante"
        exit 1
fi

touch $LIST_FIC
echo "initPurges [INFO] : ####################################"
echo "initPurges [INFO] : 1. Detail des variables du programme"
echo "initPurges [INFO] : ####################################"
echo "initPurges [INFO] :"
echo "initPurges [INFO] : HORODATAGE = $HORODATAGE"
echo "initPurges [INFO] : DIR_HOME   = $DIR_HOME"
echo "initPurges [INFO] : DIR_SHL    = $DIR_SHL"
echo "initPurges [INFO] : DIR_WRK    = $DIR_WRK"
echo "initPurges [INFO] : DIR_LOG    = $DIR_LOG"
echo "initPurges [INFO] : DIR_TMP    = $DIR_TMP"
echo "initPurges [INFO] : DIR_CFG    = $DIR_CFG"
echo "initPurges [INFO] : LIST_FIC   = $LIST_FIC"
echo "initPurges [INFO] :"
echo "initPurges [INFO] :"
echo "initPurges [INFO] : Fin de initPurges"
