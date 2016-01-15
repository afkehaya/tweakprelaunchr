class UserMailer < ActionMailer::Base
    default from: "Tweak <team@tweak.com>"

    def signup_email(user)
        @user = user
        @twitter_message = "Excited for @tweakfootwear to launch. I'll be wearing a new pair of #shoes for #free!"

        mail(:to => user.email, :subject => "Thanks for signing up!")
    end
end
