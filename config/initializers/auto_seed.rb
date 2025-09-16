if Rails.env.development?
    begin
      Rails.application.load_seed
    rescue ActiveRecord::NoDatabaseError, PG::ConnectionBad
      puts "Database not ready yet, skipping seed"
    end
  end
  