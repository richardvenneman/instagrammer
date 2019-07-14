# frozen_string_literal: true

ignore([%r{^(bin)/*}])

guard :minitest all_on_start: false do
  watch(%r{^lib/(.+)\.rb$}) { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { "test" }
end
