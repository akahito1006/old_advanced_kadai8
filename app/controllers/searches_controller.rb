class SearchesController < ApplicationController

def search
    @range_option = params[:range_option]
    @word_for_search = params[:word_for_search]
    
    if @range_option == "Users"
        @users = User.looks(params[:matching_option], params[:word_for_search])
        p @users
    elsif @range_option == "Books"
        @books = Book.looks(params[:matching_option], params[:word_for_search])
        p "-----------------------------------"
        p @books
    else
        redirect_to request.referer
    end
end
    
end
