class GamesController < ApplicationController

  # GET /games
  # GET /games.xml
  def index
    @games = Game.all
        
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
      # format.iphone #{ render :layout => "application2" }
      # respond_to_iphone(format)
    end
  end
  
  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      # respond_to_iphone(format)
      # # format.iphone { render :file => "/games/show.html.erb", :layout => true }
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new(:best_of => 3)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
      # format.iphone #{ render :layout => "application2" }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.create_game_with_matches_and_teams(params)
    respond_to do |format|
      if @game.valid?
        flash[:notice] = 'Game was successfully created.'
        if @game.finished?
          go_to = game_matches_path(@game)
        else
          go_to = new_game_match_path(@game)
        end
        format.html { redirect_to(go_to) }
        # format.iphone { redirect_to(go_to) }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(@game) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end

end
