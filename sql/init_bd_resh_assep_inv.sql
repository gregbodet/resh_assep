/*
Réseau d'eau pluviale
Creation du squelette de la structure nécessaire au stockage temporaire des données pendant la phase d'inventaire
init_bd_resh_assep_inv.sql
PostGIS

GeoCompiegnois - http://geo.compiegnois.fr/
Auteur : Florent Vanhoutte
*/




-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        DROP                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- schema
DROP SCHEMA IF EXISTS m_resh_assep_inv CASCADE;



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                       SCHEMA                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- Schema: m_resh_assep_inv

-- DROP SCHEMA m_resh_assep_inv;

CREATE SCHEMA m_resh_assep_inv;

COMMENT ON SCHEMA m_resh_assep_inv
  IS 'Réseaux d''eau pluviale (base temporaire pour inventaire)';




-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SEQUENCE                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- Sequence: m_resh_assep_inv.idopedetec_seq

-- DROP SEQUENCE m_resh_assep_inv.idopedetec_seq;

CREATE SEQUENCE m_resh_assep_inv.idopedetec_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

-- Sequence: m_resh_assep_inv.idexcdetec_seq

-- DROP SEQUENCE m_resh_assep_inv.idexcdetec_seq;

CREATE SEQUENCE m_resh_assep_inv.idexcdetec_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

-- Sequence: m_resh_assep_inv.idptleve_seq

-- DROP SEQUENCE m_resh_assep_inv.idptleve_seq;

CREATE SEQUENCE m_resh_assep_inv.idptleve_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;


    
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  CLASSE OBJET                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- #################################################################### CLASSE OPERATION DE DETECTION ###############################################

-- Table: m_resh_assep_inv.geo_assep_operation

-- DROP TABLE m_resh_assep_inv.geo_assep_operation;

