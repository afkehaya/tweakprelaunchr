require 'csv'

namespace :prelaunchr do
    desc "Will out put CSV's for each group of users you should email"
    task :create_winner_csvs => :environment do
        puts "User::REFERRAL_STEPS: #{User::REFERRAL_STEPS.inspect}"
        stops = User::REFERRAL_STEPS.map{|stop| stop["count"]}
        puts "stops: #{stops.inspect}"

        winners = Hash.new {|h,k| h[k]=[]} 
       User.limit(300).each { |user|
            found = nil
            
            puts "user: #{user.inspect}"

            stops.reverse_each { |stop|
               puts "stop: #{stop} | user referrals count: #{user.referrals.count}"
               puts "(!found): #{!found}"
               puts "(stop <= user.referrals.count): #{stop <= user.referrals.count}"
               puts "MAGIC VALUE: #{stop <= user.referrals.count and !found}"
                if stop <= user.referrals.count and !found
                    found = stop
                end
            }

            if found
                puts "Inside found TRUE"
                puts "winners: #{winners.inspect}"
                winners[found] << user
            end
        }
        
        puts "AFTER User.all.each LOOP !!!"
        
        puts "Final winners: #{winners.inspect}"

        winners.each { |stop, list|  
            CSV.open("#{Rails.root}/lib/assets/group_#{stop}.csv", "wb") do |csv|
                list.each { |user|  
                    csv << [user.email, user.referrals.count]
                }
            end
        }
    end
end