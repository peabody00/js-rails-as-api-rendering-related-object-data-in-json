class SightingsController < ApplicationController
    def show
        sighting = Sighting.find_by(id: params[:id])
        # render json: sighting

        # With the models connected we could now use use a custom hash to access related data
        # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }

        # render json: sighting, include: [:bird, :location]

        # With some error handling
        # if sighting
        #     render json: sighting.to_json(include: [:bird, :location])
        #   else
        #     render json: { message: 'No sighting found with that id' }
        # end

        # If you just want some of the attributes available you can do this.  Easier to read if using to_json
        render json: sighting.to_json(:include => {
            :bird => {:only => [:name, :species]},
            :location => {:only => [:latitude, :longitude]}
          }, :except => [:updated_at])
    end
end
