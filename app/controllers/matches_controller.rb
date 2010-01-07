class MatchesController < ApplicationController
  acts_as_iphone_controller #:test_mode => true
  
  before_filter :load_match_and_game
  
  # GET /matches
  # GET /matches.xml
  def index
    if @game
      @matches = @game.matches
    else
      @matches = Match.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matches }
      format.iphone do
        render :layout => "application2"
      end
    end
  end

  # GET /matches/1
  # GET /matches/1.xml
  def show
    @match = Match.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/new
  # GET /matches/new.xml
  def new
    
    @match = Match.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @match }
      format.iphone 
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
  end

  # POST /matches
  # POST /matches.xml
  def create
    @match = @game.matches.create_match(params)
    
    respond_to do |format|
      if @match.valid?
        flash[:notice] = 'Match was successfully created.'
        if @game.best_of == @game.matches.count
          go_to = game_matches_path(@game)
        else
          go_to = new_game_match_path(@game)
        end
        format.html { redirect_to(go_to) }
        format.iphone { redirect_to(go_to) }
        format.xml  { render :xml => @match, :status => :created, :location => @match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
      
      format.iphone { @matches = Match.all; redirect_to :action => "index" }
    end
  end

  # PUT /matches/1
  # PUT /matches/1.xml
  def update
    # @match = @game.matches.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        flash[:notice] = 'Match was successfully updated.'
        format.html { redirect_to(@match) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.xml
  def destroy
    @match.destroy

    respond_to do |format|
      format.html { redirect_to(matches_url) }
      format.xml  { head :ok }
    end
  end
  
  private
    def load_match_and_game
      if params[:game_id]
        @game = Game.find(params[:game_id])
        @match = @game.matches.find(params[:id]) if params[:id]
      else
        @match = Match.find(params[:id]) if params[:id]
      end
    end
    
end
