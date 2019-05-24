CREATE TABLE pays
(
	id SERIAL PRIMARY KEY,
	abreviation varchar(20) UNIQUE NOT NULL,
	nom varchar(50) NOT NULL
);

CREATE TABLE contacts
(
	id SERIAL PRIMARY KEY,
	prenom varchar(50) NOT NULL,
	nom varchar(50) NOT NULL,
	email varchar(50) NOT NULL,
	pays int REFERENCES pays(id),
	UNIQUE(prenom, nom)
);

CREATE UNIQUE INDEX contacts_prenom_nom_index ON contacts (prenom, nom);

CREATE TABLE tags
(
	id SERIAL PRIMARY KEY,
	tag varchar(50) NOT NULL,
	UNIQUE(tag)
);

CREATE TABLE contacts_tags
(
	id SERIAL PRIMARY KEY ,
	contact INTEGER NOT NULL REFERENCES contacts(id) ON UPDATE CASCADE ON DELETE CASCADE,
	tag INTEGER NOT NULL REFERENCES tags(id) ON UPDATE CASCADE ON DELETE CASCADE,
	UNIQUE(contact,tag)
);

INSERT INTO pays(abreviation,nom) VALUES ('US', 'Etats-Unis');

INSERT INTO contacts (prenom,nom,email) VALUES('Betty','Boop','betty.boop@hollywood.com');
INSERT INTO contacts (prenom,nom,email) VALUES('Jessica','Rabbit','jessica.rabbit@hollywood.com');
UPDATE contacts SET pays = ( SELECT MIN(id) FROM pays WHERE abreviation = 'US' );

INSERT INTO contacts (prenom,nom,email) VALUES('Sally','Jupiter','SilkSpectre@watchmen.com');

INSERT INTO tags(tag) VALUES('sex-symbol');
INSERT INTO tags(tag) VALUES('vamp');

INSERT INTO contacts_tags(contact, tag) 
	SELECT contacts.id, tags.id
	FROM contacts CROSS JOIN tags
	WHERE contacts.pays IS NOT NULL;




