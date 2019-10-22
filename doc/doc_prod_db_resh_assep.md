![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Changelog

- 04/10/2019 :description initiale du modèle de production de l'inventaire du réseau pluvial
- 22/10/2019 : ajout des attributs génériques 'ficmedia(x)' pour les objets du réseau
- 22/10/2019 : ajout d'un attribut 'refexc' comme réference du producteur pour les secteurs d'exclusion
- xx/xx/xxxx : ajout d'un attribut 'xxxxx' pour la liste des anomalies du réseau
- xx/xx/xxxx : ajout des fichiers 'xxxxx' relatifs à l'habillage du plan
- xx/xx/xxxx : ajout des attributs 'xxxxx' relatifs à la symbologie du réseau pluvial 

# Livrables

## Système de coordonnées

Les coordonnées seront exprimées en mètre avec trois chiffres après la virgule dans le système national en vigueur.
Sur le territoire métropolitain s'applique le système géodésique français légal RGF93 associé au système altimétrique IGN69. La projection associée Lambert 93 France (epsg:2154) sera à utiliser pour la livraison des données.

## Topologie

- deux opérations peuvent être sécantes
- tout objet est nécessairement inclu dans l'emprise de l'opération de levé qui lui est liée
- Les données du réseau appliquent une topologie de réseau en deux dimensions. Elle décrit la relation entre des arcs et des noeuds en inscrivant le référencement des noeuds dans la description des arcs. Ainsi toute canalisation ou réseau de surface est connecté à deux noeuds.
- un noeud fictif sécant sera appliqué tout les 50m dans le cas d'un réseau de surface rectiligne supérieur à cette distance afin de disposer de mesures (z) intermédaires
- tout objet appartient à une et une seule commune. Il faut donc couper les objets linéaires en utilisant si nécessaire un noeud fictif pour assurer le raccord topologique

## Format des fichiers

Les fichiers sont au format ESRI Shape (.SHP).
L'encodage des caractères est en UTF8.

## Description des classes d'objets

|Nom fichier | Définition | Catégorie | Géométrie |
|:---|:---|:---|:---|
|operation|Emprise d'une opération de levé du réseau|Métadonnée de production|Surface|
|exclusion|Secteur d'exclusion de levé|Métadonnée de production|Surface|
|pointleve|Point levé sur le terrain|Métadonnée de production|Ponctuel|
|canalisation|Canalisation d'eau pluviale|Réseau|Linéaire|
|reseausurf|Réseau de surface d'eau pluviale|Réseau|Linéaire|
|regard|Regard du réseau pluvial|Réseau|Ponctuel|
|avaloir|Avaloir du réseau pluvial|Réseau|Ponctuel|
|bassin|Bassin du réseau pluvial|Réseau|Ponctuel|
|ouvrage|Autre ouvrage du réseau pluvial|Réseau|Ponctuel|
|appareillage|Appareillage du réseau pluvial|Réseau|Ponctuel|
|noeud|Autre noeud du réseau pluvial |Réseau|Ponctuel|

## Implémentation informatique

### Métadonnées de production
  
`operation` : Emprise d'une opération de levé du réseau, correspondant généralement, à l'emprise d'une ou plusieurs voies publiques
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refope|Référence de l'opération|character varying(80)| |
|datefinope|Date de fin de l'opération de levé|date| |
|datedebope|Date de début de l'opération de levé|date| |
|observ|Observations|character varying(254)| |

Particularité(s) à noter :
* la référence de l'opération est reportée dans l'ensemble des autres classes d'objet
---
  
`exclusion` : Secteur d'exclusion de levé au sein d'une opération, correspondant généralement à une incapacité de lever le réseau
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refexc|Référence du secteur d'exclusion|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|observ|Observations|character varying(254)| |

---

`pointleve` : Point levé sur le terrain
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refptope|Matricule du point de levé|character varying(30)| |
|refope|Référence de l'opération|character varying(80)| |
|z|Altimétrie Z NGF (en mètres)|numeric(7,3)| |
|precxy|Précision absolue en planimètre (en mètres)|numeric(7,3)| |
|precz|Précision absolue en altimétrie (en mètres)|numeric(7,3)| |
|horodatage|Horodatage du point levé|timestamp| |
|observ|Observations|character varying(254)| |

### Réseau

`canalisation` : Canalisation d'eau pluviale

|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refassep|Référence producteur de l'entité|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|idnini|Identifiant du noeud de début de tronçon|character varying(254)| |
|idnterm|Identifiant du noeud de fin de tronçon|character varying(254)| |
|materiau|Matériau de la canalisation|character varying(5)|lt_materiau|
|diametre|Diamètre nominal de la canalisation (en millimètres)|integer| |
|forme|Forme de la section de la canalisation|character varying(2)|lt_formcanass|
|enservice|Canalisation en service (O/N)|character varying(1)|lt_boolean|
|branchemnt|Canalisation de branchement individuel (O/N)|character varying(1)|lt_boolean|
|modecirc|Mode de circulation de l'eau à l'intérieur de la canalisation|character varying(2)|lt_modecirc|
|fncanass|Fonction de la canalisation d'assainissement collectif|character varying(2)|lt_fncanass|
|zradnini|Cote radier de début de tronçon (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|zradnterm|Cote radier de fin de tronçon (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|sensecoul|Sens d'écoulement entre le noeud initial et terminal|character varying(1)|lt_sensecoul|
|doman|Domanialité|character varying(2)|lt_doman|
|qualglocxy|Qualité de la géolocalisation planimétrique (XY)|character varying(1)|lt_clprec|
|qualglocz|Qualité de la géolocalisation altimétrique (Z)|character varying(1)|lt_clprec|
|datemaj|Date de la dernière mise à jour des informations|date| |
|sourmaj|Source de la mise à jour|character varying(100)| |
|dategeoloc|Date de la géolocalisation|date| |
|sourgeoloc|Auteur de la géolocalisation|character varying(100)| |
|sourattrib|Auteur de la saisie des données attributaires (lorsque différent de l'auteur de la géolocalisation)|character varying(100)| |
|mesure|Paramètres chiffrés (x,y,z ...) issus d'un levé (O) ou interpollés (N)|character varying(1)|lt_boolean|
|fictif|Objet de construction topologique (fictif) (O) ou réel du réseau (N)|character varying(1)|lt_boolean|
|observ|Observations|character varying(254)| |
|ficmedia1|Nom du fichier media n°1 (avec extension)|character varying(254)| |
|ficmedia2|Nom du fichier media n°2 (avec extension)|character varying(254)| |
|ficmedia3|Nom du fichier media n°3 (avec extension)|character varying(254)| |

---

`reseausurf` : Réseau de surface
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refassep|Référence producteur de l'entité|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|idnini|Identifiant du noeud de début de tronçon|character varying(254)| |
|idnterm|Identifiant du noeud de fin de tronçon|character varying(254)| |
|typressurf|Type de réseau de surface d''eau pluviale|character varying(2)|lt_typressurf|
|zradnini|Cote radier de début de tronçon (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|zradnterm|Cote radier de fin de tronçon (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|sensecoul|Sens d'écoulement entre le noeud initial et terminal|character varying(1)|lt_sensecoul|
|doman|Domanialité|character varying(2)|lt_doman|
|qualglocxy|Qualité de la géolocalisation planimétrique (XY)|character varying(1)|lt_clprec|
|qualglocz|Qualité de la géolocalisation altimétrique (Z)|character varying(1)|lt_clprec|
|datemaj|Date de la dernière mise à jour des informations|date| |
|sourmaj|Source de la mise à jour|character varying(100)| |
|dategeoloc|Date de la géolocalisation|date| |
|sourgeoloc|Auteur de la géolocalisation|character varying(100)| |
|sourattrib|Auteur de la saisie des données attributaires (lorsque différent de l'auteur de la géolocalisation)|character varying(100)| |
|mesure|Paramètres chiffrés (x,y,z ...) issus d'un levé (O) ou interpollés (N)|character varying(1)|lt_boolean|
|fictif|Objet de construction topologique (fictif) (O) ou réel du réseau (N)|character varying(1)|lt_boolean|
|observ|Observations|character varying(254)| |
|ficmedia1|Nom du fichier media n°1 (avec extension)|character varying(254)| |
|ficmedia2|Nom du fichier media n°2 (avec extension)|character varying(254)| |
|ficmedia3|Nom du fichier media n°3 (avec extension)|character varying(254)| |

---

`regard` : Regard du réseau pluvial
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refassep|Référence producteur de l'entité|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|ztn|Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|zrad|Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|formregass|Forme du regard|character varying(2)|lt_formregass|
|tampon|Présence d'un tampon (O/N)|character varying(1)|lt_boolean|
|grille|Présence d'une grille (O/N)|character varying(1)|lt_boolean|
|acces|Regard accessible (O/N)|character varying(1)|lt_boolean|
|doman|Domanialité|character varying(2)|lt_doman|
|qualglocxy|Qualité de la géolocalisation planimétrique (XY)|character varying(1)|lt_clprec|
|qualglocz|Qualité de la géolocalisation altimétrique (Z)|character varying(1)|lt_clprec|
|datemaj|Date de la dernière mise à jour des informations|date| |
|sourmaj|Source de la mise à jour|character varying(100)| |
|dategeoloc|Date de la géolocalisation|date| |
|sourgeoloc|Auteur de la géolocalisation|character varying(100)| |
|sourattrib|Auteur de la saisie des données attributaires (lorsque différent de l'auteur de la géolocalisation)|character varying(100)| |
|mesure|Paramètres chiffrés (x,y,z ...) issus d'un levé (O) ou interpollés (N)|character varying(1)|lt_boolean|
|fictif|Objet de construction topologique (fictif) (O) ou réel du réseau (N)|character varying(1)|lt_boolean|
|observ|Observations|character varying(254)| |
|ficmedia1|Nom du fichier media n°1 (avec extension)|character varying(254)| |
|ficmedia2|Nom du fichier media n°2 (avec extension)|character varying(254)| |
|ficmedia3|Nom du fichier media n°3 (avec extension)|character varying(254)| |

---

`avaloir` : Avaloir du réseau pluvial
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refassep|Référence producteur de l'entité|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|ztn|Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|zrad|Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|typavalass|Type d'avaloir|character varying(2)|lt_typavalass|
|tampon|Présence d'un tampon (O/N)|character varying(1)|lt_boolean|
|doman|Domanialité|character varying(2)|lt_doman|
|qualglocxy|Qualité de la géolocalisation planimétrique (XY)|character varying(1)|lt_clprec|
|qualglocz|Qualité de la géolocalisation altimétrique (Z)|character varying(1)|lt_clprec|
|datemaj|Date de la dernière mise à jour des informations|date| |
|sourmaj|Source de la mise à jour|character varying(100)| |
|dategeoloc|Date de la géolocalisation|date| |
|sourgeoloc|Auteur de la géolocalisation|character varying(100)| |
|sourattrib|Auteur de la saisie des données attributaires (lorsque différent de l'auteur de la géolocalisation)|character varying(100)| |
|mesure|Paramètres chiffrés (x,y,z ...) issus d'un levé (O) ou interpollés (N)|character varying(1)|lt_boolean|
|fictif|Objet de construction topologique (fictif) (O) ou réel du réseau (N)|character varying(1)|lt_boolean|
|observ|Observations|character varying(254)| |
|ficmedia1|Nom du fichier media n°1 (avec extension)|character varying(254)| |
|ficmedia2|Nom du fichier media n°2 (avec extension)|character varying(254)| |
|ficmedia3|Nom du fichier media n°3 (avec extension)|character varying(254)| |

---

`bassin` : Bassin du réseau pluvial
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refassep|Référence producteur de l'entité|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|ztn|Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|zrad|Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|volume|Volume du bassin (en mètre cube)|integer||
|ouvfuite|Présence d'un ouvrage fuite (O/N)|character varying(1)|lt_boolean|
|diamdebfui|Diamètre du débit de fuite (en millimètre)|integer||
|ouvsurvers|Présence d'une surverse aménagée (O/N)|character varying(1)|lt_boolean|
|doman|Domanialité|character varying(2)|lt_doman|
|qualglocxy|Qualité de la géolocalisation planimétrique (XY)|character varying(1)|lt_clprec|
|qualglocz|Qualité de la géolocalisation altimétrique (Z)|character varying(1)|lt_clprec|
|datemaj|Date de la dernière mise à jour des informations|date| |
|sourmaj|Source de la mise à jour|character varying(100)| |
|dategeoloc|Date de la géolocalisation|date| |
|sourgeoloc|Auteur de la géolocalisation|character varying(100)| |
|sourattrib|Auteur de la saisie des données attributaires (lorsque différent de l'auteur de la géolocalisation)|character varying(100)| |
|mesure|Paramètres chiffrés (x,y,z ...) issus d'un levé (O) ou interpollés (N)|character varying(1)|lt_boolean|
|fictif|Objet de construction topologique (fictif) (O) ou réel du réseau (N)|character varying(1)|lt_boolean|
|observ|Observations|character varying(254)| |
|ficmedia1|Nom du fichier media n°1 (avec extension)|character varying(254)| |
|ficmedia2|Nom du fichier media n°2 (avec extension)|character varying(254)| |
|ficmedia3|Nom du fichier media n°3 (avec extension)|character varying(254)| |

---

`ouvrage` : Autre ouvrage du réseau pluvial (hors regard, avaloir et bassin)
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refassep|Référence producteur de l'entité|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|ztn|Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|zrad|Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|fnouvass|Fonction de l'ouvrage d'assainissement collectif|character varying(2)|lt_fnouvass|
|doman|Domanialité|character varying(2)|lt_doman|
|qualglocxy|Qualité de la géolocalisation planimétrique (XY)|character varying(1)|lt_clprec|
|qualglocz|Qualité de la géolocalisation altimétrique (Z)|character varying(1)|lt_clprec|
|datemaj|Date de la dernière mise à jour des informations|date| |
|sourmaj|Source de la mise à jour|character varying(100)| |
|dategeoloc|Date de la géolocalisation|date| |
|sourgeoloc|Auteur de la géolocalisation|character varying(100)| |
|sourattrib|Auteur de la saisie des données attributaires (lorsque différent de l'auteur de la géolocalisation)|character varying(100)| |
|mesure|Paramètres chiffrés (x,y,z ...) issus d'un levé (O) ou interpollés (N)|character varying(1)|lt_boolean|
|fictif|Objet de construction topologique (fictif) (O) ou réel du réseau (N)|character varying(1)|lt_boolean|
|observ|Observations|character varying(254)| |
|ficmedia1|Nom du fichier media n°1 (avec extension)|character varying(254)| |
|ficmedia2|Nom du fichier media n°2 (avec extension)|character varying(254)| |
|ficmedia3|Nom du fichier media n°3 (avec extension)|character varying(254)| |

---

`appareillage` : Appareillage du réseau pluvial
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refassep|Référence producteur de l'entité|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|fnappass|Fonction de l'appareillage d'assainissement collectif|character varying(2)|lt_fnappass|
|ztn|Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|zrad|Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|doman|Domanialité|character varying(2)|lt_doman|
|qualglocxy|Qualité de la géolocalisation planimétrique (XY)|character varying(1)|lt_clprec|
|qualglocz|Qualité de la géolocalisation altimétrique (Z)|character varying(1)|lt_clprec|
|datemaj|Date de la dernière mise à jour des informations|date| |
|sourmaj|Source de la mise à jour|character varying(100)| |
|dategeoloc|Date de la géolocalisation|date| |
|sourgeoloc|Auteur de la géolocalisation|character varying(100)| |
|sourattrib|Auteur de la saisie des données attributaires (lorsque différent de l'auteur de la géolocalisation)|character varying(100)| |
|mesure|Paramètres chiffrés (x,y,z ...) issus d'un levé (O) ou interpollés (N)|character varying(1)|lt_boolean|
|fictif|Objet de construction topologique (fictif) (O) ou réel du réseau (N)|character varying(1)|lt_boolean|
|observ|Observations|character varying(254)| |
|ficmedia1|Nom du fichier media n°1 (avec extension)|character varying(254)| |
|ficmedia2|Nom du fichier media n°2 (avec extension)|character varying(254)| |
|ficmedia3|Nom du fichier media n°3 (avec extension)|character varying(254)| |

---

`noeud` : Autre noeud du réseau pluvial (noeud de raccord topologique fictif)
   
|Nom attribut | Définition | Type | Valeurs |
|:---|:---|:---|:---|
|refassep|Référence producteur de l'entité|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|ztn|Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|zrad|Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|doman|Domanialité|character varying(2)|lt_doman|
|qualglocxy|Qualité de la géolocalisation planimétrique (XY)|character varying(1)|lt_clprec|
|qualglocz|Qualité de la géolocalisation altimétrique (Z)|character varying(1)|lt_clprec|
|datemaj|Date de la dernière mise à jour des informations|date| |
|sourmaj|Source de la mise à jour|character varying(100)| |
|dategeoloc|Date de la géolocalisation|date| |
|sourgeoloc|Auteur de la géolocalisation|character varying(100)| |
|sourattrib|Auteur de la saisie des données attributaires (lorsque différent de l'auteur de la géolocalisation)|character varying(100)| |
|mesure|Paramètres chiffrés (x,y,z ...) issus d'un levé (O) ou interpollés (N)|character varying(1)|lt_boolean|
|observ|Observations|character varying(254)| |
|ficmedia1|Nom du fichier media n°1 (avec extension)|character varying(254)| |
|ficmedia2|Nom du fichier media n°2 (avec extension)|character varying(254)| |
|ficmedia3|Nom du fichier media n°3 (avec extension)|character varying(254)| |

### Habillage

