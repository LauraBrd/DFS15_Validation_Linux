#!/bin/bash

# -------- VARIABLES -------- #
GREEN="\033[32;1;4;7m"
GREEN2="\033[32;1m"
BLUE="\033[34;1m"
CYAN="\033[36;1m"
YELLOW="\033[33;1m"
RED="\033[31;1m"
CLOSE="\033[0m"
choix=0
reponse=0
# --------------------------- #


echo ""
echo -e "$GREEN ****** Bonjour utilisateur, bienvenu dans le TP de validataion Linux ! ****** $CLOSE"
echo ""
echo -e "$GREEN2 Veuillez vérifier si Vagrant et Virtualbox sont installés. $CLOSE"
echo ""


# -------------------------------------------------------------- #
# ------------ VERIFICATION DES LOGICIELS INSTALLES ------------ #
# -------------------------------------------------------------- #

# Vérifie que si l'on saisie un choix autre que 1 ou 2, on ne sort pas de la boucle.
while [ $choix != 1 ] && [ $choix != 2 ]
do
    echo -e "$CYAN ~ Sélectionnez un logiciel : $CLOSE"
    echo "    *" 1". Vagrant"
    echo "    *" 2". Virtualbox"
    read choix
    echo ""
    #echo -e "$YELLOW ******************** $CLOSE"

    # On teste les deux variable #
    if [ $choix == 1 ]
    then
        if command  -v vagrant ; 
        then
            echo -e "$GREEN2 File exist. $CLOSE"
            echo " Le logiciel Vagrant est déjà installé dans le répertoire ci-dessus."
            echo ""
        else
            echo -e "$RED File does not exist. $CLOSE"
            echo " Le logiciel Vagrant n'est pas installé."
        fi
    fi

    if [ $choix == 2 ]
    then
        if command -v virtualbox ; 
        then
            echo -e "$GREEN2 File exist. $CLOSE"
            echo " Le logiciel Virtualbox est déjà installé dans le répertoire ci-dessus."
            echo ""
        else
            echo -e "$RED File does not exist. $CLOSE"
            echo " Le logiciel Virtualbox n'est pas installé."
        fi
    fi
    # -------------------------- #

done



# --------------------------------------------------- #
# ------------ CREATION D'UNE VAGRANTBOX ------------ #
# --------------------------------------------------- #

echo -e " Nous allons maintenant créer une Vagrantbox."
echo ""

# Tant que la validation des choix est égale à "non", on ne sort pas de la boucle
while [ $reponse != 1 ]
do
    echo -e "$CYAN ~ Veuillez tout d'abord saisir un nom pour le dossier de synchronisation local :$CLOSE"
    read dossierSynchroLocal
    mkdir $dossierSynchroLocal
    echo ""

    echo -e "$CYAN ~ Choisissez maintenant un nom pour le dossier de synchronisation distant : $CLOSE"
    read dossierSynchroDistant
    echo ""

    echo -e "$CYAN ~ Validez-vous ces choix ? : $CLOSE"
    echo "Dossier local : $dossierSynchroLocal"
    echo "Dossier distant : $dossierSynchroDistant"
    echo ""
    echo "-----" 1". Oui"
    echo "-----" 2". Non"
    read reponse

    if [ $reponse == 1 ]
    then
        echo "Choix validés, la Vagrantbox va être créée."
        vagrant init
        sudo sed -i 's|config.vm.box = "base"|config.vm.box = "'ubuntu/xenial64'"|g' Vagrantfile
        sudo sed -i 's|# config.vm.network "private_network", ip: "192.168.33.10"|config.vm.network "private_network", ip: "192.168.33.10"|g' Vagrantfile
        sudo sed -i 's|# config.vm.synced_folder "../data", "/vagrant_data"|config.vm.synced_folder "./'$dossierSynchroLocal'", "'$dossierSynchroDistant'"|g' Vagrantfile

        vagrant up
        vagrant ssh
    fi
done


# ------------------------------------------------------ #
# ------------ INTERRACTION AVEC VAGRANTBOX ------------ #
# ------------------------------------------------------ #

echo -e "$GREEN2 Voici toutes les Vagrant en cours d'utilisation : $CLOSE"
vagrant status

echo -e "$CYAN Souhaitez-vous intéragir avec les Vagrant ? $CLOSE"

while [ $reponse != 3 ]
do
    echo "-----" 1". Allumer une Vagrant"
    echo "-----" 2". Eteindre une Vagrant"
    echo "-----" 3". Non, quitter"
    read reponse

    if [ $reponse == 1 ]
    then
        vagrant status
        echo "Sélectionnez une vagrant"
        read vagrant
        vagrant up $vagrant
    fi

    if [ $reponse == 2 ]
    then
        vagrant status
        echo "Sélectionnez une vagrant"
        read vagrant
        vagrant halt $vagrant
    fi
done