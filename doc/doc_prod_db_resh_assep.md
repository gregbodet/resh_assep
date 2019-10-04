![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Livrables

## Topologie

- tout objet est nécessairement inclu dans l'emprise de l'opération de levé qui lui est liée
- toute canalisation ou réseau de surface est connecté à 2 noeuds.
- dans le
- tout objet appartient à une et une seule commune. Il faut donc couper les objets linéaires en utilisant si nécessaire un noeud fictif assurant le raccord topologique

## Description des classes d'objets


### Métadonnées de production
  
`operation` : Emprise d'une opération de levé du réseau, correspondant généralement, à l'emprise d'une ou plusieurs voies publiques
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|refope|Référence de l'opération|character varying(80)| |
|datefinope|Date de fin de l'opération de levé|date| |
|datedebope|Date de début de l'opération de levé|date| |
|observ|Observations|character varying(254)| |

Particularité(s) à noter :
* la référence de l'opération est reportée dans l'ensemble des autres classes d'objet
---
  
`exclusion` : Secteur d'exclusion de levé au sein d'une opération, correspondant généralement à une incapacité de lever le réseau
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|refope|Référence de l'opération|character varying(80)| |
|observ|Observations|character varying(254)| |

---

`pointleve` : Point levé sur le terrain
   
|Nom attribut | Définition | Type | Valeurs par défaut |
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

|Nom attribut | Définition | Type | Valeurs par défaut |
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

---

`reseausurf` : Réseau de surface
   
|Nom attribut | Définition | Type | Valeurs par défaut |
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

---

`regard` : Regard du résaeu pluvial
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|refassep|Référence producteur de l'entité|character varying(254)| |
|refope|Référence de l'opération|character varying(80)| |
|ztn|Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|zrad|Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)|numeric(7,3)| |
|formregass|Forme du regard|character varying(2)|lt_formregass|
|tampon|Présence d'un tampon (O/N)|character varying(1)|lt_boolean|
|grille|Présence d'une grille (O/N)|character varying(1)|lt_boolean|
|acces|v|character varying(1)|lt_boolean|
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

---
