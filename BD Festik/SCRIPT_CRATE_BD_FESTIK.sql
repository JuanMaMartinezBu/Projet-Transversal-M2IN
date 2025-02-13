#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: STRUCTURE
#------------------------------------------------------------

CREATE TABLE STRUCTURE(
        ID_STRUCTURE           Int  Auto_increment  NOT NULL ,
        NOM_STRUCTURE          Varchar (255) NOT NULL ,
        TYPE_STRUCTURE         Varchar (255) NOT NULL COMMENT "PUBLIQUE OU PRIVEE"  ,
        MAIL_STRUCTURE         Varchar (255) NOT NULL ,
        TELEPHONE_STRUCTURE    Varchar (255) NOT NULL ,
        VILLE                  Varchar (255) NOT NULL ,
        ADRESSE                Varchar (255) NOT NULL ,
        CODE_POSTALE           Varchar (255) NOT NULL ,
        TAILLE_STRUCTURE       Int NOT NULL ,
        CHIFFRE_AFFAIRE_ANNUEL Int NOT NULL ,
        SIRET                  Varchar (255) ,
        VALEURS                Varchar (255) NOT NULL COMMENT "OUI OU NON"  ,
        MODE_COMMUNICATION     Varchar (255) NOT NULL COMMENT "Téléphone, SMS, Mail, Téléphone + SMS, Téléphone + Mail, Mail + SMS, N'importe."  ,
        COMMENTAIRES           Text NOT NULL
	,CONSTRAINT STRUCTURE_PK PRIMARY KEY (ID_STRUCTURE)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: CONTACT
#------------------------------------------------------------

CREATE TABLE CONTACT(
        ID_CONTACT        Int  Auto_increment  NOT NULL ,
        PRENOM_CONTACT    Varchar (255) NOT NULL ,
        NOM_CONTACT       Varchar (255) NOT NULL ,
        MAIL_CONTACT      Varchar (255) NOT NULL ,
        TELEPHONE_CONTACT Varchar (255) NOT NULL
	,CONSTRAINT CONTACT_PK PRIMARY KEY (ID_CONTACT)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: EVENEMENT
#------------------------------------------------------------

CREATE TABLE EVENEMENT(
        ID_EVENEMENT   Int  Auto_increment  NOT NULL ,
        TYPE_EVENEMENT Varchar (255) NOT NULL ,
        NOM_EVENEMENT  Varchar (255) NOT NULL ,
        DATE_DEBUT     Date NOT NULL ,
        DATE_FIN       Date NOT NULL ,
        LIEU_EVENEMENT Varchar (255) NOT NULL ,
        JAUGE          Int NOT NULL ,
        ID_STRUCTURE   Int NOT NULL
	,CONSTRAINT EVENEMENT_PK PRIMARY KEY (ID_EVENEMENT)

	,CONSTRAINT EVENEMENT_STRUCTURE_FK FOREIGN KEY (ID_STRUCTURE) REFERENCES STRUCTURE(ID_STRUCTURE)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: FESTIK
#------------------------------------------------------------

CREATE TABLE FESTIK(
        ID_EMPLOYE Int  Auto_increment  NOT NULL ,
        PRENOM     Varchar (255) NOT NULL ,
        NOM        Varchar (255) NOT NULL ,
        POSTE      Varchar (255) NOT NULL
	,CONSTRAINT FESTIK_PK PRIMARY KEY (ID_EMPLOYE)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: SECTEUR
#------------------------------------------------------------

CREATE TABLE SECTEUR(
        SECTEUR Varchar (255) NOT NULL
	,CONSTRAINT SECTEUR_PK PRIMARY KEY (SECTEUR)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: REPRESENTE
#------------------------------------------------------------

CREATE TABLE REPRESENTE(
        ID_STRUCTURE Int NOT NULL ,
        ID_CONTACT   Int NOT NULL ,
        ROLE_CONTACT Varchar (255) NOT NULL COMMENT "Au moment de rajouter un rôle, il faut poser un affichage les contacts avec les mêmes ròles et proposer que ses mêmes contacts soit supprimés ou gardés (avertissement)" 
	,CONSTRAINT REPRESENTE_PK PRIMARY KEY (ID_STRUCTURE,ID_CONTACT)

	,CONSTRAINT REPRESENTE_STRUCTURE_FK FOREIGN KEY (ID_STRUCTURE) REFERENCES STRUCTURE(ID_STRUCTURE)
	,CONSTRAINT REPRESENTE_CONTACT0_FK FOREIGN KEY (ID_CONTACT) REFERENCES CONTACT(ID_CONTACT)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: INTERACTION
#------------------------------------------------------------

CREATE TABLE INTERACTION(
        ID_CONTACT               Int NOT NULL ,
        ID_EMPLOYE               Int NOT NULL ,
        ID_EVENEMENT             Int NOT NULL ,
        DATE_CONTACT             Date NOT NULL ,
        DATE_PROCHAIN_CONTACT    Date ,
        STATUT_CONTACT           Varchar (255) NOT NULL COMMENT "PRIORITE=1-5"  ,
        COMMENTAIRES_INTERACTION Text NOT NULL ,
        MODE_COMMUNICATION       Varchar (255) NOT NULL ,
        STATUT_INTERACTION       Varchar (255) NOT NULL COMMENT "Nouveau. en contact, abandon, prospect, opportunité ouverte, en negociation, client ou ancien clien"  ,
        DATE_CHANGEMENT_STATUT   Datetime NOT NULL COMMENT "La date qui permet de voir la date du changement du statut. Par defaut est la date du jour oú il y a la modification." 
	,CONSTRAINT INTERACTION_PK PRIMARY KEY (ID_CONTACT,ID_EMPLOYE,ID_EVENEMENT)

	,CONSTRAINT INTERACTION_CONTACT_FK FOREIGN KEY (ID_CONTACT) REFERENCES CONTACT(ID_CONTACT)
	,CONSTRAINT INTERACTION_FESTIK0_FK FOREIGN KEY (ID_EMPLOYE) REFERENCES FESTIK(ID_EMPLOYE)
	,CONSTRAINT INTERACTION_EVENEMENT1_FK FOREIGN KEY (ID_EVENEMENT) REFERENCES EVENEMENT(ID_EVENEMENT)
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: SPECIALISEE
#------------------------------------------------------------

CREATE TABLE SPECIALISEE(
        SECTEUR      Varchar (255) NOT NULL ,
        ID_STRUCTURE Int NOT NULL
	,CONSTRAINT SPECIALISEE_PK PRIMARY KEY (SECTEUR,ID_STRUCTURE)

	,CONSTRAINT SPECIALISEE_SECTEUR_FK FOREIGN KEY (SECTEUR) REFERENCES SECTEUR(SECTEUR)
	,CONSTRAINT SPECIALISEE_STRUCTURE0_FK FOREIGN KEY (ID_STRUCTURE) REFERENCES STRUCTURE(ID_STRUCTURE)
)ENGINE=InnoDB;

