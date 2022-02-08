#!/bin/bash

#On ajoute la configuration initiale
source initPurges.sh

# on boucle sur le fichier $FIC_PARAM
while read ligne ; do
    # on saute les lignes vides ou commentées
    echo "$ligne" | grep -E "^$" > /dev/null && continue
    echo "$ligne" | grep -E "^#" > /dev/null && continue

    # Pour chaque consigne on parse afin d'obtenir les infos sur les champs

    #REP=$( eval echo  $(echo "$ligne" | cut -d";" -f1))
    REP=$(echo "$ligne" | cut -d";" -f1)
    FIC_PATTERN=$(echo "$ligne" | cut -d";" -f2)
    RETENTION=$(echo "$ligne" | cut -d";" -f3)
    PROFONDEUR=$(echo "$ligne" | cut -d";" -f4)
    if [ "x$PROFONDEUR" = "x" ]
    then
       PROFONDEUR=1
    fi

    #Check de Repertoire
    #if test ! -d "$REP" -o -z "$REP"; then
    if test ! -d "$REP"; then
        echo "[WARNING] $REP n'existe pas. Merci de corriger $FIC_PARAM"
        continue
    fi

    # Affichage de la configuration pour la ligne de paramétrage
    echo "[INFO] Purge de REP=$REP FIC_PATTERN=$FIC_PATTERN RETENTION=$RETENTION PROFONDEUR=$PROFONDEUR"


    # on purge
    # on peut tomber sur une erreur si la liste de fichier à supprimer est trop grande à cause du ls
    # dans ce cas, supprimer ceci de la commande find : -exec ls -1td "{}" +
    #find $REP -name "$FIC_PATTERN" -mtime "+$RETENTION" -maxdepth "$PROFONDEUR" -exec ls -1td "{}" + | while read findLine; do
    find $REP -name "$FIC_PATTERN" -mtime "+$RETENTION" -maxdepth "$PROFONDEUR"  | while read findLine; do
        #Obtenir la taille du fichier qu'on va supprimer
        taille=$(wc -c $findLine | awk '{print $1}')
        # On supprime le fichier
        echo "Fichier a supprimer : $findLine"
	if  rm -f $findLine
        #then   printf  "%-150s%15d%10s\n" $findLine $taille SUPPRIME >> $LIST_FIC
        then   echo "$findLine $taille SUPPRIME" >> $LIST_FIC
        #else   printf  "%-150s%15d%10s\n" $findLine $taille ERROR >> $LIST_FIC
        else   echo "$findLine $taille ERROR" >> $LIST_FIC
        fi
    done
done < "$FIC_PARAM"
echo "Compte rendu des fichiers purgés : cat $LIST_FIC "
cat $LIST_FIC
