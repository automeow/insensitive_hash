require "insensitive_hash/version"

class InsensitiveHash < Hash
  def initialize(*args)
    return super(*args) unless args[0].is_a?(Hash)
    args.shift.tap{ super(*args) }.each do |k, v|
      self[k] = v.is_a?(Hash) ? self.class.new(v) : v
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

  def delete(key)
    super(fix_key(key))
  end

  def fetch(key)
    super(fix_key(key))
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
    self.class.new(super)
  end

  def merge!(hash)
    super(self.class.new(hash))
  end

  def merge(hash)
    super(self.class.new(hash))
  end

  def eql?(hash)
    super(self.class.new(hash))
  end

  def replace(hash)
    super(self.class.new(hash))
  end

  def update(hash)
    super(self.class.new(hash))
  end

  def values_at(*keys)
    super(keys.map{ |k| fix_key(k) })
  end

  private
    def fix_key(k)
      k.to_s.downcase
    end
end
