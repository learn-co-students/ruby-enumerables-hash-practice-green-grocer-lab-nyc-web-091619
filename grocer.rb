require 'pry'

def consolidate_cart(cart)
  # code here
  r = Hash.new(0)

  cart.each do |item| 
    r[item] = item
    binding.pry
    if r[r.keys[0]].has_key?(:count) != true    
      r[r.keys[0]].store(:count,0)
      r[r.keys[0]][:count] += 1
    else
      r[r.keys[0]][:count] += 1
    end
  end
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
