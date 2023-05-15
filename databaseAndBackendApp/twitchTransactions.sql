-- ***********************
-- Create (INSERT) Queries
-- ***********************

-- addOrUpdateAbout
-- What it does: inserts row into about table
SELECT * FROM about; 
INSERT INTO about (id, name, bio, followCount, socialLink, pannel) VALUES 
(2, 'aceu', 'bowl', 2300000, null, null)
on duplicate key update name=values(name), bio=values(bio), followCount=values(followCount), 
socialLink=values(socialLink), pannel=values(pannel);
SELECT * FROM about; 

-- addOrUpdateCategory
-- What it does: updates category table row
SELECT * FROM category;
INSERT INTO category (id, title, description) VALUES 
(1, 'Games', 'Live streams of all your favorite games, from shooters to platformers and everything in between.')
on duplicate key update title=values(title), description=values(description);
SELECT * FROM category;

-- addOrUpdateLive
-- What it does: insert row into live table
SELECT * FROM live;
INSERT INTO live (id, title, name, viewLive, display, time, follow, subscribe) VALUES
(2, 'NRG aceu // ringing // !socials', 'Aceu', 11084, 'OBS Studios', '2022-03-11 5:14:32', '1', '1')
on duplicate key update title=values(title), name=values(name), viewLive=(viewLive),
display=values(display), time=values(time), follow=values(follow), subscribe=values(subscribe);
SELECT * FROM live;

-- addOrUpdateChannel
-- What it does: updates channel table row
SELECT * FROM channel;
INSERT INTO channel (id, name, followCount, verification, avatar, follow, subscribe, liveId, aboutId) VALUES
(1, 'SEN ShahZaM', 1358000, '1', 'ShahzamNew.jpg', '1', '1', 1, 1)
on duplicate key update name=values(name), followCount=values(followCount), verification=values(verification), 
avatar=values(avatar), follow=values(follow), subscribe=values(subscribe), liveId=values(liveId), aboutId=values(aboutId);
SELECT * FROM channel;

-- addOrUpdateLiveCategory
-- What it does: insert row into live-category table
SELECT * FROM `live-category`;
INSERT INTO `live-category` (liveId, categoryId)
VALUES (2, 1);
SELECT * FROM `live-category`;

-- addOrUpdateChat
-- What it does: insert row into chat table
SELECT * FROM chat;
INSERT INTO chat (id, name, message, badge, settings, liveId) VALUES 
(2,'kyoshi', 'POGU POGU', null, null, 1)
on duplicate key update name=values(name), message=values(message), badge=values(badge), 
settings=values(settings), liveId=values(liveId);
SELECT * FROM chat;

-- addOrUpdateTag
-- What it does: inserts row into tag table
SELECT * FROM tag;
INSERT INTO tag (id, name, liveId) VALUES 
(2, "RPG", 2)
on duplicate key update name=values(name), liveId=values(liveId);
SELECT * FROM tag;

-- *************************
-- Retireve (SELECT) Queries
-- *************************

-- getCategorythatsLive
SELECT live.*
FROM live
JOIN `live-category` ON `live-category`.liveId = live.id
JOIN category ON `live-category`.categoryId = category.id
WHERE category.id = 1;


-- getChatNameandMessage
SELECT name, message
FROM chat
WHERE id = 2;

-- getAboutnameandbio
SELECT name, bio
FROM about
Where id = 1;


-- *****************
-- Update Queries
-- *****************

-- update chat name
SELECT * FROM chat;
update chat set name = "AngelXX" where id = 1;
SELECT * FROM chat;

-- updateChannelAvatar
SELECT * FROM channel;
update channel set avatar = "betterPic.jpg" where id = 1;
SELECT * FROM channel;


-- *****************
-- Delete Queries
-- *****************

-- deleteLiveCategory
-- What it does: Delete a live-category row
SELECT * FROM `live-category`;
delete from `live-category` where categoryId = 1;
SELECT * FROM `live-category`;

-- deleteTopicTag
-- What it does: Delete a topic-video row
SELECT * FROM `topic-tag`;
delete from `topic-tag` where tagId = 1;
SELECT * FROM `topic-tag`;

-- deleteTag
-- What it does: Delete a tag row
SELECT * FROM tag;
delete from tag where id = 1;
SELECT * FROM tag;

