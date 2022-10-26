class HomeController < ApplicationController
    before_action :authenticate_user!
    def index
        @tests = Tda.all()      
    end
end