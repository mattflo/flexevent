class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def cast
    set_voter_cookie 
    voter = Voter.find_by_guid params[:voter]
    redirect_to voter.event
  end

  def set_voter_cookie
    cookies.permanent[:_voter_id] = params[:voter] 
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    voter = Voter.find_by_guid cookies[:_voter_id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: { :voter => cookies[:_voter_id], :flexevent => voter.event, :votes => voter.votes_json}}
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  def seed
    event_name = 'Happy Hour Seed'
    event = Event.find_by_name event_name

    if event
      event.votes.each do |v| v.delete 
        v.ballots.each { |b| b.delete }
        v.delete
      end
      event.voters.each { |v| v.delete }
      event.delete
    end

    event = Event.create :name => event_name , :event_time => '6:00PM', :location => 'Improving Enterprises', :address => '1234 main st', :voting_cutoff => '2014/12/12' 
    event.save

    vote1 = Vote.create :event_date => "1/1/2014"
    vote1.event = event
    vote1.save

    vote2 = Vote.create :event_date => "1/2/2014"
    vote2.event = event
    vote2.save

    (1..8).each do |i|
      voter = Voter.create :email => "up#{i}@whatever.com"
      voter.event = event
      voter.save
      ballot = Ballot.create :direction => 1
      ballot.vote = vote1
      ballot.voter = voter
      ballot.save
    end

    (1..3).each do |i|
      voter = Voter.create :email => "down#{i}@whatever.com"
      voter.event = event
      voter.save
      ballot = Ballot.create :direction => -1
      ballot.vote = vote1
      ballot.voter = voter
      ballot.save
    end

    (1..4).each do |i|
      voter = Voter.create :email => "up#{i}@whatever.com"
      voter.event = event
      voter.save
      ballot = Ballot.create :direction => 1
      ballot.vote = vote2
      ballot.voter = voter
      ballot.save
    end

    (1..8).each do |i|
      voter = Voter.create :email => "down#{i}@whatever.com"
      voter.event = event
      voter.save
      ballot = Ballot.create :direction => -1
      ballot.vote = vote2
      ballot.voter = voter
      ballot.save
    end

    render json: { :flexevent => event, :votes => event.votes.as_json(:methods => [:upvotes, :downvotes])}
  end
end
