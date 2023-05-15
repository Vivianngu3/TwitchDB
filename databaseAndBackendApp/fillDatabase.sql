-- ************************************
-- Delete tables 
-- ************************************
DELETE FROM `topic-video`;
DELETE FROM `topic-tag`;
DELETE FROM `live-category`;
DELETE FROM `category-topic`;
DELETE FROM video;
DELETE FROM schedule;
DELETE FROM topic;
DELETE FROM channel;
DELETE FROM chat;
DELETE FROM tag;
DELETE FROM category;
DELETE FROM about;
DELETE FROM live;

-- ************************************
-- INSERT DATA No foreign keys 
-- ************************************

-- about table

INSERT INTO about (id, name, bio, followCount, socialLink, pannel) VALUES 
(1, 'ShahZaM', 'Professional CS:GO & Valorant player', 1300000, 
'[{"media":"Twitter", "logo":"twitter.jpg", "link":"twitter.com"},{"media":"Instagram","logo": "instagram.jpg", "link":"instagram.com"},{"media":"Youtube", "logo":"youtube.jpg", "link":"youtube.com"}]',
'[{"name":"Donate", "pannelImage":"donate.jpg", "link":"https://streamlabs.com/shahzam/tip", "description":"You do not have to donate"},
{"name":"Settings", "pannelImage":"settings.jpg","link":"null","description":"Resolution: 1024X768"}]');
SELECT * FROM about;

-- category table

INSERT INTO category (id, title, description) VALUES (1, 'Games', 'Live streams of the top games');
SELECT * FROM category;

-- live table

INSERT INTO live (id, title, name, viewLive, display, time, follow, subscribe) VALUES
(1, 'Ranked Valorant', 'ShahZam', 12000, 'OBS Studios', '2022-02-04 10:14:32', '1', '1');
SELECT * FROM live;

-- ************************************
-- One-Many chain 
-- ************************************

-- channel table

INSERT INTO channel (id, name, followCount, verification, avatar, follow, subscribe, liveId, aboutId) VALUES
(1, 'ShahZaM', 1300000, '1', 'Shahzam.jpg', '0', '1', 1, 1);
SELECT * FROM channel;
-- schedule table

INSERT INTO schedule (id, title, date, channelId) VALUES (1, 'ShahZaM is live!', '2022-02-04 10:14:32', 1);
SELECT * FROM schedule;

-- chat table

INSERT INTO chat (id, name, message, badge, settings, liveId) VALUES (1,'xXANGELXx', 'WOW! Good shot!',
'[{"name":"Prime", "tier":"1"}, {"name":"Subscriber","tier":"2"}]',
'[{"name": "setting1","value":"value1"},{"name":"setting2","value":"value2"},{"name":"setting3","value":"value3"}]', 1);
SELECT * FROM chat;

-- video table

INSERT INTO video (id, name, title, thumbnail, view, dateTime, length, channelId, scheduleId) VALUES 
(1, 'ShahZaM', 'Radiant Ranked', 'VideoClip.jpg', 10000, '2022-02-04 10:14:32', '12', 1, 1);
SELECT * FROM video;

-- topic table

INSERT INTO topic (id, title, description, followCount, viewLive, cover, follow, channelId) VALUES 
(1, 'Valorant',
'VALORANT is a character-based 5v5 tactical shooter set on the global stage. Outwit, outplay, and outshine your competition with tactical abilities, precise gunplay, and adaptive teamwork.',
12000000, 99700, 'valorantCover.jpg', '1', 1),
(2, 'Teamfight Tactics', 
'Teamfight Tactics is a round-based strategy game that pits you against seven opponents in a free-for-all race to build a powerful team that fights on your behalf. Your goal: Be the last person standing.',
2300000, 14100, 'tftCover.jpg', '1', 1),
(3, 'League of Legends',
'League of Legends is a fast-paced, competitive team-based online game that blends the speed and intensity of an RTS with RPG elements.', 
32000000, 97000, 'LoLCover.jpg', '1', 1)
;
SELECT * FROM topic;

-- tag table

INSERT INTO tag (id, name, liveId) VALUES (1, "FPS", 1);
SELECT * FROM tag;

-- ************************************
-- two foreign keys 
-- ************************************

-- category-topic table

INSERT INTO `category-topic` (categoryId, topicId, follow, subscribe) VALUES (1, 1, '0', '0');
SELECT * FROM `category-topic`;

-- live-category table

INSERT INTO `live-category` (liveId, categoryId) VALUES (1, 1);
SELECT * FROM `live-category`;


-- topic-tag table

INSERT INTO `topic-tag` (topicId, tagId, follow, subscribe) VALUES (1, 1, '0', '0');
SELECT * FROM `topic-tag`;

-- topic-video table

INSERT INTO `topic-video` (topicId, videoId, follow, subscribe) VALUES (1, 1, '0', '0');
SELECT * FROM `topic-video`;