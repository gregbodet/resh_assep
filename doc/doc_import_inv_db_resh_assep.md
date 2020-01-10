![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Procédure d'intégration des données de réseau d'eau pluviale

# En phase d'inventaire

## Principes

- L'envoi de fichiers par le prestataire repose sur un gabarit QGIS maintenu et transmis par la collectivité
- Chaque envoi par le prestataire annule et remplace les envois précédents
- La donnée d'inventaire est intégrée en l'état dans une base temporaire sans contraintes (fkey, NULL ...)
- La données d'inventaire sont rendues consultables pour les services internes pour avis (signalement) au travers d'une webapp GEO

## Opérations

1. Dépot des fichiers **QGIS/SHP** livrés dans un répertoire daté AAAAMMJJ et placé dans le dossier du projet **...\1803RESH-ARC-SDGEP\5-Prestation\livraison**
2. Intégration des données en l'état dans le schéma temporaire pour la phase d'inventaire **m_resh_assep_inv** de la base de données **igeo_test** avec le workflow FME ...\1803RESH-ARC-SDGEP\3-BaseDeDonnees\import\ **data_assep_inv_file2db.fmw**
3. Controler les données de l'inventaire avec le worflow FME ...\1803RESH-ARC-SDGEP\3-BaseDeDonnees\import **data_assep_inv_file2chk.fmw**
4. 

# A l'initialisation de la phase de gestion

## Principes

## Opérations
