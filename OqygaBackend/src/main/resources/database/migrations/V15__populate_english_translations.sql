-- ==========================================
-- 1. UPDATE CATEGORIES
-- ==========================================
UPDATE categories SET category_name_en = 'Cinema' WHERE category_id = 1;
UPDATE categories SET category_name_en = 'Theatres' WHERE category_id = 2;
UPDATE categories SET category_name_en = 'Concerts' WHERE category_id = 3;
UPDATE categories SET category_name_en = 'Stand Up' WHERE category_id = 4;
UPDATE categories SET category_name_en = 'Sport' WHERE category_id = 5;
UPDATE categories SET category_name_en = 'Business Forums' WHERE category_id = 6;
UPDATE categories SET category_name_en = 'Exhibitions' WHERE category_id = 7;
UPDATE categories SET category_name_en = 'Master Classes' WHERE category_id = 8;
UPDATE categories SET category_name_en = 'For Kids' WHERE category_id = 9;
UPDATE categories SET category_name_en = 'Entertainment' WHERE category_id = 10;

-- ==========================================
-- 2. UPDATE CITIES
-- ==========================================
UPDATE cities SET city_name_en = 'Astana' WHERE city_id = 1;
UPDATE cities SET city_name_en = 'Almaty' WHERE city_id = 2;
UPDATE cities SET city_name_en = 'Aktobe' WHERE city_id = 3;
UPDATE cities SET city_name_en = 'Aktau' WHERE city_id = 4;
UPDATE cities SET city_name_en = 'Karaganda' WHERE city_id = 5;
UPDATE cities SET city_name_en = 'Kokshetau' WHERE city_id = 6;
UPDATE cities SET city_name_en = 'Kostanay' WHERE city_id = 7;
UPDATE cities SET city_name_en = 'Pavlodar' WHERE city_id = 8;
UPDATE cities SET city_name_en = 'Semey' WHERE city_id = 9;
UPDATE cities SET city_name_en = 'Tashkent' WHERE city_id = 10;
UPDATE cities SET city_name_en = 'Taraz' WHERE city_id = 11;
UPDATE cities SET city_name_en = 'Taldykorgan' WHERE city_id = 12;
UPDATE cities SET city_name_en = 'Shymkent' WHERE city_id = 13;
UPDATE cities SET city_name_en = 'Ust-Kamenogorsk' WHERE city_id = 14;

-- ==========================================
-- 3. UPDATE EVENTS
-- ==========================================

-- 78: AI Conf 2025
UPDATE events
SET event_name_en = 'AI Conf 2025 Dushanbe',
    event_place_en = 'Crowne Plaza Hotel, Dushanbe EXPO',
    description_en = 'The future of artificial intelligence is not just being discussed, it is being created here and now! A global dialogue on AI featuring innovators, policymakers, and industry leaders from over 30 countries. (Location: Dushanbe).'
WHERE event_id = 78;

-- 40: Moldanazar
UPDATE events
SET event_name_en = 'MOLDANAZAR Solo Concert',
    event_place_en = 'Roza Baglanova Kazakh Concert Hall, Mangilik Yel Ave, 10/1',
    description_en = 'On November 22, a unique concert by the band Moldanazar will take place in a new format at the Roza Baglanova Kazakh Concert Hall. For the first time, beloved hits will be performed with a symphony orchestra, giving them special depth and scale. The audience can expect a unique combination of synth-pop, indie-rock, and original style. Soulful compositions like Ozin gana, Alystama, Aqpen Birge, and many others will be performed.'
WHERE event_id = 40;

-- 41: Zoloto
UPDATE events
SET event_name_en = 'Zoloto in Astana',
    event_place_en = 'Congress Center',
    description_en = 'ZOLOTO is the solo project of Vladimir Zolotukhin, an author, frontman, and multi-instrumentalist performing "fashionable pop" with a timeless, nostalgic sound. His music combines indie-pop with disco elements and nostalgic references to the pop culture of the 90s and 00s. The band includes experienced musicians: German Tigay (bass), Daniil Morozov (drums), and Igor Gribov (guitar/keys). ZOLOTO has four albums, including the latest "Reincarnate" (2024).'
