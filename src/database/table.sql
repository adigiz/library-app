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
