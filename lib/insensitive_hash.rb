require "insensitive_hash/version"

class InsensitiveHash < Hash
  attr_reader :encoder

  def initialize(*args, &block)
    @encoder = ->(k){ k.to_s.downcase }
    super
  end

  def self.[](hash)
    InsensitiveHash.new.tap do |ih|
      super(hash).each do |k, v|
        ih[k] = v.is_a?(Hash) ? self[v] : v
      end
    end
  end

  def encoder=(proc)
    @encoder =
      if proc.respond_to?(:call)
        proc
      elsif proc.respond_to?(:to_proc)
        proc.to_proc
      else
        raise ArgumentError, "encoder must respond to :call or :to_proc"
      end
  end

  def [](key)
    super(fix_key(key))
  end

  def []=(key, value)
    super(fix_key(key), value)
  end

  def store(key, value)
    super(fix_key(key), value)
  end

  def delete(key, &block)
    super(fix_key(key), &block)
  end

  def fetch(key, &block)
    super(fix_key(key), &block)
  end

  def has_key?(key)
    super(fix_key(key))
  end

  def key?(key)
    super(fix_key(key))
  end

  def member?(key)
    super(fix_key(key))
  end

  def include?(key)
    super(fix_key(key))
  end

  def invert
    self.class[super]
  end

  def merge!(hash, &block)
    super(self.class[hash], &block)
  end

  def merge(hash, &block)
    super(self.class[hash], &block)
  end

  def eql?(hash)
    super(self.class[hash])
  end

  def replace(hash)
    super(self.class[hash])
  end

  def update(hash, &block)
    super(self.class[hash], &block)
  end

  def values_at(*keys)
    super(keys.map{ |k| fix_key(k) })
  end

  private
    def fix_key(k)
      encoder.call(k)
    end
end
