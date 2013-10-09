-- CREATE DATABASE telephoneGame

CREATE TABLE artists (
  artistId SERIAL PRIMARY KEY, /* this is the way you do autoincrement in pg */
  artistName TEXT, /* varchar and text are the same under the hood in postgres */
  artistContact TEXT, /* with TEXT you don't have to worry about the size */
  artistBio TEXT,
  artistURL TEXT,
  artistLocation TEXT,
);

CREATE TABLE works (
  workId SERIAL PRIMARY KEY,
  parentWorkRef INTEGER, /* same as SERIAL type */
  artistRef INTEGER,
  workTitle TEXT,
  workType TEXT,
  
  INDEX works_parentWorkRef_ind (parentWorkRef), 
  
  FOREIGN KEY (parentWorkRef) 
    REFERENCES works(workId),  
  
  INDEX works_ArtistId_ind (artistRef), 
  
  FOREIGN KEY (artistRef) 
    REFERENCES artists(artistId)
    ON DELETE CASCADE,
);

CREATE TABLE workRepresentations (
  workRepresentationId SERIAL PRIMARY KEY,
  workRef INTEGER,
  fileName TEXT,
  description TEXT,
  fileType TEXT,
  isPrimaryViewForWork BOOLEAN,
 
  INDEX workRepresentations_workRef_ind (workRef),
  
  FOREIGN KEY (workRef) 
    REFERENCES works(workId)
    ON DELETE CASCADE,  
);