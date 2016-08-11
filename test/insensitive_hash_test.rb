require 'test_helper'

class InsensitiveHashTest < Minitest::Test
  TEST_KEYS_FOO = [:foo, :FOO, 'foo', 'FOO']
  TEST_KEYS_BAR = [:bar, :BAR, 'bar', 'BAR']

  def test_that_it_has_a_version_number
    refute_nil ::InsensitiveHash::VERSION
  end

  def test_insensitivity
    hash = InsensitiveHash[foo: 42, 1 => :bar]

    TEST_KEYS_FOO.each{ |k| assert_equal 42, hash[k] }
    assert_nil hash[:bar]

    assert_equal :bar, hash[1]
    assert_equal :bar, hash['1']
  end

  def test_merge
    hash = InsensitiveHash[foo: 42]

    TEST_KEYS_FOO.each{ |k| assert_equal 71, hash.merge(k => 71)[:foo] }
    TEST_KEYS_FOO.each{ |k| assert_equal 42, hash[k] }

    TEST_KEYS_FOO.each do |k|
      hash.merge!(k => 89)
      TEST_KEYS_FOO.each{ |k2| assert_equal 89, hash[k2] }
    end
  end

  def test_sub_hash
    hash = InsensitiveHash[foo: { bar: 42 }]
    TEST_KEYS_FOO.each do |f|
      TEST_KEYS_BAR.each do |b|
        assert_equal 42, hash[f][b]
      end
    end
  end

  def test_default
    hash = InsensitiveHash.new(42)
    assert_equal 42, hash[:foo]
  end

  def test_set_encoder
    hash = InsensitiveHash.new
    hash.encoder = :to_s
    hash[:foo] = 42
    assert_equal 42, hash[:foo]
    assert_equal 42, hash['foo']
    assert_nil hash[:Foo]
    assert_nil hash['Foo']

    hash = InsensitiveHash.new
    hash.encoder = ->(k){ "#{k}_bar" }
    hash[:foo] = 42
    assert_equal "foo_bar", hash.keys.first

    assert_raises ArgumentError do
      hash.encoder = 1
    end
  end
end
