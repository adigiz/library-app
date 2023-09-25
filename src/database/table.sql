CREATE DATABASE library_db;

-- Create the 'books' table
CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  author VARCHAR(255) NOT NULL,
  isbn VARCHAR(13) NOT NULL,
  is_borrowed BOOLEAN DEFAULT false,
  cover TEXT,
  synopsis TEXT,
  published_date DATE,
  slug TEXT not null,
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

INSERT INTO books (title, slug, author, isbn, is_borrowed, imageUrl, synopsis, published_date) VALUES
  ('Harry Potter and the Philosopher Stone','harry-potter-and-the-philosopher-stone', 'JK. Rowling', '1234567890123', false, 'https://images.ctfassets.net/usf1vwtuqyxm/2DCs73x6P8seNobQ9zBSbO/1a5dfd6ed5fc0ed9545370470fc3d74c/English_Harry_Potter_1_Epub_9781781100219.jpg?w=914&q=70&fm=webp', 'Harry Potter lives with his abusive aunt and uncle, Vernon and Petunia Dursley, and their bullying son, Dudley. On Harry''s eleventh birthday, Rubeus Hagrid, a half-giant, delivers an acceptance letter from Hogwarts School of Witchcraft and Wizardry, revealing that Harry''s parents, James and Lily Potter, were wizards. When Harry was one year old, powerful dark wizard Lord Voldemort murdered his parents. Harry survived Voldemort''s killing curse that rebounded and seemingly destroyed the Dark Lord, leaving a lightning bolt-shaped scar on his forehead. Unknown to Harry, this act made him famous in the wizarding world.\n Hagrid escorts Harry to Diagon Alley, the hidden wizard commerce and retail section in London. Harry''s parents have left him a fortune kept in Gringotts Wizarding Bank, which he uses to buy school supplies and a wand from Ollivander''s. The cores of Harry and Lord Voldemort''s wands have feathers from the same phoenix bird, making them "brothers". Hagrid gifts Harry an owl as a birthday present. Harry names her Hedwig. A month later, Harry boards the Hogwarts Express at King''s Cross railway station''s secret Platform 9+3⁄4. En route to Hogwarts, Harry befriends fellow first year Ron Weasley and meets Hermione Granger, whom the two boys initially dislike.\n Harry runs afoul of Draco Malfoy, the spoiled son of a prominent wizard. At Hogwarts, a magical Sorting Hat sorts the first years among four school Houses (Gryffindor, Hufflepuff, Ravenclaw, and Slytherin) that best suit their personalities and talents. Draco joins Slytherin, known for producing dark wizards, while Harry, Ron, and Hermione are sorted into Gryffindor. Harry''s broomstick flying ability earns him a place on the Gryffindor Quidditch team as the Seeker. Harry comes to dislike Potions master Severus Snape, who favours Slytherin while seeking to fail Harry. Malfoy tricks Harry and Ron into risking expulsion by leaving their common room after curfew. Hermione, unable to stop them, tags along. Realising Malfoy''s ruse, they hide in a forbidden corridor and discover a gigantic three-headed dog guarding a trapdoor. Harry and Ron later save Hermione from a troll during a Halloween celebration and the three become best friends. Coupled with Snape''s recent leg injury and suspicious behaviour, Harry, Ron, and Hermione believe he is attempting to enter the trapdoor. During Harry''s first Quidditch match, his broomstick attempts to buck him off. Snape''s strange behaviour during the match convinces Hermione he jinxed Harry''s broom. Harry receives an anonymous Christmas gift – his father''s invisibility cloak. Using it to explore the school, he discovers the Mirror of Erised, which shows what the viewer most desires. Harry sees his parents. A newspaper report later describes an attempted robbery at the same vault in Gringotts from which Hagrid retrieved an item for Hogwarts'' headmaster Albus Dumbledore on the same day. The object beneath the trapdoor is the philosopher''s stone, which grants its user immortality and the ability to turn any metal into pure gold. Firenze, a forest centaur, warns Harry that Voldemort is plotting to steal the stone to restore his body. When Dumbledore is lured from Hogwarts under false pretences, Harry, Hermione, and Ron fear the theft is imminent and descend through the trapdoor. Various obstacles force Ron and Hermione to remain behind while Harry proceeds. Harry encounters Professor Quirrell, the Defence Against the Dark Arts teacher. He jinxed Harry''s broom and let the troll into the school; Snape was protecting Harry. Voldemort, whose face has regrown on the back of Quirrell''s head, is revealed to be the professor''s secret master. Harry is forced to stand before the Mirror of Erised. It recognises Harry''s lack of greed for the stone and deposits it into his pocket. Quirrell attempts to seize the stone, but his flesh burns upon contact with Harry. Harry''s scar begins hurting, and he passes out. Harry awakens in the school''s infirmary. He survived Voldemort because his mother sacrificing her life for him left a magical protective charm. Quirrell''s hatred and greed caused him to burn upon contact with Harry; Voldemort abandoned him to die. Dumbledore reveals he sent Harry the invisibility cloak, while the philosopher''s stone, that had been keeping the long-lived Nicolas Flamel alive, has been destroyed with Flamel''s consent to prevent its being stolen. During the school''s year-end feast, Gryffindor is awarded the House Cup. Harry returns to the Dursleys at Privet Drive until the next school year.', '1997-07-30'),
  ('Harry Potter and the Chamber of Secrets','harry-potter-and-the-chamber-of-secrets', 'JK. Rowling', '2345678901234', true, 'https://images.ctfassets.net/usf1vwtuqyxm/6VuPUG4wPtmg3xvqwm6ZSn/2465365bae53ac09562f7bcea0b75cb3/English_Harry_Potter_2_Epub_9781781100226.jpg?w=914&q=70&fm=webp', '', '1998-07-02'),
  ('Harry Potter and the Prisoner of Azkaban','harry-potter-and-the-prisoner-of-azkaban', 'JK. Rowling', '2345678901234', true, 'https://images.ctfassets.net/usf1vwtuqyxm/24YWmI4UcyoMwj7wdKrEcL/374de1941927db12bd844fb197eab11f/English_Harry_Potter_3_Epub_9781781100233.jpg?w=914&q=70&fm=webp', '', '1999-07-08'),
  ('Harry Potter and the Goblet of Fire','harry-potter-and-the-goblet-of-fire', 'JK. Rowling', '2345678901234', true, 'https://images.ctfassets.net/usf1vwtuqyxm/3d9kpFpwHyjACq8H3EU6ra/85673f9e660407e5e4481b1825968043/English_Harry_Potter_4_Epub_9781781105672.jpg?w=914&q=70&fm=webp', '', '2000-07-08'),
  ('Harry Potter and the Order of The Phoenix','harry-potter-and-the-order-of-the-phoenix', 'JK. Rowling', '2345678901234', true, 'https://images.ctfassets.net/usf1vwtuqyxm/29op5HEVpvrKK2JKYCsFiO/5b939002fe3611b3f77659df83a76551/English_Harry_Potter_5_Epub_9781781100240.jpg?w=914&q=70&fm=webp', '', '2003-07-21'),
  ('Harry Potter and the Half Blood Prince','harry-potter-and-the-half-blood-prince', 'JK. Rowling', '2345678901234', true, 'https://images.ctfassets.net/usf1vwtuqyxm/35KbpLHvQvQtBBKs0vKErL/43985bc9e5bea863ccf9cc9561b62827/English_Harry_Potter_6_Epub_9781781100257.jpg?w=914&q=70&fm=webp', '', '2005-07-16'),
  ('Harry Potter and the Deathly Hallows','harry-potter-and-the-deathly-hallows','JK. Rowling', '2345678901234', true, 'https://images.ctfassets.net/usf1vwtuqyxm/6S51pK7uwnyhkS9Io9DsAn/320c162c5150f853b8d8568c4715dcef/English_Harry_Potter_7_Epub_9781781100264.jpg?w=914&q=70&fm=webp', '', '2007-07-21')