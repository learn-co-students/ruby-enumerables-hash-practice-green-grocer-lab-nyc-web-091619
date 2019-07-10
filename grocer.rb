require 'pry'

def consolidate_cart(cart)
  r = {}      # don't use Hash.new(0)
  
  cart.each do |item|
    
    if not r.key?(item.keys.first)
      r.update(item) { |key, value| value }
      r[item.keys.first].store(:count,1)
    else
      r[item.keys.first][:count] += 1 
    end
  end
  r
end

 
def apply_coupons(cart, coupon)
  coupon.each do |cp|
    if cart.keys.include?(cp[:item])
      if cart[cp[:item]][:count] >= cp[:num]
        addItem = "#{cp[:item]} W/COUPON"   
                              # used "cart.keys[0] + "
                              # vs "#{cp[:item]} W/COUPON" 
        if !cart[addItem]
          cart[addItem] = { 
            price: cp[:cost] / cp[:num],
            clearance: cart[cp[:item]][:clearance],
            count: cp[:num]
          }
        else
          cart[addItem][:count] += cp[:num]
        end
        cart[cp[:item]][:count] -= cp[:num]
      end
    end 
  end
  cart

end

def apply_clearance(cart)
  cart.each do |item|
    if cart[item[0]][:clearance] == true 
      cart[item[0]][:price] = (cart[item[0]][:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  sCart = {}
  sCart = consolidate_cart(cart)
  sCartCoupons = apply_coupons(sCart, coupons)
  sCartDiscounts = apply_clearance(sCartCoupons)
  
  total = 0
  sCartDiscounts.keys.each do |item|
    total += sCartDiscounts[item][:price]*sCartDiscounts[item][:count]
  end

  if total > 100 
    (total * 0.90).round(2)
  else
    total
  end
end
