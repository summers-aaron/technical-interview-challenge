alias Dogs.Dog
alias Dogs.Repo

dogs = [
  %Dog{breed: "Affenpinscher", image: "affenpinscher.jpg"},
  %Dog{breed: "Boxer", image: "boxer.jpg"},
  %Dog{breed: "English Bulldog", image: "english_bulldog.jpg"},
  %Dog{breed: "Irish Terrier", image: "irish_terrier.jpg"},
  %Dog{breed: "Pomeranian", image: "pomeranian.jpg"},
  %Dog{breed: "Border Collie", image: "border_collie.jpg"},
  %Dog{breed: "Cocker Spaniel", image: "cocker_spaniel.jpg "},
  %Dog{breed: "Great Dane", image: "great_dane.jpg"},
  %Dog{breed: "Norwich Terrier", image: "norwich_terrier.jpg"},
  %Dog{breed: "Shetland Sheepdog", image: "shetland_sheepdog.jpg"}
]

Enum.each(dogs, &Repo.insert(&1))