WHERE event_id = 41;

-- 49: Alexey Kvashonkin
UPDATE events
SET event_name_en = 'Alexey Kvashonkin Solo Stand-up',
    event_place_en = 'Harat''s Pub (Astana)',
    description_en = 'Alexey Kvashonkin is one of the brightest representatives of Russian stand-up comedy, known for his cynical and ironic style. His performances are characterized by sharpness, relevance, and genuine self-irony. In his program, Alexey will raise vital topics close to everyone. An evening of pure, unfiltered humor awaits you.'
WHERE event_id = 49;

-- 42: Diana Arbenina
UPDATE events
SET event_name_en = 'Diana Arbenina in Karaganda',
    event_place_en = 'S. Sapiyev Boxing Center',
    description_en = 'A long-awaited return! On November 7, 2025, Diana Arbenina and the "Night Snipers" band will take the stage at the S. Sapiyev Boxing Center in Karaganda. Fans can expect an evening of real rock and roll, filled with incredible energy and poignant lyrics. Both legendary hits and new compositions will be performed.'
WHERE event_id = 42;

-- 43: SATs Gastronomy
UPDATE events
SET event_name_en = '"SATS" Tour',
    event_place_en = 'N. Nazarbayev Ave, 19/1, Stanislavsky Russian Drama Theatre',
    description_en = '"SATS" is a reconstruction play based on real events. On November 7, 1945, in Alma-Ata, only one hour remains before the opening of the first theatre for children and youth in Kazakhstan. A rehearsal of Evgeny Schwartz''s fairy tale "Little Red Riding Hood" is underway on stage; director Natalya Ilyinichna Sats is preparing actors for the premiere. In this production, great figures of the past come to life. "SATS" is a play about a legendary time, the power of art, and a woman whose name became a symbol of children''s theatre worldwide.'
WHERE event_id = 43;

-- 44: Hans Zimmer
UPDATE events
SET event_name_en = 'The Universe of Hans Zimmer',
    event_place_en = 'I. Zhansugurov Palace of Culture',
    description_en = 'More than 30 musicians of the orchestra and choir will perform the music of one of the most famous and influential film composers of our time - Hans Zimmer. The program includes music from: Dune 1 & 2, Interstellar, Batman, Gladiator, Inception, Kung Fu Panda, Pirates of the Caribbean, The Lion King, Sherlock Holmes, Madagascar, Pearl Harbor, The Last Samurai, Man of Steel, Call of Duty.'
WHERE event_id = 44;

-- 45: DO-DES-KA-DEN
UPDATE events
SET event_name_en = 'DO-DES-KA-DEN',
    event_place_en = 'Shakhmet Kusayinov Regional Kazakh Music and Drama Theatre',
    description_en = '"DO-DES-KA-DEN" is a deep work based on various destinies. This piece is staged for the first time in the theatre based on the screenplay by famous Japanese film director Akira Kurosawa. The performance conveys not only social issues but also human nature, the power of dreams and imagination, and the inner drama of wounded souls. Please note that this performance is staged in a chamber theatre format.'
WHERE event_id = 45;

-- 46: Sevak Khanagyan
UPDATE events
SET event_name_en = 'Sevak Khanagyan in Astana',
    event_place_en = 'Rixos President Astana Hotel',
    description_en = 'Sevak Khanagyan is an Armenian and Russian singer, songwriter, winner of the "Main Stage" show, participant of "The Voice", mentor of "The Voice of Armenia" and winner of "X-Factor-7". Sevak''s songs are permeated with deep emotions and lyrics that resonate in the hearts of listeners. A sensual evening awaits the audience, filled with beloved hits like "Don''t be silent", "When we are together", and new compositions.'
WHERE event_id = 46;

-- 47: Football Match
UPDATE events
SET event_name_en = 'FC Astana - FC Aktobe',
    event_place_en = 'Astana Arena',
    description_en = 'Football match between "Astana" and "Aktobe" teams within the framework of the Kazakhstan Championship. We are waiting for an exciting meeting of two strongest clubs that will demonstrate their skills and will to win. Come to support your favorite team and enjoy the atmosphere of a real football holiday.'
