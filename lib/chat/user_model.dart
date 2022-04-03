class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User(
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  );
}

// YOU - current user
final User currentUser = User(
  0,
  'Nick Fury',
  'assets/images/nick-fury.jpg',
  true,
);

// USERS
final User ironMan = User(
  1,
  'Iron Man',
  'assets/images/ironman.jpeg',
  true,
);
final User captainAmerica = User(
   2,
   'Captain America',
   'assets/images/captain-america.jpg',
   true,
);
final User hulk = User(
   3,
   'Hulk',
   'assets/images/hulk.jpg',
   false,
);
final User scarletWitch = User(
  4,
  'Scarlet Witch',
  'assets/images/scarlet-witch.jpg',
 false,
);
final User spiderMan = User(
   5,
   'Spider Man',
   'assets/images/spiderman.jpg',
   true,
);
final User blackWindow = User(
   6,
   'Black Widow',
   'assets/images/black-widow.jpg',
   false,
);
final User thor = User(
   7,
   'Thor',
   'assets/images/thor.png',
   false,
);
final User captainMarvel = User(
   8,
   'Captain Marvel',
   'assets/images/captain-marvel.jpg',
   false,
);