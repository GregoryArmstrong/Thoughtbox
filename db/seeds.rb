class Seed

  attr_accessor :counter

  def self.start
    seed = Seed.new
    seed.generate_roles
  end

  def generate_roles
    Role.create(name: "registered_user")
  end

end

Seed.start
