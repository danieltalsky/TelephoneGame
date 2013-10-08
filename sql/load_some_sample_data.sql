INSERT INTO artists (artistName, artistBio, artistContact, artistURL)
VALUES  ("Your mom", "your mom is so awesome", "your@mom.com", "http://yourmom.com");

INSERT INTO works (artistRef, workTitle, workType) 
VALUES (1, "The Amazing Mom Brush", "painting");
INSERT INTO works (artistRef, workTitle, workType) 
VALUES (1, "What's so good about a mom", "painting");

INSERT INTO workRepresentations (workRef, fileName, additionalInformation, isPrimaryViewForWork)
VALUES (1, "01_ArtistName_WorkName.jpg", "Left View", 1);
INSERT INTO workRepresentations (workRef, fileName, additionalInformation, isPrimaryViewForWork)
VALUES (1, "02_ArtistName_WorkName.jpg", "Front View", 0);

SELECT * FROM 
  
  artists 
  
  INNER JOIN 
    works ON 
      artists.artistId = works.artistRef
  LEFT OUTER JOIN 
    workRepresentations ON 
      works.workId = workRepresentations.workRef
  ;