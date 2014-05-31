require 'sinatra'
require 'pg'


def get_recipes
  connection = PG.connect(dbname: 'recipe_box')
  results = connection.exec('SELECT * FROM recipes ORDER BY name ASC')
  connection.close
  results
end

def get_recipe_info(id)
  connection = PG.connect(dbname: 'recipe_box')
  sql = "SELECT * FROM recipes WHERE id = $1"
  results = connection.exec(sql, [id])
  connection.close
  results
end

def get_ingredients(id)
  connection = PG.connect(dbname: 'recipe_box')
  sql = "SELECT * FROM ingredients WHERE recipe_id = $1"
  results = connection.exec(sql, [id])
  connection.close
  results
end

get '/recipes' do
  @recipes = get_recipes
  erb :'recipes.html'
end

get '/recipes/:id' do
  @recipe_id = params[:id]
  @recipe_info = get_recipe_info(@recipe_id)
  @ingredients = get_ingredients(@recipe_id)
  erb :'recipe_info.html'
end
