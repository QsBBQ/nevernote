require './models.rb'

User.all.destroy
Note.all.destroy
Notebook.all.destroy
Tag.all.destroy
Tagging.all.destroy

#==
#Users
#==

joe = User.create(username: "joe", password: "apple")
chuck = User.create(username: "chuck", password: "pear")

p User.count == 2

#==
#Notebook
#==

recipes = Notebook.create(name: "Recipes", user: joe)
ruby_notebook = Notebook.create(name: "ruby_notebook", user: chuck)

p Notebook.count == 2
p recipes.name == "Recipes"

#Calling joes notebook with name recipe
p joe.notebooks.all(name: "Recipes").name == "Recipes" #How do i call just the name? == "Recipes"
#Calling all chucks notebooks
p chuck.notebooks.all(name: "ruby_notebook")

#All notebooks named Recipes
books = Notebook.all
p books.all(name: "Recipes")
#I see I can call users from books? But I am trying to call all books and users associated with the books
p books
p books.users
#Is it possible to call a users books from books?
#p books.all(username: "joe") #not good

users = User.all
#Is it possible to wild card names to see names and books?
p users.notebooks
p users.name

#==
#Notes
#As a user, I want to keep a store of notes
#==
brkfst = Note.new(title: "Egg Sandwich", content: "Eggs with salt and pepper and toast")
brkfst.notebook = recipes
brkfst.save

p Note.count == 1

#Practice
brkfst2 = Note.create(title: "Omelette", content: "Ham cheese and eggs", notebook: recipes)

p Note.count == 2

#As a user, I want to search for notes by their title
p Note.all(:title.like => "Egg %").first == brkfst

#As a user, I want to organize notes into notebooks.
p brkfst.notebook == recipes

#As a user, I want to add tags to notes
done = Tag.create(name: "done")
brkfst.tags << done
brkfst.save
#More practice
start = Tag.create(name: "start")
tagit = Tagging.create(note: brkfst2, tag: start)

#p joe.notebooks
p joe.notes
p joe.notes.tags

#As a user, I want to see all notes in a notebook
p recipes.notes

#As a user, I want to see all notes that have a particular tag
p done.notes
p start.notes

#Hmm think I need more practice back to the projects.
