module RidesHelper
  def post_to_facebook(data)
    me = FbGraph::User.fetch(current_user.uid, :access_token => session[:fb_access_token])
    begin
      me.feed!(
        :message => 'Test',
        :picture => 'http://tworiversuu.org/wp-content/uploads/2011/05/carpool-bug.jpg',
        :link => "http://carpool.co.in",
        :name => 'Test',
        :description => 'A Carpool ride'
      )    
    notice = 'Successfully posted to facebook!'
    rescue Exception => e
      Rails.logger.info "#{e.message} \n #{e.backtrace}"
      notice = 'Sorry, could not post to facebook!'
    end
    notice
  end
end
