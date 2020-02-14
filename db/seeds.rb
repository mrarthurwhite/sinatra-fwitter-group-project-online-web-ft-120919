User.create(:username => "art", :email => "a@art.com", :password => "art")
User.create(:username => "alpha", :email => "alpha@mail.com", :password => "alpha")

Tweet.create(:content => "Love", :user_id => "1")
Tweet.create(:content => "Peace", :user_id => "1")
Tweet.create(:content => "Joy", :user_id => "1")
Tweet.create(:content => "Prosperity", :user_id => "2")
Tweet.create(:content => "Life", :user_id => "2")