WHERE event_id = 47;

-- 48: Alma-Ata 89
UPDATE events
SET event_name_en = '"Alma-Ata 89"',
    event_place_en = 'ARTiSHOCK Theatre',
    description_en = 'The play "Alma-Ata 89" at the ARTiSHOCK Theatre is an attempt to reconstruct and comprehend the events of 1989. The production is a reflection on a turning point in history, on the fates of people, and on how the past influences the present. The audience awaits a deep immersion into the atmosphere of that time through the acting and unique set design.'
WHERE event_id = 48;

-- 50: Notre Dame
UPDATE events
SET event_name_en = 'Notre Dame de Paris',
    event_place_en = 'Astana Opera',
    description_en = 'Ballet in two acts based on the novel by Victor Hugo. This work is an immortal story about love, beauty and ugliness, compassion and cruelty. The choreography conveys all the dramatic power of the novel, and the sets and costumes immerse you in the atmosphere of medieval Paris. Leading soloists of the Astana Opera theatre will perform on stage.'
WHERE event_id = 50;

-- 51: AStudio
UPDATE events
SET event_name_en = 'A''Studio in Almaty',
    event_place_en = 'Palace of the Republic',
    description_en = 'The main musical event of the autumn! The legendary group A''STUDIO is back in Almaty! On November 7, 2025, beloved hits that conquered the hearts of millions, such as "Julia", "Fly Away" (Uletayu) and many others, will be performed on the stage of the Palace of the Republic. Incredible atmosphere, live sound and the most soulful songs await you this evening!'
WHERE event_id = 51;

-- 52: Saule Yusupova
UPDATE events
SET event_name_en = 'Saule Yusupova Solo Stand Up Concert',
    event_place_en = 'Almaty Theatre',
    description_en = 'Saule Yusupova''s Solo Stand Up Concert in Almaty! Saule is one of the most popular stand-up comedians, known for her unique style and life observations, which she turns into sparkling jokes. Get ready for an evening full of frank and funny humor. Age restriction: 18+.'
WHERE event_id = 52;

-- 53: Truwer
UPDATE events
SET event_name_en = 'Truwer in Almaty',
    event_place_en = 'Baluan Sholak Sports Palace',
    description_en = 'Truwer is a Kazakhstani rap artist who gained popularity thanks to his atmospheric tracks and deep lyrics. His music combines hip-hop with elements of other genres, creating a unique sound. The concert will feature both old hits and tracks from new releases. Age restriction: 16+.'
WHERE event_id = 53;

-- 54: Symphonic Teleportations
UPDATE events
SET event_name_en = 'Symphonic Teleportations - 2',
    event_place_en = 'E. Rakhmadiev State Academic Philharmonic Concert Hall',
    description_en = 'Grand opening of the XXVII concert season of the Symphony Orchestra. The program will feature masterpieces of world classics, including Camille Saint-Saens'' Violin Concerto No. 3 in B minor. The evening will be a confirmation of Astana''s status as a center of high artistic standards.'
WHERE event_id = 54;

-- 55: Galym Kaliakbarov
UPDATE events
SET event_name_en = 'Galym Kaliakbarov - Stand Up Concert',
    event_place_en = 'Concordia, Bogenbai Batyr 151, Almaty',
    description_en = 'Big solo Stand Up concert of Galym Kaliakbarov in Almaty. Galym is known for his sparkling humor based on life observations and national specifics. The audience can expect 1.5-2 hours of laughter and positivity. Guests gather from 18:00, start at 19:00.'
WHERE event_id = 55;

-- 56: Bagzhan October
UPDATE events
SET event_name_en = 'Bagzhan October: "Soul Therapy"',
    event_place_en = 'Baluan Sholak Sports Palace',
    description_en = 'Bagzhan October presents his new concert program "Soul Therapy". His songs are deep, lyrical stories that touch the most secret strings of the soul. The artist promises an unforgettable evening filled with sincere emotions and quality music.'
WHERE event_id = 56;

