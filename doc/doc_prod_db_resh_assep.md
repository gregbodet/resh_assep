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
|idnini| | | |
|idnterm| | | |
|materiau|Matériau de la canalisation|character varying(5)|lt_materiau|
|diametre|Diamètre nominal de la canalisation (en millimètres)|integer| |
|forme|Forme de la section de la canalisation|character varying(2)|lt_formcanass|
|enservice|Canalisation en service (O/N)|character varying(1)|lt_boolean|
|branchemnt|Canalisation de branchement individuel (O/N)|character varying(1)|lt_boolean|
|modecirc|Mode de circulation de l'eau à l'intérieur de la canalisation|character varying(2)|lt_modecirc|
|fncanass|Fonction de la canalisation d'assainissement collectif|character varying(2)|lt_fncanass|
|zradnini| | | |
|zradnterm| | | |
|sensecoul| | | |
|doman| | | |
|qualglocxy| | | |
|qualglocz| | | |
|datemaj| | | |
|sourmaj| | | |
|dategeoloc| | | |
|sourgeoloc| | | |
|sourattrib| | | |
|mesure| | | |
|fictif| | | |
|observ|Observations|character varying(254)| |

---
