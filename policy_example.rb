class Policy < Hash
  attr_reader :name

  def initialize(name)
    @name = name
    @rules = self
  end

  def <<(rule)
    key = rule.attribute

    self[key] ||= []
    self[key] << rule
  end

  def apply(account)
    self.each do |attribute, rules|
      rules.each {|rule| rule.apply(account)}
    end
  end
end

class Rule
  attr_reader :attribute, :default_value, :account_string

  def initialize(attribute, default_value, account_string: '')
    @attribute = attribute
    @default_value = default_value
    @account_string = account_string
  end

  def apply(account)
    account_string << account
  end

  def to_s
    account_string
  end
end
