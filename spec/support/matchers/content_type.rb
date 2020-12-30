RSpec::Matchers.define(:have_content_type) do |exected|
  match do |actual|
    actual.content_type === expected
  end
end