-- 57: Polina Hanym
UPDATE events
SET event_name_en = 'Polina Hanym in Almaty',
    event_place_en = 'Everjazz Jazz Club, Gogol St, 40b',
    description_en = 'On November 23, we will transport you to sunny Rio de Janeiro right in the heart of Almaty. Polina Hanym will perform the best compositions in the jazz genre, immersing listeners in the atmosphere of Brazilian bossa nova and Latin American rhythms.'
WHERE event_id = 57;

-- 58: Alsu
UPDATE events
SET event_name_en = 'Alsou in Almaty',
    event_place_en = 'Palace of the Republic',
    description_en = 'Long-awaited concert of Alsou in Kazakhstan! The singer invites you to an unforgettable evening of music filled with warmth, sincerity, and an atmosphere of magic. Do not miss the chance to hear beloved hits "Winter Dream", "Sometimes" and new songs performed live.'
WHERE event_id = 58;

-- 59: Demon Slayer
UPDATE events
SET event_name_en = 'Demon Slayer: Kimetsu no Yaiba - Infinity Castle (2025)',
    event_place_en = 'Chaplin Mega Silk Way',
    description_en = 'Tanjiro Kamado joins the Demon Slayer Corps after his sister Nezuko turns into a demon. The Corps and the Hashira begin a rigorous training program to prepare for the upcoming battle against demons. However, Muzan Kibutsuji appears at the Ubuyashiki mansion. When the leader of the Corps is in danger, Tanjiro and the Hashira rush to help but are dropped into a mysterious space by Muzan himself—the Infinity Castle. The final battle begins.'
WHERE event_id = 59;

-- 60: World in Fire
UPDATE events
SET event_name_en = 'World in Fire (2025)',
    event_place_en = 'Chaplin Mega Silk Way',
    description_en = 'Dave Bautista, Olga Kurylenko, and Samuel L. Jackson in a fantastic action-comedy about a heist in the midst of the apocalypse. After a powerful solar flare destroys the Eastern Hemisphere, the world plunges into chaos. Amidst all the madness, a treasure hunter sets off on the most daring heist of his life. He has to steal the "Mona Lisa", now hidden in the most dangerous place on the planet, and also save the world along the way (if possible).'
WHERE event_id = 60;

-- 61: Zhumbaq Qyz
UPDATE events
SET event_name_en = 'Mysterious Girl (2025)',
    event_place_en = 'Chaplin Khan Shatyr',
    description_en = 'After her father passes away, Ayaru falls into depression and seems to lose herself. When her mother and brother see her getting into gambling, they take strict measures. They take her to the farm in the village founded by her father. Ayaru gets used to the quiet atmosphere of the village and vigorously begins to revitalize the farm''s work. The main reason for this change is love. The relationship between her and her personal driver on the farm, Shyngys, starts with quarrels but turns into sweet feelings over time. However, Shyngys is engaged to a girl named Nurshat. The stakes are high...'
WHERE event_id = 61;

-- 62: Tron Ares
UPDATE events
SET event_name_en = 'Tron: Ares (2025)',
    event_place_en = 'Chaplin Khan Shatyr',
    description_en = '"Tron: Ares" is a continuation of the famous sci-fi franchise that will transport viewers to the exciting and dangerous world of the digital network known as the Grid. The film tells the story of Ares (Jared Leto), a powerful software that seems to have gone out of control and decided to invade the human world. It promises spectacular visual effects, dynamic action, and an exploration of philosophical questions about the nature of consciousness.'
WHERE event_id = 62;

-- 63: Ash pen Toq
UPDATE events
SET event_name_en = 'The Hungry and The Full (2025)',
    event_place_en = 'Chaplin Mega Almaty',
    description_en = 'Aidar and Eldar are former classmates whose lives turned out differently: one is a family man without a stable income, the other is a successful businessman deprived of parental happiness. A chance meeting turns into a frank conversation where each dreams of being in the other''s place. The next morning they wake up in each other''s bodies. Forced to live someone else''s life, the heroes face unexpected difficulties that change their idea of happiness, success, and true wealth.'
WHERE event_id = 63;

