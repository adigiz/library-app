CREATE DATABASE library_db;

-- Create the 'books' table
CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  isbn VARCHAR(13) NOT NULL,
  is_borrowed BOOLEAN DEFAULT false,
  imageUrl TEXT,
  fileUrl TEXT,
  synopsis TEXT,
  published_date DATE,
  slug TEXT not null,
  genre VARCHAR(255) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT current_timestamp,
  updated_at TIMESTAMPTZ DEFAULT current_timestamp,
  deleted_at TIMESTAMPTZ
);

-- Create the 'borrowed_books' table to track book borrowings
CREATE TABLE borrowed_books (
  id SERIAL PRIMARY KEY,
  book_id INTEGER REFERENCES books(id),
  user_id INTEGER,
  borrowed_at TIMESTAMP NOT NULL DEFAULT NOW(),
  returned_at TIMESTAMP
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(15) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  is_admin BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT current_timestamp,
  updated_at TIMESTAMPTZ DEFAULT current_timestamp,
  deleted_at TIMESTAMPTZ
);

INSERT INTO books (
  title, genre, fileUrl, slug, author, isbn, 
  is_borrowed, imageUrl, synopsis, 
  published_date
) 
VALUES 
  (
    'Harry Potter and the Philosopher Stone', 
    'Fantasy,Mystery,Thriller',
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698915903/Harry_Potter_and_the_Sorcerer_39_s_Stone_Harry_Potter_1_iozyii.epub', 
    'harry-potter-and-the-philosopher-stone', 
    'JK. Rowling', '1234567890123', 
    false, 'https://images.ctfassets.net/usf1vwtuqyxm/2DCs73x6P8seNobQ9zBSbO/1a5dfd6ed5fc0ed9545370470fc3d74c/English_Harry_Potter_1_Epub_9781781100219.jpg?w=914&q=70&fm=webp', 
    'On his eleventh birthday, Harry Potter learns he is a wizard and receives an acceptance letter to Hogwarts School of Witchcraft and Wizardry. He discovers his parents were wizards and that he survived an attack by the dark wizard Voldemort as a baby. At Hogwarts, he makes friends with Ron Weasley and Hermione Granger, gets sorted into Gryffindor, and learns about the Sorcerer''s Stone. The stone, hidden in the school, can grant immortality. Harry, Ron, and Hermione suspect someone is trying to steal it, leading to a showdown with Professor Quirrell and the revelation of Voldemort''s return.', 
    '1997-07-30'
  ), 
  (
    'Harry Potter and the Chamber of Secrets',
    'Fantasy,Mystery,Thriller', 
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698917737/Harry_Potter_and_the_Chamber_of_Secrets_Harry_Potter_2_fbfbbu.epub', 
    'harry-potter-and-the-chamber-of-secrets', 
    'JK. Rowling', '2345678901234', 
    true, 'https://images.ctfassets.net/usf1vwtuqyxm/6VuPUG4wPtmg3xvqwm6ZSn/2465365bae53ac09562f7bcea0b75cb3/English_Harry_Potter_2_Epub_9781781100226.jpg?w=914&q=70&fm=webp', 
    'In the second year at Hogwarts, Harry Potter returns after a summer at the Dursleys. Mysterious events unfold as students and even Filch''s cat are found petrified. Harry, Ron, and Hermione discover the Chamber of Secrets has been opened. Harry finds Tom Riddle''s enchanted diary, revealing the chamber''s history. The trio suspects Draco Malfoy and Dobby, the house-elf. Harry enters the chamber, defeats a basilisk, and destroys the diary to save Ginny Weasley. The school year ends with Gryffindor winning the House Cup.', 
    '1998-07-02'
  ), 
  (
    'Harry Potter and the Prisoner of Azkaban',
    'Fantasy,Mystery,Thriller', 
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698917737/Harry_Potter_and_the_Prisoner_of_Azkaban_Harry_Potter_3_qlctwo.epub', 
    'harry-potter-and-the-prisoner-of-azkaban', 
    'JK. Rowling', '2345678901234', 
    true, 'https://images.ctfassets.net/usf1vwtuqyxm/24YWmI4UcyoMwj7wdKrEcL/374de1941927db12bd844fb197eab11f/English_Harry_Potter_3_Epub_9781781100233.jpg?w=914&q=70&fm=webp', 
    'In his third year at Hogwarts, Harry learns that Sirius Black, an escaped prisoner, is believed to be a threat. Dementors guard the school, causing Harry to pass out. He learns the truth about Sirius, who is his godfather and not a traitor. With the help of a time-turner, they save Sirius and Buckbeak, the hippogriff.', 
    '1999-07-08'
  ), 
  (
    'Harry Potter and the Goblet of Fire',
    'Fantasy,Mystery,Thriller', 
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698917736/Harry_Potter_and_the_Goblet_of_Fire_Harry_Potter_4_urvyok.epub', 
    'harry-potter-and-the-goblet-of-fire', 
    'JK. Rowling', '2345678901234', 
    true, 'https://images.ctfassets.net/usf1vwtuqyxm/3d9kpFpwHyjACq8H3EU6ra/85673f9e660407e5e4481b1825968043/English_Harry_Potter_4_Epub_9781781105672.jpg?w=914&q=70&fm=webp', 
    'Harry is unexpectedly entered into the Triwizard Tournament, a dangerous competition. He faces various challenges, including a Hungarian Horntail dragon and the underwater task. Ultimately, he encounters Voldemort and his Death Eaters, leading to a rebirth of the Dark Lord.', 
    '2000-07-08'
  ), 
  (
    'Harry Potter and the Order of The Phoenix',
    'Fantasy,Mystery,Thriller', 
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698917736/Harry_Potter_and_the_Order_of_the_Phoenix_Harry_Potter_5_kkyquh.epub', 
    'harry-potter-and-the-order-of-the-phoenix', 
    'JK. Rowling', '2345678901234', 
    true, 'https://images.ctfassets.net/usf1vwtuqyxm/29op5HEVpvrKK2JKYCsFiO/5b939002fe3611b3f77659df83a76551/English_Harry_Potter_5_Epub_9781781100240.jpg?w=914&q=70&fm=webp', 
    'Harry returns to Hogwarts for his fifth year, facing challenges and isolation. He forms Dumbledore''s Army to resist the oppressive regime of Dolores Umbridge. The climactic battle at the Department of Mysteries reveals a prophecy about Harry and Voldemort.', 
    '2003-07-21'
  ), 
  (
    'Harry Potter and the Half Blood Prince',
    'Fantasy,Mystery,Thriller', 
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698917736/Harry_Potter_and_the_Half-Blood_Prince_Harry_Potter_6_wqetuk.epub', 
    'harry-potter-and-the-half-blood-prince', 
    'JK. Rowling', '2345678901234', 
    true, 'https://images.ctfassets.net/usf1vwtuqyxm/35KbpLHvQvQtBBKs0vKErL/43985bc9e5bea863ccf9cc9561b62827/English_Harry_Potter_6_Epub_9781781100257.jpg?w=914&q=70&fm=webp', 
    'Harry learns about Voldemort''s Horcruxes and discovers the identity of the Half-Blood Prince, Severus Snape. Tragedy strikes as Dumbledore is killed by Snape, and the Death Eaters begin their rise to power.', 
    '2005-07-16'
  ), 
  (
    'Harry Potter and the Deathly Hallows',
    'Fantasy,Mystery,Thriller', 
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698917735/Harry_Potter_and_the_Deathly_Hallows_Harry_Potter_7_ibzvpx.epub', 
    'harry-potter-and-the-deathly-hallows', 
    'JK. Rowling', '2345678901234', 
    true, 'https://images.ctfassets.net/usf1vwtuqyxm/6S51pK7uwnyhkS9Io9DsAn/320c162c5150f853b8d8568c4715dcef/English_Harry_Potter_7_Epub_9781781100264.jpg?w=914&q=70&fm=webp', 
    'In the final book, Harry, Ron, and Hermione go on a quest to find and destroy Horcruxes to weaken Voldemort. The Deathly Hallows, three magical objects, play a crucial role. The story ends with the climactic Battle of Hogwarts, the final defeat of Voldemort, and the epilogue showing the characters'' futures.', 
    '2007-07-21'
  )

