![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Livrables

Les livrables transmis auprès de la collectivé 

## Classes d'objets

ds

 ### Métadonnées de production  :
  
   `operation` : Emprise d'une opération de levé du réseau, correspondant généralement, à l'emprise d'une ou plusieurs voies publiques
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|refope|Référence de l'opération|character(80)| |
|datefinope|Date de fin de l'opération de levé|Date| |
|datedebope|Date de début de l'opération de levé|Date| |
|observ|Observations|character varying(254)| |

Particularité(s) à noter :
* la référence de l'opération est reportée dans l'ensemble des autres classes d'objet
---
  
   `exclusion` : Secteur d'exclusion de levé au sein d'une opération, correspondant généralement à une incapacité de lever le réseau
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|refope|Référence de l'opération|character(80)| |
|observ|Observations|character varying(254)| |

---

   `pointleve` : Point levé sur le terrain
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|refptope|Matricule du point de levé|character(30)| |
|refope|Référence de l'opération|character(80)| |
|z|Altimétrie Z NGF (en mètres)|numeric(7,3)| |
|precxy|Précision absolue en planimètre (en mètres)|numeric(7,3)| |
|precz|Précision absolue en altimétrie (en mètres)|numeric(7,3)| |
|horodatage|Horodatage du point levé|Date Heure| |
|observ|Observations|character varying(254)| |

Particularité(s) à noter :
* la référence de l'opération est reportée dans l'ensemble des autres classes d'objet