CREATE TABLE m_resh_assep_inv.geo_assep_operation
(
  idopedetec character varying(254) NOT NULL,
  refope character varying(80), -- fkey vers classe opedetec
  typope character varying(2), -- fkey vers domaine de valeur lt_typope
  natres character varying(7), -- fkey vers domaine de valeur lt_natres
  mouvrage character varying(80),
  presta character varying(80),
  datefinope date,
  datedebope date,  
  observ character varying(254),
  sup_m2 integer,
  dbinsert timestamp without time zone NOT NULL DEFAULT now(),  
  dbupdate timestamp without time zone,
  geom geometry(MultiPolygon,2154) NOT NULL
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.geo_assep_operation
  IS 'Opération de détection de réseaux';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.idopedetec IS 'Identifiant unique de l''opération de détection dans la base de données';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.refope IS 'Référence de l''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.typope IS 'Type d''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.natres IS 'Nature du réseau faisant l''objet de l''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.mouvrage IS 'Maitre d''ouvrage de l''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.presta IS 'Prestataire de l''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.datefinope IS 'Date de fin de l''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.datedebope IS 'Date de début de l''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.observ IS 'Commentaires divers';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.sup_m2 IS 'Superficie de l''opération de détection (en mètres carrés)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_operation.geom IS 'Géométrie de l''objet';

ALTER TABLE m_resh_assep_inv.geo_assep_operation ALTER COLUMN idopedetec SET DEFAULT nextval('m_resh_assep_inv.idopedetec_seq'::regclass);


-- #################################################################### CLASSE ZONE D'EXCLUSION ###############################################

-- Table: m_resh_assep_inv.geo_assep_exclusion

-- DROP TABLE m_resh_assep_inv.geo_assep_exclusion;

CREATE TABLE m_resh_assep_inv.geo_assep_exclusion
(
  idexcdetec character varying(254) NOT NULL,
  refexc character varying(254),
  refope character varying(80), -- fkey vers classe opedetec
  observ character varying(254),
  sup_m2 integer,
  dbinsert timestamp without time zone NOT NULL DEFAULT now(),  
  dbupdate timestamp without time zone,
  geom geometry(Polygon,2154) NOT NULL
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.geo_assep_exclusion
  IS 'Secteur d''exclusion de détection de réseaux';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_exclusion.idexcdetec IS 'Identifiant unique du secteur d''exclusion de détection dans la base de données';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_exclusion.refexc IS 'Référence du secteur d''exclusion de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_exclusion.refope IS 'Référence de l''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_exclusion.observ IS 'Commentaires divers';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_exclusion.sup_m2 IS 'Superficie du secteur d''exclusion de détection (en mètres carrés)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_exclusion.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_exclusion.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_exclusion.geom IS 'Géométrie de l''objet';

ALTER TABLE m_resh_assep_inv.geo_assep_exclusion ALTER COLUMN idexcdetec SET DEFAULT nextval('m_resh_assep_inv.idexcdetec_seq'::regclass);




-- #################################################################### CLASSE POINT DE LEVE ###############################################

-- ## revoir cette classe par rapport à celle du PCRS


-- Table: m_resh_assep_inv.geo_assep_pointleve

-- DROP TABLE m_resh_assep_inv.geo_assep_pointleve;

CREATE TABLE m_resh_assep_inv.geo_assep_pointleve
(
  idptleve character varying(254) NOT NULL, -- pkey
  idptope character varying(254), -- unique
  refope character varying(80), -- fkey vers classe opedetec
  refptope character varying(30),
  insee character varying(5), 
  natres character varying(7), -- fkey vers domaine de valeur lt_natres  
  x numeric(10,3),
  y numeric(11,3),
  z numeric(7,3),
  precxy numeric (7,3),
  precz numeric (7,3),
  clprecxy character varying (1) DEFAULT 'C',  -- fkey vers domaine de valeur
  clprecz character varying (1) DEFAULT 'C', -- fkey vers domaine de valeur
  clprec character varying (1), -- fkey vers domaine de valeur #resultat combinaison prec xy et z généré par trigger
  horodatage timestamp without time zone,
  observ character varying(254),
  dbinsert timestamp without time zone DEFAULT now(),  
  dbupdate timestamp without time zone,
  geom geometry(Point,2154) NOT NULL
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.geo_assep_pointleve
  IS 'Point de détection/géoréférencement d''un réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.idptleve IS 'Identifiant unique du point de détection dans la base de données';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.idptope IS 'Identifiant unique du point de détection de l''opération';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.refope IS 'Référence de l''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.refptope IS 'Matricule/référence du point levé dans l''opération de détection';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.insee IS 'Code INSEE de la commmune';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.natres IS 'Nature du réseau levé';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.x IS 'Coordonnée X Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.y IS 'Coordonnée X Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.z IS 'Altimétrie Z NGF de la génératrice (supérieure si enterrée, inférieure si aérienne) du réseau (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.precxy IS 'Précision absolue en planimètre (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.precz IS 'Précision absolue en altimétrie (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.clprecxy IS 'Classe de précision planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.clprecz IS 'Classe de précision altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.clprec IS 'Classe de précision planimétrique et altimétrique (XYZ)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.horodatage IS 'Horodatage détection/géoréfécement du point';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.observ IS 'Commentaires divers';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_pointleve.geom IS 'Géométrie 3D de l''objet';

ALTER TABLE m_resh_assep_inv.geo_assep_pointleve ALTER COLUMN idptleve SET DEFAULT nextval('m_resh_assep_inv.idptleve_seq'::regclass);



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SEQUENCE                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- ##############################################################################################################################################
-- #                                                                      RESEAU                                                                #
-- ##############################################################################################################################################


-- Sequence: m_resh_assep_inv.idassep_seq
-- DROP SEQUENCE m_resh_assep_inv.idassep_seq;

CREATE SEQUENCE m_resh_assep_inv.idassep_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

-- Sequence:  m_resh_assep_inv.idnoeud_seq
-- DROP SEQUENCE m_resh_assep_inv.idnoeud_seq;

CREATE SEQUENCE m_resh_assep_inv.idnoeud_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;   
  
-- Sequence:  m_resh_assep_inv.idtroncon_seq
-- DROP SEQUENCE m_resh_assep_inv.idtroncon_seq;

CREATE SEQUENCE m_resh_assep_inv.idtroncon_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;  
   
-- Sequence:  m_resh_assep_inv.idouvrage_seq
-- DROP SEQUENCE m_resh_assep_inv.idouvrage_seq;

CREATE SEQUENCE m_resh_assep_inv.idouvrage_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1; 

-- Sequence:  m_resh_assep_inv.idappareil_seq
-- DROP SEQUENCE m_resh_assep_inv.idappareil_seq;

CREATE SEQUENCE m_resh_assep_inv.idappareil_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1; 


  
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  CLASSE OBJET                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- ##############################################################################################################################################
-- #                                                                      RESEAU                                                                #
-- ##############################################################################################################################################


-- ################################################################ CLASSE RESEAU ##############################################

-- Table: m_resh_assep_inv.an_assep_reseau

-- DROP TABLE m_resh_assep_inv.an_assep_reseau;

CREATE TABLE m_resh_assep_inv.an_assep_reseau
(
  idassep character varying(254) NOT NULL,
  refassep character varying(254),
  refope character varying(80), -- fkey vers classe opération de détection
  mouvrage character varying(100),
  gexploit character varying(100),
  doman character varying(2), -- fkey vers domaine de valeur
  anfinpose character varying(4),
  andebpose character varying(4),
  insee character varying(5),
  observ character varying(254),
  dbinsert timestamp without time zone NOT NULL DEFAULT now(),  
  dbupdate timestamp without time zone  
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_reseau
  IS 'Classe abstraite décrivant un objet du réseau d''eau pluviale';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.refassep IS 'Référence producteur de l''entité';  
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.refope IS 'Référence de l''opération de détection du réseau';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.mouvrage IS 'Maître d''ouvrage du réseau';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.gexploit IS 'Gestionnaire exploitant du réseau';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.doman IS 'Domanialité';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.anfinpose IS 'Année marquant la fin de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.andebpose IS 'Année marquant le début de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.insee IS 'Code INSEE';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.observ IS 'Observations';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseau.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';

ALTER TABLE m_resh_assep_inv.an_assep_reseau ALTER COLUMN idassep SET DEFAULT nextval('m_resh_assep_inv.idassep_seq'::regclass);


-- ################################################################ CLASSE METADONNEES  ##############################################

-- Table: m_resh_assep_inv.an_assep_metadonnees

-- DROP TABLE m_resh_assep_inv.an_assep_metadonnees;

CREATE TABLE m_resh_assep_inv.an_assep_metadonnees
(
  idassep character varying(254) NOT NULL,
  qualglocxy character varying(1), -- fkey vers domaine de valeur lt_assep_clprec
  qualglocz character varying(1), -- fkey vers domaine de valeur lt_assep_clprec
--  qualglocxy character varying(2) NOT NULL, -- fkey vers domaine de valeur lt_assep_qualgloc
--  qualglocz character varying(2) NOT NULL, -- fkey vers domaine de valeur lt_assep_qualgloc
  datemaj date,
  sourmaj character varying(100),
  dategeoloc date,
  sourgeoloc character varying(100),
  sourattrib character varying(100),
  qualannee character varying(2), -- information à renseignée uniquement si anposedeb=anposfin pour une canalisation ou un noeud, fkey vers domaine de valeur
  mesure character varying(1),
  fictif character varying(2)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_metadonnees
  IS 'Classe décrivant les métadonnées d''un objet du réseau d''eau pluviale';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.qualglocxy IS 'Qualité de la géolocalisation planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.qualglocz IS 'Qualité de la géolocalisation altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.datemaj IS 'Date de la dernière mise à jour des informations';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.sourmaj IS 'Source de la mise à jour';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.dategeoloc IS 'Date de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.sourgeoloc IS 'Auteur de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.sourattrib IS 'Auteur de la saisie des données attributaires (lorsque différent de l''auteur de la géolocalisation)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.qualannee IS 'Fiabilité de l''année de pose ou de mise en service';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.mesure IS 'Indication si les paramètres chiffrés (x,y,z ...) sont issus d''un levé (O) ou interpollés (N)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_metadonnees.fictif IS 'Indique si l''entité est une simple construction topologique (fictive) (O) ou un objet réel du réseau (N)';



-- ################################################################ CLASSE NOEUD ##############################################

-- Table: m_resh_assep_inv.geo_assep_noeud

-- DROP TABLE m_resh_assep_inv.geo_assep_noeud;

CREATE TABLE m_resh_assep_inv.geo_assep_noeud
(
  idassep character varying(254) NOT NULL,
  idnoeud character varying(254),
  x numeric(10,3),
  y numeric(11,3),
  ztn numeric(7,3),
  zrad numeric(7,3),
/*
z (a priori que pour ouvrages ou appareil)
catégorie de noeud (fictif ou non) si fictif z peut être à 0 ?
considérer que z de base = radier (ouvrage enterré) ou fond de fossé en cas de surface
autre z devront être précisé ztn = zrad dans le cas d'un noeud de fossé (donc fictif)
*/
  geom geometry(Point,2154) NOT NULL
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.geo_assep_noeud
  IS 'Classe abstraite décrivant un objet géographique ponctuel du réseau d''eau pluviale';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_noeud.idassep IS 'Identifiant unique d''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_noeud.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_noeud.x IS 'Coordonnée X Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_noeud.y IS 'Coordonnée Y Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_noeud.ztn IS 'Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_noeud.zrad IS 'Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_noeud.geom IS 'Géométrie ponctuelle de l''objet';

ALTER TABLE m_resh_assep_inv.geo_assep_noeud ALTER COLUMN idnoeud SET DEFAULT nextval('m_resh_assep_inv.idnoeud_seq'::regclass);


-- #################################################################### CLASSE OUVRAGE ASSEP ###############################################

-- Table: m_resh_assep_inv.an_assep_ouvrage

-- DROP TABLE m_resh_assep_inv.an_assep_ouvrage;

CREATE TABLE m_resh_assep_inv.an_assep_ouvrage
(
  idassep character varying(254) NOT NULL,
  idnoeud character varying(254),
  idouvrage character varying(254), -- fkey vers attribut idouvrage de la classe ouvrage
  typreseau character varying(2) DEFAULT '01', -- valeur fixée à 1 pour le pluvial -- fkey vers domaine de valeur lt_assep_typreseau
  fnouvass character varying(2) DEFAULT '00' -- fkey vers domaine de valeur
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_ouvrage
  IS 'Ouvrage d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_ouvrage.idassep IS 'Identifiant unique d''objet';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_ouvrage.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_ouvrage.idouvrage IS 'Identifiant de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_ouvrage.typreseau IS 'Type du réseau d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_ouvrage.fnouvass IS 'Fonction de l''ouvrage d''assainissement collectif';


-- #################################################################### CLASSE BASSIN ASSEP ###############################################

-- Table: m_resh_assep_inv.an_assep_bassin

-- DROP TABLE m_resh_assep_inv.an_assep_bassin;

CREATE TABLE m_resh_assep_inv.an_assep_bassin
(
  idassep character varying(254) NOT NULL,
  idnoeud character varying(254),
  idouvrage character varying(254), -- fkey vers attribut idouvrage de la classe ouvrage
  volume integer,
  ouvfuite character varying(1), -- fkey vers domaine lt_assep_boolean
  diamdebfui integer,
  ouvsurvers character varying(1) -- fkey vers domaine lt_assep_boolean 
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_bassin
  IS 'Bassin d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_bassin.idassep IS 'Identifiant unique d''objet';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_bassin.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_bassin.idouvrage IS 'Identifiant de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_bassin.volume IS 'Volume du bassin (en mètre cube)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_bassin.ouvfuite IS 'Présence d''un ouvrage fuite (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_bassin.diamdebfui IS 'Diamètre du débit de fuite (en millimètre)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_bassin.ouvsurvers IS 'Présence d''une surverse aménagée (O/N)';


-- #################################################################### CLASSE AVALOIR ASSEP ###############################################

-- Table: m_resh_assep_inv.an_assep_avaloir

-- DROP TABLE m_resh_assep_inv.an_assep_avaloir;

CREATE TABLE m_resh_assep_inv.an_assep_avaloir
(
  idassep character varying(254) NOT NULL,
  idnoeud character varying(254),
  idouvrage character varying(254), -- fkey vers attribut idouvrage de la classe ouvrage
  typavalass character varying(2), -- fkey vers domaine lt_assep_typavalass,
  tampon character varying(1) -- fkey vers domaine lt_assep_boolean
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_avaloir
  IS 'Avaloir d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_avaloir.idassep IS 'Identifiant unique d''objet';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_avaloir.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_avaloir.idouvrage IS 'Identifiant de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_avaloir.typavalass IS 'Type d''avaloir';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_avaloir.tampon IS 'Présence d''un tampon (O/N)';


-- #################################################################### CLASSE REGARD ASSEP ###############################################

-- Table: m_resh_assep_inv.an_assep_regard

-- DROP TABLE m_resh_assep_inv.an_assep_regard;

CREATE TABLE m_resh_assep_inv.an_assep_regard
(
  idassep character varying(254) NOT NULL,
  idnoeud character varying(254),
  idouvrage character varying(254), -- fkey vers attribut idouvrage de la classe ouvrage
  formregass character varying(2), -- fkey vers domaine lt_assep_formregass,
  tampon character varying(1), -- fkey vers domaine lt_assep_boolean
  grille character varying(1), -- fkey vers domaine lt_assep_boolean
  acces character varying(1) -- fkey vers domaine lt_assep_boolean
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_regard
  IS 'Regard d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_regard.idassep IS 'Identifiant unique d''objet';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_regard.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_regard.idouvrage IS 'Identifiant de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_regard.formregass IS 'Forme du regard';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_regard.tampon IS 'Présence d''un tampon (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_regard.grille IS 'Présence d''une grille (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_regard.acces IS 'Regard accessible (O/N)';


-- #################################################################### CLASSE APPAREILLAGE ASSEP ###############################################

-- Table: m_resh_assep_inv.an_assep_appareil

-- DROP TABLE m_resh_assep_inv.an_assep_appareil;

CREATE TABLE m_resh_assep_inv.an_assep_appareil
(
  idassep character varying(254) NOT NULL,
  idnoeud character varying(254),
  idappareil character varying(254), -- fkey vers attribut idappareil de la classe appareillage
  typreseau character varying(2) DEFAULT '01', -- fkey vers domaine de valeur
  fnappass character varying(2) DEFAULT '00' -- fkey vers domaine de valeur 
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_appareil
  IS 'Appareillage d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_appareil.idassep IS 'Identifiant unique d''objet';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_appareil.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_appareil.idappareil IS 'Identifiant de l''appareillage';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_appareil.typreseau IS 'Type du réseau d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_appareil.fnappass IS 'Fonction de l''appareillage d''assainissement collectif';


-- ################################################################ CLASSE TRONCON ##############################################

-- Table: m_resh_assep_inv.geo_assep_troncon

-- DROP TABLE m_resh_assep_inv.geo_assep_troncon;

CREATE TABLE m_resh_assep_inv.geo_assep_troncon
(
  idassep character varying(254) NOT NULL,
  idtroncon character varying(254),
  idnini character varying(254), -- fkey vers classe noeud (idnoeud)
  idnterm character varying(254), -- fkey vers classe noeud (idnoeud)
  zradnini numeric(7,3), -- !!! le z radier peut être différent de celui du noeud si la canalisation présente une chute dans le regard
  zradnterm numeric(7,3), -- !!! le z radier peut être différent de celui du noeud si la canalisation présente une chute dans le regard
  sensecoul character varying(1), -- fkey vers domaine de valeur
  longueur numeric(7,3), -- calcul auto
  pente numeric(6,2), -- calcul auto
  geom geometry(LineString,2154) NOT NULL   
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.geo_assep_troncon
  IS 'Classe abstraite décrivant un objet géographique linéaire du réseau d''eau pluviale';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.idassep IS 'Identifiant unique d''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.idtroncon IS 'Identifiant unique de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.idnini IS 'Identifiant du noeud de début de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.idnterm IS 'Identifiant du noeud de fin de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.zradnini IS 'Cote radier de début de tronçon (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.zradnterm IS 'Cote radier de fin de tronçon (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.sensecoul IS 'Sens d''écoulement entre le noeud initial et terminal'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.longueur IS 'Longueur de l''objet de tronçon en mètre'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.pente IS 'Pente en pourcentage';  
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_troncon.geom IS 'Géométrie linéaire de l''objet';

ALTER TABLE m_resh_assep_inv.geo_assep_troncon ALTER COLUMN idtroncon SET DEFAULT nextval('m_resh_assep_inv.idtroncon_seq'::regclass);


-- ################################################################ CLASSE CANALISATION ASSEP ##############################################

-- Table: m_resh_assep_inv.an_assep_canalisation

-- DROP TABLE m_resh_assep_inv.an_assep_canalisation;

CREATE TABLE m_resh_assep_inv.an_assep_canalisation
(
  idassep character varying(254) NOT NULL,
  idtroncon character varying(254),
-- zgn  
  materiau character varying(5) DEFAULT '00-00', -- fkey vers domaine de valeur lt_assep_materiau
  diametre integer,
  forme character varying(2) DEFAULT '00', -- fkey vers domaine de valeur lt_assep_formcanass  
  enservice character varying(1) DEFAULT '0', -- fkey vers domaine de valeur lt_assep_boolean
  branchemnt character varying(1) DEFAULT '0', -- fkey vers domaine de valeur lt_assep_boolean
  modecirc character varying(2) DEFAULT '00', -- fkey vers domaine de valeur lt_assep_modecirc   
-- voir utilité de conserver typreseau et contcanass puisque par définition la valeur figée à 01=pluvial
  typreseau character varying(2) DEFAULT '01', -- valeur fixée à 1 pour le pluvial -- fkey vers domaine de valeur lt_assep_typreseau
  contcanass character varying(2) DEFAULT '01', -- valeur fixée à 1 pour le pluvial -- fkey vers domaine de valeur lt_assep_contcanass
  fncanass character varying(2) DEFAULT '00' -- fkey vers domaine de valeur lt_assep_fncanass
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_canalisation
  IS 'Canalisation de réseau d''eau pluviale';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.idassep IS 'Identifiant unique d''objet';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.idtroncon IS 'Identifiant unique de tronçon';
-- COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.zgn IS 'Altimétrie de la génératrice supérieure de la canalisation (en mètres, Référentiel NGFIGN69)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.materiau IS 'Matériau de la canalisation';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.diametre IS 'Diamètre nominal de la canalisation (en millimètres)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.forme IS 'Forme de la section de la canalisation'; 
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.enservice IS 'Canalisation en service (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.branchemnt IS 'Canalisation de branchement individuel (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.modecirc IS 'Mode de circulation de l''eau à l''intérieur de la canalisation';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.typreseau IS 'Type du réseau d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.contcanass IS 'Catégorie de la canalisation d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_canalisation.fncanass IS 'Fonction de la canalisation d''assainissement collectif';


-- ################################################################ CLASSE RESEAU DE SURFACE ##############################################

-- Table: m_resh_assep_inv.an_assep_reseausurf

-- DROP TABLE m_resh_assep_inv.an_assep_reseausurf;

CREATE TABLE m_resh_assep_inv.an_assep_reseausurf
(
  idassep character varying(254) NOT NULL,
  idtroncon character varying(254),  
  typressurf character varying(2) DEFAULT '00' -- fkey vers domaine de valeur lt_assep_typressurf 
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_reseausurf
  IS 'Réseau de surface d''eau pluviale';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseausurf.idassep IS 'Identifiant unique d''objet';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseausurf.idtroncon IS 'Identifiant unique de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_reseausurf.typressurf IS 'Type de réseau de surface d''eau pluviale';



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SEQUENCE                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- Sequence: m_resh_assep_inv.idmedia_seq
-- DROP SEQUENCE m_resh_assep_inv.idmedia_seq;

CREATE SEQUENCE m_resh_assep_inv.idmedia_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  CLASSE OBJET                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



/*

a prévoir : hab txt, perimetre, cotation. prévoir domaine sur catégorie d'annotation

*/



-- ################################################################ CLASSE MEDIA  ##############################################

-- Table: m_resh_assep_inv.an_assep_media

-- DROP TABLE m_resh_assep_inv.an_assep_media;

CREATE TABLE m_resh_assep_inv.an_assep_media
(
  idmedia character varying(254) NOT NULL DEFAULT nextval ('m_resh_assep_inv.idmedia_seq'::regclass),
  id character varying(254),
  media text,
  miniature bytea,
  n_fichier text,
  t_fichier text
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_media
  IS 'Table gérant les documents liés au réseau d''assainissement des eaux pluviales';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_media.idmedia IS 'Identifiant unique du média';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_media.id IS 'Identifiant de l''objet de réseau pluvial (idassep)';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_media.media IS 'Champ Média de GEO';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_media.miniature IS 'Champ miniature de GEO';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_media.n_fichier IS 'Nom du fichier';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_media.t_fichier IS 'Type de média dans GEO';


-- ################################################################ CLASSE ANOMALIE  ##############################################

/*
dans le cadre du projet, il semble plus probant de ne pas gérer les anomalies sous la forme d'une relation 0-n avec celle du réseau, mais plutot comme une liste d'anomalie (attribut multivalué) de relation 0-1
*/

-- Table: m_resh_assep_inv.an_assep_anomalie

-- DROP TABLE m_resh_assep_inv.an_assep_anomalie;

CREATE TABLE m_resh_assep_inv.an_assep_anomalie
(
  idassep character varying(254) NOT NULL,
  anomal character varying(1),
  listanomal character varying(80) -- pas de lien vers fkey vers domaine de valeur lt_assep_typanomal car il s'agit d'un attribut multivalué > donc cardinalité 0-1 vers la classe objet réseau
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.an_assep_anomalie
  IS 'Classe décrivant les anomalies d''un objet du réseau d''eau pluviale';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_anomalie.idassep IS 'Identifiant unique d''objet du réseau';
COMMENT ON COLUMN m_resh_assep_inv.an_assep_anomalie.anomal IS 'Indication de la présence (O) ou l''absence (N) d''anomalie(s)';  
COMMENT ON COLUMN m_resh_assep_inv.an_assep_anomalie.listanomal IS 'Liste d''anomalie(s) du réseau d''eau pluviale';



-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        VUES                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- #################################################################### VUE CANALISATION ASSEP ###############################################
        
-- View: m_resh_assep_inv.geo_v_assep_canalisation

-- DROP VIEW m_resh_assep_inv.geo_v_assep_canalisation;

CREATE OR REPLACE VIEW m_resh_assep_inv.geo_v_assep_canalisation AS 
 SELECT 
  c.idassep,
  c.idtroncon,
  r.refassep,  
  r.refope,
  r.insee,  
  t.idnini,
  t.idnterm,
  c.materiau,
  c.diametre,
  c.forme,
  c.enservice,
  c.branchemnt,
  c.modecirc,
  c.typreseau,
  c.contcanass,
  c.fncanass,
  t.zradnini,
  t.zradnterm,
  t.sensecoul,  
  t.longueur,
  t.pente,
  r.mouvrage,
  r.gexploit,
  r.doman,
  r.anfinpose,
  r.andebpose,
  m.qualannee,
  m.qualglocxy,
  m.qualglocz,
  m.datemaj,
  m.sourmaj,
  m.dategeoloc,
  m.sourgeoloc,
  m.sourattrib,
  m.mesure,
  m.fictif,
  z.anomal,
  z.listanomal,   
  r.observ, 
  r.dbinsert,
  r.dbupdate,
  CASE WHEN c.materiau::text = ''::text THEN 'materiau n.r. '::text ELSE mat.valeur::text || ' '::text END || CASE WHEN c.diametre = 0 THEN 'Ø n.r.'::text ELSE 'Ø'::text || c.diametre::text END AS label_canalisation,  
  t.geom
  
FROM m_resh_assep_inv.an_assep_canalisation c
LEFT JOIN m_resh_assep_inv.geo_assep_troncon t ON t.idassep = c.idassep
LEFT JOIN m_resh_assep_inv.an_assep_reseau r ON r.idassep = c.idassep
LEFT JOIN m_resh_assep_inv.an_assep_metadonnees m ON m.idassep = c.idassep
LEFT JOIN m_resh_assep_inv.an_assep_anomalie z ON z.idassep = c.idassep
ORDER BY c.idassep;

COMMENT ON VIEW m_resh_assep_inv.geo_v_assep_canalisation
  IS 'Canalisation d''eau pluviale';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.refassep IS 'Référence producteur de l''entité';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.refope IS 'Référence de l''opération de détection du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.mouvrage IS 'Maître d''ouvrage du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.gexploit IS 'Gestionnaire exploitant du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.doman IS 'Domanialité';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.anfinpose IS 'Année marquant la fin de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.andebpose IS 'Année marquant le début de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.insee IS 'Code INSEE';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.observ IS 'Observations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.qualglocxy IS 'Qualité de la géolocalisation planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.qualglocz IS 'Qualité de la géolocalisation altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.datemaj IS 'Date de la dernière mise à jour des informations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.sourmaj IS 'Source de la mise à jour';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.dategeoloc IS 'Date de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.sourgeoloc IS 'Auteur de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.sourattrib IS 'Auteur de la saisie des données attributaires (lorsque différent de l''auteur de la géolocalisation)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.qualannee IS 'Fiabilité de l''année de pose ou de mise en service';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.mesure IS 'Indication si les paramètres chiffrés (x,y,z ...) sont issus d''un levé (O) ou interpollés (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.fictif IS 'Indique si l''entité est une simple construction topologique (fictive) (O) ou un objet réel du réseau (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.idtroncon IS 'Identifiant unique de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.idnini IS 'Identifiant du noeud de début de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.idnterm IS 'Identifiant du noeud de fin de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.zradnini IS 'Cote radier de début de tronçon (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.zradnterm IS 'Cote radier de fin de tronçon (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.sensecoul IS 'Sens d''écoulement entre le noeud initial et terminal'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.longueur IS 'Longueur de l''objet de tronçon en mètre'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.pente IS 'Pente en pourcentage';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.geom IS 'Géométrie linéaire de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.materiau IS 'Matériau de la canalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.diametre IS 'Diamètre nominal de la canalisation (en millimètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.forme IS 'Forme de la section de la canalisation'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.enservice IS 'Canalisation en service (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.branchemnt IS 'Canalisation de branchement individuel (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.modecirc IS 'Mode de circulation de l''eau à l''intérieur de la canalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.typreseau IS 'Type du réseau d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.contcanass IS 'Catégorie de la canalisation d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.fncanass IS 'Fonction de la canalisation d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.anomal IS 'Indication de la présence (O) ou l''absence (N) d''anomalie(s)';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_canalisation.listanomal IS 'Liste d''anomalie(s) du réseau d''eau pluviale';
 
  
-- #################################################################### VUE RESEAU SURFACE ASSEP ###############################################
        
-- View: m_resh_assep_inv.geo_v_assep_reseausurf

-- DROP VIEW m_resh_assep_inv.geo_v_assep_reseausurf;

CREATE OR REPLACE VIEW m_resh_assep_inv.geo_v_assep_reseausurf AS 
 SELECT 
  c.idassep,
  c.idtroncon,
  r.refassep,  
  r.refope,  
  r.insee,  
  t.idnini,
  t.idnterm,
  c.typressurf,
  t.zradnini,
  t.zradnterm,
  t.sensecoul,  
  t.longueur,
  t.pente,
  r.mouvrage,
  r.gexploit,
  r.doman,
  r.anfinpose,
  r.andebpose,
  m.qualannee,
  m.qualglocxy,
  m.qualglocz,
  m.datemaj,
  m.sourmaj,
  m.dategeoloc,
  m.sourgeoloc,
  m.sourattrib,
  m.mesure,
  m.fictif,  
  z.anomal,
  z.listanomal,   
  r.observ,
  r.dbinsert,
  r.dbupdate,      
  t.geom
  
FROM m_resh_assep_inv.an_assep_reseausurf c
LEFT JOIN m_resh_assep_inv.geo_assep_troncon t ON t.idassep = c.idassep
LEFT JOIN m_resh_assep_inv.an_assep_reseau r ON r.idassep = c.idassep
LEFT JOIN m_resh_assep_inv.an_assep_metadonnees m ON m.idassep = c.idassep
LEFT JOIN m_resh_assep_inv.an_assep_anomalie z ON z.idassep = c.idassep
ORDER BY c.idassep;

COMMENT ON VIEW m_resh_assep_inv.geo_v_assep_reseausurf
  IS 'Réseau de surface d''eau pluviale';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.refassep IS 'Référence producteur de l''entité';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.refope IS 'Référence de l''opération de détection du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.mouvrage IS 'Maître d''ouvrage du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.gexploit IS 'Gestionnaire exploitant du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.doman IS 'Domanialité';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.anfinpose IS 'Année marquant la fin de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.andebpose IS 'Année marquant le début de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.insee IS 'Code INSEE';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.observ IS 'Observations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';   
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.qualglocxy IS 'Qualité de la géolocalisation planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.qualglocz IS 'Qualité de la géolocalisation altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.datemaj IS 'Date de la dernière mise à jour des informations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.sourmaj IS 'Source de la mise à jour';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.dategeoloc IS 'Date de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.sourgeoloc IS 'Auteur de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.sourattrib IS 'Auteur de la saisie des données attributaires (lorsque différent de l''auteur de la géolocalisation)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.qualannee IS 'Fiabilité de l''année de pose ou de mise en service';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.mesure IS 'Indication si les paramètres chiffrés (x,y,z ...) sont issus d''un levé (O) ou interpollés (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.fictif IS 'Indique si l''entité est une simple construction topologique (fictive) (O) ou un objet réel du réseau (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.idtroncon IS 'Identifiant unique de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.idnini IS 'Identifiant du noeud de début de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.idnterm IS 'Identifiant du noeud de fin de tronçon';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.zradnini IS 'Cote radier de début de tronçon (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.zradnterm IS 'Cote radier de fin de tronçon (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.sensecoul IS 'Sens d''écoulement entre le noeud initial et terminal'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.longueur IS 'Longueur de l''objet de tronçon en mètre'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.pente IS 'Pente en pourcentage';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.geom IS 'Géométrie linéaire de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.typressurf IS 'Type de réseau de surface d''eau pluviale';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.anomal IS 'Indication de la présence (O) ou l''absence (N) d''anomalie(s)';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_reseausurf.listanomal IS 'Liste d''anomalie(s) du réseau d''eau pluviale';

-- #################################################################### VUE AUTRE NOEUD ASSEP ###############################################
        
-- View: m_resh_assep_inv.geo_v_assep_noeud

-- DROP VIEW m_resh_assep_inv.geo_v_assep_noeud;

CREATE OR REPLACE VIEW m_resh_assep_inv.geo_v_assep_noeud AS 

 SELECT 
  n.idassep,
  n.idnoeud,
  r.refassep,  
  r.refope,  
  r.insee,  
  n.x,
  n.y,
  n.ztn,
  n.zrad,
  r.mouvrage,
  r.gexploit,
  r.doman,
  r.anfinpose,
  r.andebpose,
  m.qualannee,
  m.qualglocxy,
  m.qualglocz,
  m.datemaj,
  m.sourmaj,
  m.dategeoloc,
  m.sourgeoloc,
  m.sourattrib,
  m.mesure,
  m.fictif,  
  z.anomal,
  z.listanomal,   
  r.observ, 
  r.dbinsert,
  r.dbupdate,     
  n.geom
  
FROM m_resh_assep_inv.geo_assep_noeud n
LEFT JOIN m_resh_assep_inv.an_assep_ouvrage o ON o.idassep = n.idassep
LEFT JOIN m_resh_assep_inv.an_assep_appareil a ON a.idassep = n.idassep
LEFT JOIN m_resh_assep_inv.an_assep_reseau r ON r.idassep = n.idassep
LEFT JOIN m_resh_assep_inv.an_assep_metadonnees m ON m.idassep = n.idassep
LEFT JOIN m_resh_assep_inv.an_assep_anomalie z ON z.idassep = n.idassep
WHERE (o.idassep IS NULL AND a.idassep IS NULL) 

ORDER BY n.idassep;

COMMENT ON VIEW m_resh_assep_inv.geo_v_assep_noeud
  IS 'Autre noeud du réseau d''eau pluviale'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.refassep IS 'Référence producteur de l''entité';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.refope IS 'Référence de l''opération de détection du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.mouvrage IS 'Maître d''ouvrage du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.gexploit IS 'Gestionnaire exploitant du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.doman IS 'Domanialité';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.anfinpose IS 'Année marquant la fin de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.andebpose IS 'Année marquant le début de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.insee IS 'Code INSEE';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.observ IS 'Observations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';   
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.qualglocxy IS 'Qualité de la géolocalisation planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.qualglocz IS 'Qualité de la géolocalisation altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.datemaj IS 'Date de la dernière mise à jour des informations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.sourmaj IS 'Source de la mise à jour';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.dategeoloc IS 'Date de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.sourgeoloc IS 'Auteur de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.sourattrib IS 'Auteur de la saisie des données attributaires (lorsque différent de l''auteur de la géolocalisation)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.qualannee IS 'Fiabilité de l''année de pose ou de mise en service';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.mesure IS 'Indication si les paramètres chiffrés (x,y,z ...) sont issus d''un levé (O) ou interpollés (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.fictif IS 'Indique si l''entité est une simple construction topologique (fictive) (O) ou un objet réel du réseau (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.x IS 'Coordonnée X Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.y IS 'Coordonnée Y Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.ztn IS 'Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.zrad IS 'Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.geom IS 'Géométrie ponctuelle de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.anomal IS 'Indication de la présence (O) ou l''absence (N) d''anomalie(s)';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_noeud.listanomal IS 'Liste d''anomalie(s) du réseau d''eau pluviale';


-- #################################################################### VUE AUTRE OUVRAGE ASSEP ###############################################
        
-- View: m_resh_assep_inv.geo_v_assep_ouvrage

-- DROP VIEW m_resh_assep_inv.geo_v_assep_ouvrage;

CREATE OR REPLACE VIEW m_resh_assep_inv.geo_v_assep_ouvrage AS 
 SELECT 
  o.idassep,
  o.idnoeud,
  o.idouvrage,
  r.refassep,  
  r.refope,  
  r.insee,
  o.typreseau,
  o.fnouvass,    
  n.x,
  n.y,
  n.ztn,
  n.zrad,
  r.mouvrage,
  r.gexploit,
  r.doman,
  r.anfinpose,
  r.andebpose,
  m.qualannee,
  m.qualglocxy,
  m.qualglocz,
  m.datemaj,
  m.sourmaj,
  m.dategeoloc,
  m.sourgeoloc,
  m.sourattrib,
  m.mesure,
  m.fictif,  
  z.anomal,
  z.listanomal,   
  r.observ,
  r.dbinsert,
  r.dbupdate,     
  n.geom
  
FROM m_resh_assep_inv.an_assep_ouvrage o
LEFT JOIN m_resh_assep_inv.an_assep_bassin b ON b.idassep = o.idassep
LEFT JOIN m_resh_assep_inv.an_assep_regard reg ON reg.idassep = o.idassep
LEFT JOIN m_resh_assep_inv.an_assep_avaloir ava ON ava.idassep = o.idassep
LEFT JOIN m_resh_assep_inv.geo_assep_noeud n ON n.idassep = o.idassep
LEFT JOIN m_resh_assep_inv.an_assep_reseau r ON r.idassep = o.idassep
LEFT JOIN m_resh_assep_inv.an_assep_metadonnees m ON m.idassep = o.idassep
LEFT JOIN m_resh_assep_inv.an_assep_anomalie z ON z.idassep = o.idassep
WHERE (b.idassep IS NULL AND reg.idassep IS NULL AND ava.idassep IS NULL) 

ORDER BY o.idassep;

COMMENT ON VIEW m_resh_assep_inv.geo_v_assep_ouvrage
  IS 'Autre ouvrage du réseau d''eau pluviale'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.refassep IS 'Référence producteur de l''entité';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.refope IS 'Référence de l''opération de détection du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.mouvrage IS 'Maître d''ouvrage du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.gexploit IS 'Gestionnaire exploitant du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.doman IS 'Domanialité';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.anfinpose IS 'Année marquant la fin de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.andebpose IS 'Année marquant le début de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.insee IS 'Code INSEE';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.observ IS 'Observations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';   
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.qualglocxy IS 'Qualité de la géolocalisation planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.qualglocz IS 'Qualité de la géolocalisation altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.datemaj IS 'Date de la dernière mise à jour des informations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.sourmaj IS 'Source de la mise à jour';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.dategeoloc IS 'Date de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.sourgeoloc IS 'Auteur de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.sourattrib IS 'Auteur de la saisie des données attributaires (lorsque différent de l''auteur de la géolocalisation)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.qualannee IS 'Fiabilité de l''année de pose ou de mise en service';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.mesure IS 'Indication si les paramètres chiffrés (x,y,z ...) sont issus d''un levé (O) ou interpollés (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.fictif IS 'Indique si l''entité est une simple construction topologique (fictive) (O) ou un objet réel du réseau (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.x IS 'Coordonnée X Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.y IS 'Coordonnée Y Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.ztn IS 'Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.zrad IS 'Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.geom IS 'Géométrie ponctuelle de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.idouvrage IS 'Identifiant de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.typreseau IS 'Type du réseau d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.fnouvass IS 'Fonction de l''ouvrage d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.anomal IS 'Indication de la présence (O) ou l''absence (N) d''anomalie(s)';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_ouvrage.listanomal IS 'Liste d''anomalie(s) du réseau d''eau pluviale';



-- #################################################################### VUE BASSIN ASSEP ###############################################
        
-- View: m_resh_assep_inv.geo_v_assep_bassin

-- DROP VIEW m_resh_assep_inv.geo_v_assep_bassin;

CREATE OR REPLACE VIEW m_resh_assep_inv.geo_v_assep_bassin AS 
 SELECT 
  b.idassep,
  b.idnoeud,
  b.idouvrage,
  r.refassep,  
  r.refope,  
  r.insee,
  o.typreseau,
  o.fnouvass,    
  n.x,
  n.y,
  n.ztn,
  n.zrad,
  b.volume,
  b.ouvfuite,
  b.diamdebfui,
  b.ouvsurvers,
  r.mouvrage,
  r.gexploit,
  r.doman,
  r.anfinpose,
  r.andebpose,
  m.qualannee,
  m.qualglocxy,
  m.qualglocz,
  m.datemaj,
  m.sourmaj,
  m.dategeoloc,
  m.sourgeoloc,
  m.sourattrib,
  m.mesure,
  m.fictif,  
  z.anomal,
  z.listanomal,   
  r.observ, 
  r.dbinsert,
  r.dbupdate,      
  n.geom
  
FROM m_resh_assep_inv.an_assep_bassin b
LEFT JOIN m_resh_assep_inv.an_assep_ouvrage o ON o.idassep = b.idassep
LEFT JOIN m_resh_assep_inv.geo_assep_noeud n ON n.idassep = b.idassep
LEFT JOIN m_resh_assep_inv.an_assep_reseau r ON r.idassep = b.idassep
LEFT JOIN m_resh_assep_inv.an_assep_metadonnees m ON m.idassep = b.idassep
LEFT JOIN m_resh_assep_inv.an_assep_anomalie z ON z.idassep = b.idassep
ORDER BY b.idassep;

COMMENT ON VIEW m_resh_assep_inv.geo_v_assep_bassin
  IS 'Bassin du réseau d''eau pluviale'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.refassep IS 'Référence producteur de l''entité';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.refope IS 'Référence de l''opération de détection du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.mouvrage IS 'Maître d''ouvrage du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.gexploit IS 'Gestionnaire exploitant du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.doman IS 'Domanialité';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.anfinpose IS 'Année marquant la fin de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.andebpose IS 'Année marquant le début de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.insee IS 'Code INSEE';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.observ IS 'Observations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';    
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.qualglocxy IS 'Qualité de la géolocalisation planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.qualglocz IS 'Qualité de la géolocalisation altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.datemaj IS 'Date de la dernière mise à jour des informations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.sourmaj IS 'Source de la mise à jour';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.dategeoloc IS 'Date de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.sourgeoloc IS 'Auteur de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.sourattrib IS 'Auteur de la saisie des données attributaires (lorsque différent de l''auteur de la géolocalisation)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.qualannee IS 'Fiabilité de l''année de pose ou de mise en service';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.mesure IS 'Indication si les paramètres chiffrés (x,y,z ...) sont issus d''un levé (O) ou interpollés (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.fictif IS 'Indique si l''entité est une simple construction topologique (fictive) (O) ou un objet réel du réseau (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.x IS 'Coordonnée X Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.y IS 'Coordonnée Y Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.ztn IS 'Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.zrad IS 'Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.geom IS 'Géométrie ponctuelle de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.idouvrage IS 'Identifiant de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.typreseau IS 'Type du réseau d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.fnouvass IS 'Fonction de l''ouvrage d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.volume IS 'Volume du bassin (en mètre cube)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.ouvfuite IS 'Présence d''un ouvrage fuite (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.diamdebfui IS 'Diamètre du débit de fuite (en millimètre)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.ouvsurvers IS 'Présence d''une surverse aménagée (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.anomal IS 'Indication de la présence (O) ou l''absence (N) d''anomalie(s)';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_bassin.listanomal IS 'Liste d''anomalie(s) du réseau d''eau pluviale';


-- #################################################################### VUE AVALOIR ASSEP ###############################################
        
-- View: m_resh_assep_inv.geo_v_assep_avaloir

-- DROP VIEW m_resh_assep_inv.geo_v_assep_avaloir;

CREATE OR REPLACE VIEW m_resh_assep_inv.geo_v_assep_avaloir AS 
 SELECT 
  a.idassep,
  a.idnoeud,
  a.idouvrage,
  r.refassep,  
  r.refope,  
  r.insee,
  o.typreseau,
  o.fnouvass,    
  n.x,
  n.y,
  n.ztn,
  n.zrad,
  a.typavalass,
  a.tampon,
  r.mouvrage,
  r.gexploit,
  r.doman,
  r.anfinpose,
  r.andebpose,
  m.qualannee,
  m.qualglocxy,
  m.qualglocz,
  m.datemaj,
  m.sourmaj,
  m.dategeoloc,
  m.sourgeoloc,
  m.sourattrib,
  m.mesure,
  m.fictif,  
  z.anomal,
  z.listanomal,   
  r.observ, 
  r.dbinsert,
  r.dbupdate,     
  n.geom
  
FROM m_resh_assep_inv.an_assep_avaloir a
LEFT JOIN m_resh_assep_inv.an_assep_ouvrage o ON o.idassep = a.idassep
LEFT JOIN m_resh_assep_inv.geo_assep_noeud n ON n.idassep = a.idassep
LEFT JOIN m_resh_assep_inv.an_assep_reseau r ON r.idassep = a.idassep
LEFT JOIN m_resh_assep_inv.an_assep_metadonnees m ON m.idassep = a.idassep
LEFT JOIN m_resh_assep_inv.an_assep_anomalie z ON z.idassep = a.idassep
ORDER BY a.idassep;

COMMENT ON VIEW m_resh_assep_inv.geo_v_assep_avaloir
  IS 'Avaloir du réseau d''eau pluviale'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.refassep IS 'Référence producteur de l''entité';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.refope IS 'Référence de l''opération de détection du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.mouvrage IS 'Maître d''ouvrage du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.gexploit IS 'Gestionnaire exploitant du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.doman IS 'Domanialité';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.anfinpose IS 'Année marquant la fin de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.andebpose IS 'Année marquant le début de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.insee IS 'Code INSEE';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.observ IS 'Observations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';   
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.qualglocxy IS 'Qualité de la géolocalisation planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.qualglocz IS 'Qualité de la géolocalisation altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.datemaj IS 'Date de la dernière mise à jour des informations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.sourmaj IS 'Source de la mise à jour';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.dategeoloc IS 'Date de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.sourgeoloc IS 'Auteur de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.sourattrib IS 'Auteur de la saisie des données attributaires (lorsque différent de l''auteur de la géolocalisation)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.qualannee IS 'Fiabilité de l''année de pose ou de mise en service';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.mesure IS 'Indication si les paramètres chiffrés (x,y,z ...) sont issus d''un levé (O) ou interpollés (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.fictif IS 'Indique si l''entité est une simple construction topologique (fictive) (O) ou un objet réel du réseau (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.x IS 'Coordonnée X Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.y IS 'Coordonnée Y Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.ztn IS 'Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.zrad IS 'Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.geom IS 'Géométrie ponctuelle de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.idouvrage IS 'Identifiant de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.typreseau IS 'Type du réseau d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.fnouvass IS 'Fonction de l''ouvrage d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.typavalass IS 'Type d''avaloir';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.tampon IS 'Présence d''un tampon (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.anomal IS 'Indication de la présence (O) ou l''absence (N) d''anomalie(s)';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_avaloir.listanomal IS 'Liste d''anomalie(s) du réseau d''eau pluviale';

-- #################################################################### VUE REGARD ASSEP ###############################################
        
-- View: m_resh_assep_inv.geo_v_assep_regard

-- DROP VIEW m_resh_assep_inv.geo_v_assep_regard;

CREATE OR REPLACE VIEW m_resh_assep_inv.geo_v_assep_regard AS 
 SELECT 
  reg.idassep,
  reg.idnoeud,
  reg.idouvrage,
  r.refassep,  
  r.refope,  
  r.insee,
  o.typreseau,
  o.fnouvass,    
  n.x,
  n.y,
  n.ztn,
  n.zrad,
  reg.formregass,
  reg.tampon,
  reg.grille,
  reg.acces,
  r.mouvrage,
  r.gexploit,
  r.doman,
  r.anfinpose,
  r.andebpose,
  m.qualannee,
  m.qualglocxy,
  m.qualglocz,
  m.datemaj,
  m.sourmaj,
  m.dategeoloc,
  m.sourgeoloc,
  m.sourattrib,
  m.mesure,
  m.fictif,  
  z.anomal,
  z.listanomal,   
  r.observ, 
  r.dbinsert,
  r.dbupdate,     
  n.geom
  
FROM m_resh_assep_inv.an_assep_regard reg
LEFT JOIN m_resh_assep_inv.an_assep_ouvrage o ON o.idassep = reg.idassep
LEFT JOIN m_resh_assep_inv.geo_assep_noeud n ON n.idassep = reg.idassep
LEFT JOIN m_resh_assep_inv.an_assep_reseau r ON r.idassep = reg.idassep
LEFT JOIN m_resh_assep_inv.an_assep_metadonnees m ON m.idassep = reg.idassep
LEFT JOIN m_resh_assep_inv.an_assep_anomalie z ON z.idassep = reg.idassep
ORDER BY o.idassep;

COMMENT ON VIEW m_resh_assep_inv.geo_v_assep_regard
  IS 'Regard du réseau d''eau pluviale'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.refassep IS 'Référence producteur de l''entité';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.refope IS 'Référence de l''opération de détection du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.mouvrage IS 'Maître d''ouvrage du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.gexploit IS 'Gestionnaire exploitant du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.doman IS 'Domanialité';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.anfinpose IS 'Année marquant la fin de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.andebpose IS 'Année marquant le début de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.insee IS 'Code INSEE';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.observ IS 'Observations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';   
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.qualglocxy IS 'Qualité de la géolocalisation planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.qualglocz IS 'Qualité de la géolocalisation altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.datemaj IS 'Date de la dernière mise à jour des informations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.sourmaj IS 'Source de la mise à jour';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.dategeoloc IS 'Date de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.sourgeoloc IS 'Auteur de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.sourattrib IS 'Auteur de la saisie des données attributaires (lorsque différent de l''auteur de la géolocalisation)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.qualannee IS 'Fiabilité de l''année de pose ou de mise en service';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.mesure IS 'Indication si les paramètres chiffrés (x,y,z ...) sont issus d''un levé (O) ou interpollés (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.fictif IS 'Indique si l''entité est une simple construction topologique (fictive) (O) ou un objet réel du réseau (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.x IS 'Coordonnée X Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.y IS 'Coordonnée Y Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.ztn IS 'Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.zrad IS 'Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.geom IS 'Géométrie ponctuelle de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.idouvrage IS 'Identifiant de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.typreseau IS 'Type du réseau d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.fnouvass IS 'Fonction de l''ouvrage d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.formregass IS 'Forme du regard';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.tampon IS 'Présence d''un tampon (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.grille IS 'Présence d''une grille (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.acces IS 'Regard accessible (O/N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.anomal IS 'Indication de la présence (O) ou l''absence (N) d''anomalie(s)';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_regard.listanomal IS 'Liste d''anomalie(s) du réseau d''eau pluviale';


-- #################################################################### VUE APPAREILLAGE ASSEP ###############################################
        
-- View: m_resh_assep_inv.geo_v_assep_appareil

-- DROP VIEW m_resh_assep_inv.geo_v_assep_appareil;

CREATE OR REPLACE VIEW m_resh_assep_inv.geo_v_assep_appareil AS 
 SELECT 
  a.idassep,
  a.idnoeud,
  a.idappareil,
  r.refassep,  
  r.refope,  
  r.insee,
  a.typreseau,
  a.fnappass,    
  n.x,
  n.y,
  n.ztn,
  n.zrad,
  r.mouvrage,
  r.gexploit,
  r.doman,
  r.anfinpose,
  r.andebpose,
  m.qualannee,
  m.qualglocxy,
  m.qualglocz,
  m.datemaj,
  m.sourmaj,
  m.dategeoloc,
  m.sourgeoloc,
  m.sourattrib,
  m.mesure,
  m.fictif,  
  z.anomal,
  z.listanomal,   
  r.observ,
  r.dbinsert,
  r.dbupdate,     
  n.geom
  
FROM m_resh_assep_inv.an_assep_appareil a
LEFT JOIN m_resh_assep_inv.geo_assep_noeud n ON n.idassep = a.idassep
LEFT JOIN m_resh_assep_inv.an_assep_reseau r ON r.idassep = a.idassep
LEFT JOIN m_resh_assep_inv.an_assep_metadonnees m ON m.idassep = a.idassep
LEFT JOIN m_resh_assep_inv.an_assep_anomalie z ON z.idassep = a.idassep
ORDER BY a.idassep;

COMMENT ON VIEW m_resh_assep_inv.geo_v_assep_appareil
  IS 'Appareillage du réseau d''eau pluviale'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.idassep IS 'Identifiant unique d''objet';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.refassep IS 'Référence producteur de l''entité';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.refope IS 'Référence de l''opération de détection du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.mouvrage IS 'Maître d''ouvrage du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.gexploit IS 'Gestionnaire exploitant du réseau';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.doman IS 'Domanialité';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.anfinpose IS 'Année marquant la fin de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.andebpose IS 'Année marquant le début de la période de mise en service de l''appareillage et/ou de l''ouvrage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.insee IS 'Code INSEE';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.observ IS 'Observations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.dbinsert IS 'Horodatage de l''intégration en base de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.dbupdate IS 'Horodatage de la mise à jour en base de l''objet';   
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.qualglocxy IS 'Qualité de la géolocalisation planimétrique (XY)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.qualglocz IS 'Qualité de la géolocalisation altimétrique (Z)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.datemaj IS 'Date de la dernière mise à jour des informations';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.sourmaj IS 'Source de la mise à jour';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.dategeoloc IS 'Date de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.sourgeoloc IS 'Auteur de la géolocalisation';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.sourattrib IS 'Auteur de la saisie des données attributaires (lorsque différent de l''auteur de la géolocalisation)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.qualannee IS 'Fiabilité de l''année de pose ou de mise en service';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.mesure IS 'Indication si les paramètres chiffrés (x,y,z ...) sont issus d''un levé (O) ou interpollés (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.fictif IS 'Indique si l''entité est une simple construction topologique (fictive) (O) ou un objet réel du réseau (N)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.idnoeud IS 'Identifiant unique de noeud';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.x IS 'Coordonnée X Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.y IS 'Coordonnée Y Lambert 93 (en mètres)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.ztn IS 'Altimétrie du terrain naturel (en mètres, Référentiel NGFIGN69)'; 
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.zrad IS 'Altimétrie de la cote radier (en mètres, Référentiel NGFIGN69)';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.geom IS 'Géométrie ponctuelle de l''objet';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.idappareil IS 'Identifiant de l''appareillage';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.typreseau IS 'Type du réseau d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.fnappass IS 'Fonction de l''appareillage d''assainissement collectif';
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.anomal IS 'Indication de la présence (O) ou l''absence (N) d''anomalie(s)';  
COMMENT ON COLUMN m_resh_assep_inv.geo_v_assep_appareil.listanomal IS 'Liste d''anomalie(s) du réseau d''eau pluviale';



/*
Réseau d'eau pluviale
Elargissement du squelette de la structure afin de gérer les signalements durant la phase d'inventaire du réseau
init_bd_resh_assep_4_signal.sql
PostGIS

GeoCompiegnois - http://geo.compiegnois.fr/
Auteur : Florent Vanhoutte
*/


/* TO DO

- classe signalement

*/




-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                DOMAINES DE VALEURS                                                           ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- **************  typobjres  **************

-- Table: m_resh_assep_inv.lt_assep_typobjres

-- DROP TABLE m_resh_assep_inv.lt_assep_typobjres;

CREATE TABLE m_resh_assep_inv.lt_assep_typobjres
(
  code character varying(50) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_assep_typobjres_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.lt_assep_typobjres
  IS 'Liste du type d''objet de réseau pluvial concerné par un signalement';
COMMENT ON COLUMN m_resh_assep_inv.lt_assep_typobjres.code IS 'Code de la liste énumérée relative au type d''objet de réseau pluvial concerné par un signalement';
COMMENT ON COLUMN m_resh_assep_inv.lt_assep_typobjres.valeur IS 'Valeur de la liste énumérée relative au type d''objet de réseau pluvial concerné par un signalement';

INSERT INTO m_resh_assep_inv.lt_assep_typobjres(
            code, valeur)
    VALUES
('canalisation','Canalisation'),
('reseausurf','Réseau de surface'),
('avaloir','Avaloir'),
('regard','Regard'),
('bassin','Bassin'),
('ouvrage','Autre ouvrage'),
('appareil','Appareillage'),
('noeud','Autre noeud');


-- **************  etatsignal  **************

-- Table: m_resh_assep_inv.lt_assep_etatsignal

-- DROP TABLE m_resh_assep_inv.lt_assep_etatsignal;

CREATE TABLE m_resh_assep_inv.lt_assep_etatsignal
(
  code character varying(50) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_assep_etatsignal_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.lt_assep_etatsignal
  IS 'Liste de l''état de traitement du signalement d''un objet de réseau pluvial';
COMMENT ON COLUMN m_resh_assep_inv.lt_assep_etatsignal.code IS 'Code de la liste énumérée relative à l''état de traitement du signalement d''un objet de réseau pluvial';
COMMENT ON COLUMN m_resh_assep_inv.lt_assep_etatsignal.valeur IS 'Valeur de la liste énumérée relative à l''état de traitement du signalement d''un objet de réseau pluvial';

INSERT INTO m_resh_assep_inv.lt_assep_etatsignal(
            code, valeur)
    VALUES
('01','Nouveau'),
('02','En attente d''un retour du MOA'),
('03','En cours (correction en cours)'),
('04','Fermé (réponse apportée ou correction effectuée)'),
('05','Rejeté (non prise en compte du signalement)');


-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                     SEQUENCE                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################



-- Sequence: m_resh_assep_inv.idsignal_seq
-- DROP SEQUENCE m_resh_assep_inv.idsignal_seq;

CREATE SEQUENCE m_resh_assep_inv.idsignal_seq
  INCREMENT 1
  MINVALUE 0
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

  
  
-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                  CLASSE OBJET                                                                ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################




-- ################################################################ CLASSE SIGNAL  ##############################################

-- Table: m_resh_assep_inv.geo_assep_signal

-- DROP TABLE m_resh_assep_inv.geo_assep_signal;

CREATE TABLE m_resh_assep_inv.geo_assep_signal
(
  idsignal character varying(254) NOT NULL DEFAULT nextval ('m_resh_assep_inv.idsignal_seq'::regclass),
  nom character varying(80),
  date_sai timestamp without time zone NOT NULL DEFAULT now(),
  date_maj timestamp without time zone,
  typobjres character varying(50),
  descript character varying(2000),
  etatsignal character varying(2),
  date_r timestamp without time zone,
  descript_r character varying(5000),   
  geom geometry(Point,2154),
  CONSTRAINT geo_assep_signal_pkey PRIMARY KEY (idsignal)
)
WITH (
  OIDS=FALSE
);

COMMENT ON TABLE m_resh_assep_inv.geo_assep_signal
  IS 'Observations sur l''inventaire du réseau pluvial';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.idsignal IS 'Identifiant unique du signalement';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.nom IS 'Nom du demandeur';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.date_sai IS 'Date de saisie du demandeur';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.date_maj IS 'Date de mise à jour du demandeur';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.typobjres IS 'Type d''objet de réseau concerné par le signalement';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.descript IS 'Description du signalement';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.etatsignal IS 'Etat du traitement du signalement';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.date_r IS 'Date de réponse du répondeur';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.descript_r IS 'Description de la réponse';
COMMENT ON COLUMN m_resh_assep_inv.geo_assep_signal.geom IS 'Géométrie ponctuelle de l''objet';




-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                           FKEY (clé étrangère)                                                               ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ## TYPOBJRES

ALTER TABLE m_resh_assep_inv.geo_assep_signal
               
  ADD CONSTRAINT typobjres_fkey FOREIGN KEY (typobjres)
      REFERENCES m_resh_assep_inv.lt_assep_typobjres (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  ADD CONSTRAINT etatsignal_fkey FOREIGN KEY (etatsignal)
      REFERENCES m_resh_assep_inv.lt_assep_etatsignal (code) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION; 
                     

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        VUES                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################

-- sans objet

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                      TRIGGER                                                                 ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################
           

-- #################################################################### FONCTION TRIGGER - GEO_ASSEP_SIGNAL ###################################################

-- Function: m_resh_assep_inv.ft_m_geo_assep_signal()

-- DROP FUNCTION m_resh_assep_inv.ft_m_geo_assep_signal();

CREATE OR REPLACE FUNCTION m_resh_assep_inv.ft_m_geo_assep_signal()
  RETURNS trigger AS
$BODY$

--déclaration variable pour stocker la séquence des id
DECLARE v_idsignal character varying(254);

BEGIN

-- INSERT
IF (TG_OP = 'INSERT') THEN

NEW.idsignal=nextval('m_resh_assep_inv.idsignal_seq'::regclass);
NEW.date_sai=now();
NEW.etatsignal='01';

RETURN NEW;

-- UPDATE
ELSIF (TG_OP = 'UPDATE') THEN

NEW.idsignal=OLD.idsignal;
NEW.date_sai=OLD.date_sai;
NEW.date_maj=now();

NEW.date_r = CASE WHEN NEW.etatsignal <> OLD.etatsignal THEN now() ELSE null END;

RETURN NEW;

ELSEIF (TG_OP = 'DELETE') THEN

UPDATE m_resh_assep_inv.geo_assep_signal
SET 
nom = OLD.nom, date_sai=OLD.date_sai, date_maj=now(), typobjres = OLD.typobjres,descript = OLD.descript, etatsignal = OLD.etatsignal,geom = OLD.geom, date_r = OLD.date_r, descript_r = OLD.descript_r WHERE idsignal =OLD.idsignal;



RETURN NEW;

END IF;




END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

COMMENT ON FUNCTION m_resh_assep_inv.ft_m_geo_assep_signal() IS 'Fonction trigger pour mise à jour des signalements sur l''inventaire du réseau pluvial';


-- Trigger: t_t1_geo_signal on m_resh_assep_inv.geo_assep_signal

-- DROP TRIGGER t_t1_geo_signal ON m_resh_assep_inv.geo_assep_signal;

CREATE TRIGGER t_t1_geo_assep_signal
  BEFORE INSERT OR UPDATE
  ON m_resh_assep_inv.geo_assep_signal
  FOR EACH ROW
  EXECUTE PROCEDURE m_resh_assep_inv.ft_m_geo_assep_signal();           
 
