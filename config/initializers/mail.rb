ActionMailer::Base.smtp_settings = {
	address: "smtp.mandrill.app.com",
	port: 587,
	enable_starttls_auto: true,
	user_name: "alex@kehaya.com",
	password: "Rs1PXQDvlCt7A-1Sx4ln4Q",
	authentication: "login"
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf8"