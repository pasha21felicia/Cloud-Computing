-- SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
-- SET @@SESSION.SQL_LOG_BIN= 0;
--
-- --
-- GTID state at the beginning of the backup 
--

-- SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `articles`
--

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `email` varchar(120) NOT NULL,
  `image_file` varchar(200) NOT NULL,
  `password` varchar(60) NOT NULL,
  `role` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'testuser','testuser@gmail.com','https://cdn-icons-png.flaticon.com/512/327/327525.png?w=996&t=st=1679595871~exp=1679596471~hmac=fcfe9be5455cb34e8f64d9bcb54203068be2e04a0c32051e6b30acad6b7d9e05','$2b$12$HLoB.kqiRmjxFuBPS2NCfOEVp4CvnGZdwkOGUS.MUMwAoAf6p6Bzy',0),(2,'pasha','pasha@gmail.com','https://cdn-icons-png.flaticon.com/512/327/327525.png?w=996&t=st=1679595871~exp=1679596471~hmac=fcfe9be5455cb34e8f64d9bcb54203068be2e04a0c32051e6b30acad6b7d9e05','$2b$12$AiB9QcftrgQcY8eiR5kVYehHnpN9JBVK80uZEnqcAHu/CPyfej60a',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `body` text,
  `category` varchar(60) DEFAULT NULL,
  `image_url` varchar(200) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `articles`
--

LOCK TABLES `articles` WRITE;
/*!40000 ALTER TABLE `articles` DISABLE KEYS */;
INSERT INTO `articles` VALUES (1,'US thinks UN chief too accommodating to Moscow, leaked files suggest','The US believes the UN Secretary General is too willing to accommodate Russian interests, according to fresh revelations in classified documents leaked online.','Politics','https://ichef.bbci.co.uk/news/976/cpsprodpb/161C4/production/_129346509_gutafp.jpg.webp','2023-04-14 14:51:40',1),(2,'UPDATE US thinks UN chief too accommodating to Moscow, leaked files suggest','UPDATE The US believes the UN Secretary General is too willing to accommodate Russian interests, according to fresh revelations in classified documents leaked online.','Politics','https://ichef.bbci.co.uk/news/976/cpsprodpb/161C4/production/_129346509_gutafp.jpg.webp','2023-04-14 15:29:31',1),(3,'article3 US thinks UN chief too accommodating to Moscow, leaked files suggest','UPDATE The US believes the UN Secretary General is too willing to accommodate Russian interests, according to fresh revelations in classified documents leaked online.','Politics','https://ichef.bbci.co.uk/news/976/cpsprodpb/161C4/production/_129346509_gutafp.jpg.webp','2023-04-14 15:35:21',1),(4,'What are the best lucid dreaming techniques?','I\nI first heard about lucid dreaming as a teenager, and for a short while became fascinated with it. The idea of being conscious in your dreams, and even being able to direct and adapt them, holds an obvious appeal. Ever wanted to fly? Walk through walls? Meet a famous person? Anything could be possible in a lucid dream – in theory at least.\n\nLucid dreaming simply means a dream where you\'re aware that you\'re dreaming, while you are still asleep. There is of course a huge spectrum of what can occur in the dream within this definition – from a fleeting, passive awareness you are in a dream to taking full control of the dream and being able to direct it.\n\nIn research at sleep laboratories, if people are capable of signalling with eye movements while clearly in rapid eye movement (REM) sleep, then \"generally we agree that they were lucid dreaming\", says Karen Konkoly, a PhD researcher in psychology at Northwestern University in Illinois. (REM is the phase of sleep where regular dreaming occurs.)\n\nIt\'s a very unique state of consciousness with unique properties – Karen Konkoly\nWhile some people experience lucid dreaming spontaneously, for others it only occurs after an external stimulus (such as having a conversation, watching a video or reading an article about lucid dreaming), or sometimes after a lot of hard work trying to achieve one.\n\n\"There are people who can learn [to do it] within days and other people need three months,\" says Michael Schredl, a researcher at the sleep laboratory in the Central Institute of Mental Health in Mannheim, Germany. \"I, for example, trained almost three months before getting lucid dreams. So it\'s a very, very strong variation between persons.\"\n\nStudies have found that the main motivation for lucid dreaming is simply to have fun or fulfil wishes – whether that be by flying or having sex. But many people also use lucid dreaming to help manage nightmares or bad dreams, solve problems, explore creative ideas or insights, or practise skills.\n\nSome research has found that participants who practise simple motor skills in their lucid dreams – such as finger-tapping – significantly improve in their ability during waking life compared with control groups. One study found that people who clenched their hands during lucid dreams showed activation in the same motor cortex areas as in the waking state. It has even been suggested that lucid dreaming could be used to treat serious psychological disorders such as clinical depression and PTSD.\n\nHowever some of the techniques used to lucid dream may not be a good idea for people with certain mental health conditions, such as presentations of schizophrenia where people are struggling to tell the difference between fantasy and reality, notes Denholm Aspy, a visiting research fellow in psychology at the University of Adelaide in Australia.\n\nAfter first hearing about lucid dreaming in the early 2000s, I started to keep a dream diary and soon had my first lucid dream. It was a pretty mundane affair. I was walking down a street near my school and bumped into a friend who I stopped to chat to.\n\nFor some reason, this conversation had a sheen of unreality to it, triggering the realisation I was in a dream. I proceeded to shout that fact gleefully at my friend then immediately jumped into the air to begin flying, the classmate waving after me in bemusement. Shortly after I lost the dream.\n\nOver the years I\'ve had a handful more lucid dreams, often prompted by conversions or media about lucid dreaming (in particular after watching the film Waking Life, a hazy, digitally rotoscoped film about a man who realises he is trapped in a dream).\n\nIt puts me somewhere in the average of the population when it comes to experiencing lucid dreaming. In a 1998 survey of the dream behaviour of 1,000 Austrians, 26% reported sometimes having lucid dreams. A 2011 survey of 900 German adults found half of them reported ever having had a lucid dream, and it was more common among women and younger people. A 2016 meta-analysis (a study pulling together and assessing multiple other studies) had similar results.','Social','https://ychef.files.bbci.co.uk/1600x900/p0fg2q85.webp','2023-04-14 16:07:22',2),(5,'John Wick, Close, EO: Eight of the best films of 2023 so far','This tough-minded, heart-breaking drama about race, class and motherhood was France\'s entry to last year\'s Oscar race, and I\'m still mystified as to why it wasn\'t nominated. Alice Diop puts her experience making documentaries to good use, as she bases her story on the real-life case of a young Senegalese woman in France charged with abandoning her baby on a beach to die. Diop invents Rama, a pregnant novelist who goes to the town of Saint Omer to witness the trial, which plays into her own doubts and fears. As Laurence, the mother on trial, Guslagie Malanda is unnaturally calm, almost frozen in resignation. Kayije Kagame as Rama lets you see her mind racing and her heart pounding as she watches, even though her face is impassive. Diop based her dialogue on court transcripts, but the results go far beyond dry facts on the page to create an enthralling film with two profound and vivid women on screen. (CJ)','Politics','https://ychef.files.bbci.co.uk/1600x900/p0dz3pth.webp','2023-04-14 16:08:24',2);
/*!40000 ALTER TABLE `articles` ENABLE KEYS */;
UNLOCK TABLES;

