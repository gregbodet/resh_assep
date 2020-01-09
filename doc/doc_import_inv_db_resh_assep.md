![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Procédures d'import des données issues des levés dans la base

## Principes

- L'organisation intègre une procédure spécifique destinée à stocker en phase transitoire pendant l'inventaire
- L'envoi de fichiers par le prestataire repose sur un gabarit QGIS maintenu et transmis par la collectivité
- Chaque envoi par le prestataire annule et remplace les envois précédents
- La donnée d'inventaire est intégrée en l'état dans une base temporaire sans contraintes (fkey, NULL ...)
- La données d'inventaire sont rendues consultables pour les services internes pour avis (signalement) au travers d'une webapp GEO

## Intégration de l'inventaire

1. dépot des fichiers **QGIS/SHP** livrés dans un répertoire daté du jour de réception et placé dans le dossier du projet **...\1803RESH-ARC-SDGEP\5-Prestation\livraison**
2. intégration des données en l'état dans le schéma temporaire pour la phase d'inventaire **m_resh_assep_inv** de la base de données **igeo_test** avec le workflow FME **data_assep_inv_file2db_dev.fmw**
3. controler les données de l'inventaire avec le worflow FME **data_assep_inv_file2chk.fmw**
4. 