-- 64: Qaitadan
UPDATE events
SET event_name_en = 'Over Again (Qaitadan) (2025)',
    event_place_en = 'Chaplin Mega Almaty',
    description_en = 'A city teenager who failed an important exam is sent to a village to his grandmother. Desperately dreaming of escaping back, the hero soon discovers that his day begins to repeat itself, like in "Groundhog Day". The situation is complicated by the fact that every time at the end of the day, the local dam bursts, and the elements sweep away everything in their path. Realizing that every new cycle is a chance to prevent a catastrophe, the main character tries to break out of the time loop.'
WHERE event_id = 64;

-- 65: Manshuk
UPDATE events
SET event_name_en = 'MANSHUK',
    event_place_en = 'Musical Theatre of Young Spectators',
    description_en = 'In honor of the 80th anniversary of the Great Victory, the Musical Drama "Manshuk" depicting the short and courageous life of the Hero of the Soviet Union, the heroic Kazakh daughter Manshuk Mametova, is being staged. The purpose of the production is to set the bright life of the Kazakh heroine and her heroic deeds in the Great Patriotic War as an example for the younger generation. The work is based on historical facts.'
WHERE event_id = 65;

-- 66: Gashyksyz Gasyr
UPDATE events
SET event_name_en = 'Century Without Love',
    event_place_en = 'Zhanturin Mangystau Drama Theatre',
    description_en = 'The main characters are our contemporaries. 47-year-old Doctor of Science Kayirbay and 43-year-old Candidate of Science Farida married for love in their youth and have four children. For a family with good socio-economic status, the conflict in the play''s plot is Kayirbay''s affair with a girl named Nazikesh due to his desire to have a son. The climax of the event leads to the destiny of Farida and Kayirbay reuniting.'
WHERE event_id = 66;

-- 67: Chebatkov
UPDATE events
SET event_name_en = 'Evgeny Chebatkov in Pavlodar',
    event_place_en = 'Estay Palace of Culture',
    description_en = 'The new program "On Other Shores" is not just a set of jokes. It is a complete journey to which the comedian invites every viewer. A journey through different countries, cultures and, most importantly, the depths of human oddities. Evgeny will share everything that surprised, amused or made him think recently with his inherent sincerity. If you appreciate bold, intelligent comedy, this concert is for you.'
WHERE event_id = 67;

-- 68: Lucia Lacarra
UPDATE events
SET event_name_en = 'Lucia Lacarra: World Ballet Superstar',
    event_place_en = 'Almaty Theatre',
    description_en = 'On November 1 and 2, the International Ballet Festival together with Almaty Theatre presents an event eagerly awaited by the cultural capital of Kazakhstan. For the first time in Almaty, Spanish superstar Lucia Lacarra, winner of the "Ballet Oscar" Benois de la Danse, the Nijinsky Award, and the title of "Dancer of the Decade", will perform.'
WHERE event_id = 68;

-- 69: PGL Astana
UPDATE events
SET event_name_en = 'PGL Astana 2026 (Esports)',
    event_place_en = 'Barys Arena',
    description_en = 'After the resounding success of PGL Astana in 2025, when viewers in the capital of Kazakhstan witnessed a thrilling Tier-1 Counter-Strike tournament and celebrated Team Spirit''s victory, PGL returns with another must-visit event: PGL Astana 2026!'
WHERE event_id = 69;

-- 71: Ural Tansykbayev
UPDATE events
SET event_name_en = 'Lecture-tour of "Ural Tansykbayev" exhibition',
    event_place_en = 'Gallery of Fine Arts (NBU)',
    description_en = 'Host Daniyar Kholmatov, an art enthusiast and master''s student at the Art Management Faculty of the Russian University for the Humanities, will introduce you to key stages of the artist''s biography, analyze his significant works, and discuss the exposition itself and its context.'
WHERE event_id = 71;

-- 72: Almaty Open
UPDATE events
SET event_name_en = 'Almaty Open ATP 250',
    event_place_en = 'Almaty Arena',
    description_en = ''
WHERE event_id = 72;

-- 73: Art Party
UPDATE events
SET event_name_en = 'Art Party by Michael Art Studio in Shymkent',
    event_place_en = 'The Paragon Restaurant, Baidibek Bi St 229',
    description_en = 'We invite you to spend the brightest and most exclusive event of this year with us - the Art Party from Michael Art studio.'
