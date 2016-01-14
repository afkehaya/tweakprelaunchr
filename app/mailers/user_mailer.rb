class UserMailer < ActionMailer::Base
    default from: "Harry's <welcome@harrys.com>"

    def mandrill_client
  		@mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  	end

    def signup_email(user)
        @user = user
        @twitter_message = "#Shaving is evolving. Excited for @harrys to launch."

        mail(:to => user.email, :subject => "Thanks for signing up!")
    end
end
