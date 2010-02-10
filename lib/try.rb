class Object
  
  def try(method)
    if self.respond_to?(method)
      return self.send(method)
    else
      return nil
    end
  end
end

require 'test/unit'
class TryTest < Test::Unit::TestCase
  
  def test_try
    s = "schtring"
    assert s.to_s, "This should still work"
    assert_nil s.try(:to_alpha_beta_gaga)
    assert_nil nil.try(:bla_blub)
    assert_equal s, s.try(:to_s)
  end
  
  
end