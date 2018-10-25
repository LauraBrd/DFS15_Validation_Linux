# DFS15_Validation_Linux


## Vérification des logiciels insallés :

On choisit tout d'abord un logiciel. Le programme va alors vérifier s'il est installé ou non.
- Si le logiciel sélectionné est installé, un message de confirmation apparaît, ainsi que le répertoire où est installé le logiciel.
- Sinon, le script exécute l'installation du logiciel à l'aide de la commande "sudo apt install nomDuPaquet"

## Création de la Vagrantbox :

- Afin d'être créée, l'utilisateur doit entrer le nom du dossier local de synchronisation de la Vagrantbox.
- De même, il doit également entrer le nom du dossier distant de synchronisation.
- Lorsque les deux noms sont renseignés, une confirmation des champs renseignés est demandée auprès de l'utilisateur.
    - Si le choix est oui, la vagrantbox est créée.
    - Si le choix est non, la saisie des noms de dossiers est à nouveau proposée.

-> Problème rencontré : la virtualbox ne veut pas se créer, certains messages d'erreurs s'affichent.

## Intéraction avec les Vagrantbox :
Plusieurs choix pour intéragir avec les Vagrantbox :
- Allumer
- Eteindre
- Quitter

-> Tant que l'utilisateur ne choisis pas l'option "quitter", les choix sont proposés à l'infini.