INSERT INTO books (
  title, genre, fileUrl, slug, author, isbn, 
  is_borrowed, imageUrl, synopsis, 
  published_date
) 
VALUES 
  (
    'The Lost Symbol',
    'Thriller,Adventure,Mystery,Conspiracy',
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698979130/3_The_Lost_Symbol_-_Dan_Brown_zgnsth.epub',
    'the-lost-symbol',
    'Dan Brown',
    '2345678901234',
    false,
    'https://res.cloudinary.com/dhrs3yldr/image/upload/v1698980844/lost-symbol_c1jruw.jpg',
    'Harvard symbologist Robert Langdon is called to Washington, D.C. to help solve a mystery involving his mentor, Peter Solomon. Peter''s severed hand is found in the U.S. Capitol with a Masonic symbol. Langdon discovers that Peter''s kidnapper seeks to reveal a powerful Masonic secret, which is said to be hidden beneath the city. Langdon, along with Peter''s sister Katherine and CIA agent Inoue Sato, races against time to uncover the truth and prevent a catastrophic revelation. The novel explores the world of Freemasonry, ancient mysteries, and the power of the human mind.',
    '2009-09-15'
  ),
  (
    'Angels and Demon',
    'Thriller,Adventure,Mystery,Conspiracy',
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698979130/1_Angels_and_Demons_-_Dan_Brown_kyycz7.epub',
    'angels-and-demon',
    'Dan Brown',
    '2345678901234',
    false,
    'https://res.cloudinary.com/dhrs3yldr/image/upload/v1698980844/angel-demon_msnuyh.jpg',
    'Harvard symbologist Robert Langdon is called to the Vatican after a scientist is murdered with the word "Illuminati" branded on his chest. Langdon discovers a plot to destroy the Vatican using antimatter stolen from CERN. With the help of Vittoria Vetra, the scientist''s daughter, Langdon races against time to unravel the ancient secrets of the Illuminati and prevent a catastrophic disaster. The novel explores the conflict between science and religion and takes readers on a thrilling journey through the historic sites of Rome.',
    '2000-05-12'
  ),
  (
    'The Da Vinci Code',
    'Thriller,Adventure,Mystery,Conspiracy',
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698979130/2_The_Da_Vinci_Code_-_Dan_Brown_fprvlp.epub',
    'the-da-vinci-code',
    'Dan Brown',
    '2345678901234',
    false,
    'https://res.cloudinary.com/dhrs3yldr/image/upload/v1698980844/da-vinci-code_ddkrha.jpg',
    'Harvard symbologist Robert Langdon is called to the Louvre Museum in Paris after the curator is found murdered, leaving behind a series of cryptic clues. Langdon, along with French cryptologist Sophie Neveu, embarks on a quest to unravel the secrets hidden within the works of Leonardo da Vinci and uncover a religious mystery that could change the course of history. They must decipher codes, follow a trail of hidden symbols, and stay one step ahead of a secret organization while seeking the Holy Grail. The novel explores art, religion, and history while delivering a gripping and suspenseful narrative.',
    '2003-03-18'
  ),
  (
    'Inferno',
    'Thriller,Adventure,Mystery,Conspiracy',
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698979130/4_Inferno_-_Dan_Brown_wpmwg0.epub',
    'inferno',
    'Dan Brown',
    '2345678901234',
    false,
    'https://res.cloudinary.com/dhrs3yldr/image/upload/v1698981519/inferno_iv0gf3.jpg',
    'Harvard professor Robert Langdon awakens in a hospital in Florence, Italy, with no memory of the past few days. He is soon pursued by an assassin and teams up with Sienna Brooks, a doctor. Langdon discovers a mysterious cylinder containing Dante''s "Inferno," a map of hell. The pair follows a trail of clues related to Dante''s work, leading them to uncover a deadly plot by a mad geneticist. The novel explores themes of overpopulation and ethical dilemmas while taking readers on a thrilling journey through historical landmarks in Florence and Venice.',
    '2013-05-14'
  ),
  (
    'Origin',
    'Thriller,Adventure,Mystery,Conspiracy',
    'https://res.cloudinary.com/dhrs3yldr/raw/upload/v1698979130/5_Origin_-_Dan_Brown_bn4rfg.epub',
    'origin',
    'Dan Brown',
    '2345678901234',
    false,
    'https://res.cloudinary.com/dhrs3yldr/image/upload/v1698980844/origin_twto7p.jpg',
    'Harvard professor Robert Langdon is invited to a high-tech presentation at the Guggenheim Museum in Bilbao, Spain, by his former student Edmond Kirsch, a futurist and computer scientist. Kirsch has made a groundbreaking discovery that he believes will answer humanity''s most profound questions: Where do we come from, and where are we going? However, just as Kirsch is about to unveil his discovery, chaos erupts, and he is assassinated. Langdon teams up with Ambra Vidal, the museum director, to decipher Kirsch''s cryptic presentation. As they follow the trail of clues, they uncover a revelation that could challenge established religious beliefs and the future of human civilization. The novel delves into the conflict between science and religion while taking readers on a fast-paced journey through Spain.',
    '2017-10-03'
  )
