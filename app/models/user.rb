class User < ActiveRecord::Base
    belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"
    has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"
    
    attr_accessible :email

    validates :email, :uniqueness => true, :format => { :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i, :message => "Invalid email format." }
    validates :referral_code, :uniqueness => true

    before_create :create_referral_code
    before_create :add_to_list
    after_create :send_welcome_email

    REFERRAL_STEPS = [
        {
            'count' => 5,
            "html" => "10% off",
            "class" => "two",
            "image" =>  ActionController::Base.helpers.asset_path("refer/cream-tooltip@2x.png")
        },
        {
            'count' => 10,
            "html" => "20% off",
            "class" => "three",
            "image" => ActionController::Base.helpers.asset_path("refer/truman@2x.png")
        },
        {
            'count' => 25,
            "html" => "30% off",
            "class" => "four",
            "image" => ActionController::Base.helpers.asset_path("refer/winston@2x.png")
        },
        {
            'count' => 50,
            "html" => "Free pair of<br>Tweak shoes!",
            "class" => "five",
            "image" => ActionController::Base.helpers.asset_path("refer/blade-explain@2x.png")
        }
    ]
    def add_to_list
      list_id = "d20fb9e7e3"
      @gb = Gibbon::Request.new(api_key: ENV["MAILCHIMP_KEY"])
      subscribe = @gb.lists(list_id).members.create(body: {
        email_address: self.email, 
        status: "subscribed", 
        double_optin: false
        })
   end

    private

    def create_referral_code
        referral_code = SecureRandom.hex(5)
        @collision = User.find_by_referral_code(referral_code)

        while !@collision.nil?
            referral_code = SecureRandom.hex(5)
            @collision = User.find_by_referral_code(referral_code)
        end

        self.referral_code = referral_code
    end

    def send_welcome_email
        UserMailer.delay.signup_email(self)
    end
end
