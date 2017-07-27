class SetWithIndifferentAccess < Set
  def initialize(*)
    super
    @hash = @hash.with_indifferent_access
  end
end
