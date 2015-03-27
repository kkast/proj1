class PokemonsController < ApplicationController
  def capture
    @id = params[:id]
    @thepokemon = Pokemon.find(@id)
    @thepokemon.trainer = current_trainer
    @thepokemon.save
    redirect_to root_path
  end
  
  def damage
    @id = params[:idPokemon]
    @thepokemon = Pokemon.find(@id)
    @thepokemon.health -= 10
    @thepokemon.save
    redirect_to trainer_path(id: params[:idTrainer])
  end
  def heal
    @id = params[:idPokemon]
    @thepokemon = Pokemon.find(@id)
    @thepokemon.health += 10
    @thepokemon.save
    redirect_to trainer_path(id: params[:idTrainer])
  end
  
  def new
    @pokemon = Pokemon.new
  end
  
  def create
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.health = 100
    @pokemon.level = 1
    @pokemon.trainer = current_trainer
    if @pokemon.save
      redirect_to trainer_path(id: current_trainer)
    else
      puts @pokemon.errors
      puts @pokemon.errors
      puts @pokemon.errors
      puts @pokemon.errors.full_messages
      puts @pokemon.errors.full_messages
      puts @pokemon.errors.full_messages
      flash[:error] = @pokemon.errors.full_messages.to_sentence
      redirect_to new_pokemon_path
    end
  end
  
  def pokemon_params
    params.require(:pokemon).permit(:name)
  end
end