WHERE event_id = 73;

-- 74: Burabay Pool
UPDATE events
SET event_name_en = 'Public Swimming at "Burabay" Sports Complex',
    event_place_en = 'Burabay Ice Palace, Swimming Pool',
    description_en = 'Mass visit to the swimming pool at the "Burabay" Sports Complex. Children under 7 years old in a small pool with parents. Capacity - 50 people per 1 hour.'
WHERE event_id = 74;

-- 75: Kobylandy
UPDATE events
SET event_name_en = 'Play "Kobylandy"',
    event_place_en = 'T. Akhtanov Drama Theatre',
    description_en = 'Play "Kobylandy" based on the work. Genre: Oral literature / Folklore. Director: Dina Zhumabayeva.'
WHERE event_id = 75;

-- 76: Circus Eldorado
UPDATE events
SET event_name_en = 'ELDORADO Big Top Circus in Semey',
    event_place_en = 'Semey Big Top Circus',
    description_en = 'Big Top Circus "EldoradO" with the program "Sea Miracle". 100 minutes of an unforgettable SHOW: acrobatic stunts, a group of exotic animals (sea hare "CHARLIE", crocodile "Varya", snakes), trained Rottweilers.'
WHERE event_id = 76;

-- 77: Picasso
UPDATE events
SET event_name_en = 'Exhibition "Pablo Picasso. Paragraphs"',
    event_place_en = 'LM Kulanshi Art Gallery',
    description_en = 'The loudest name in 20th-century art - at the exhibition from the Lumiere-Hall Museum. A frantic genius who created tens of thousands of works, the greatest innovator of modern times.'
WHERE event_id = 77;

-- 88: Deep Purple
UPDATE events
SET event_name_en = 'Deep Purple in Almaty',
    event_place_en = 'Almaty Arena 2',
    description_en = 'The legendary return of Deep Purple to Kazakhstan is the most anticipated rock event of the year! Become part of history, meet the legends. On April 22, 2026, in Almaty, Kazakhstan, we are pleased to welcome the cult British rock band Deep Purple with a live concert on the stage of Almaty Arena. Additionally, you can purchase a VIP Meet & Greet Upgrade package on the band''s website.'
WHERE event_id = 88;

-- 89: MEGADETH
UPDATE events
SET event_name_en = 'MEGADETH',
    event_place_en = 'Spartak Stadium (Central Park), Gogol St 1, bld 10',
    description_en = 'MEGADETH is a milestone after which metal will never be the same. Since 1983, MEGADETH has remained one of the most significant and influential forces in metal. They have 50 million records sold, a Grammy Award and 12 nominations. In 2025, the band released a single for the new 17th studio album. The lineup includes Dave Mustaine, Teemu Mantysaari, James LoMenzo, and Dirk Verbeuren. Don''t miss the powerful MEGADETH concert for the first time in Kazakhstan on June 28, 2026!'
WHERE event_id = 89;

-- 70: Philip Voronin
UPDATE events
SET event_name_en = 'Philip Voronin Stand-up Concert',
    event_place_en = 'Almaty Central Stand up club',
    description_en = 'Philip Voronin is a stand-up comedian, screenwriter and host of the show "I''m Funny". During his university studies, Philip managed to become a finalist of the "Comedy Battle" project on TNT, as well as found his own team "DALS" in KVN.'
WHERE event_id = 70;

-- 90: Tarsi Orchestra
UPDATE events
SET event_name_en = 'The Best of Tarsi',
    event_place_en = 'Zhastar Palace',
    description_en = 'Tarsi Orchestra - Twice Winners in the nomination "Best Symphonic Concert of the Year" by Ticketon. Grand symphonic concert "The Best of Tarsi". Hits tested by time, energy that gives goosebumps. Nostalgia of retro hits and driving power of rock compositions in symphonic processing. Best compositions of cult performers like: Europe, Queen, Cher, Status Quo, Nautilus Pompilius, Bi-2, KiSh and many others. Guests of the evening: Almaty tribute band "PULSE KINO"!'
WHERE event_id = 90;