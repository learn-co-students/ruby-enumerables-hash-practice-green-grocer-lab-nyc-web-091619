def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |n| 
    n.each_key do |key|
      if cart_hash[key]
        cart_hash[key][:count] += 1
      else
        cart_hash[key] = n[key]
        cart_hash[key][:count] = 1
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
      thing = coupon[:item]
      new_name = "#{thing} W/COUPON"
    
      #if the coupon item is in the cart and we have enough to qualify for the coupon...
      if cart.has_key?(thing) && cart[thing][:count] >= coupon[:num] then

        #if the item w/ coupon is already in cart then increment count
        if cart.has_key?(new_name) then
          cart[new_name][:count] += coupon[:num]
          
        #otherwise add the key and set count to coupon num
        else
          cart[new_name] = {}
          cart[new_name][:count] = coupon[:num]
        end
        #set w/ coupon price
        cart[new_name][:price] = coupon[:cost] / coupon[:num]
        cart[new_name][:clearance] = cart[thing][:clearance]
      
        #Adjust the old item in the cart w/o coupon
        cart[thing][:count] -= coupon[:num]
        
      end 
  end
  cart
end


def apply_clearance(cart)
  cart.each_key do |key|
    if cart[key][:clearance] == true then
      cart[key][:price] = (cart[key][:price] * 0.80).round(2)
    end
  end
end

def checkout(cart, coupons)
  cart_hash = consolidate_cart(cart)
  cart_hash = apply_coupons(cart_hash, coupons)
  cart_hash = apply_clearance(cart_hash)
  
  total = 0 
  
  cart_hash.each_key do |key|
    total += cart_hash[key][:count] * cart_hash[key][:price]
  end
  if total > 100 
    total = (total * 0.90).round(2)
  end
  total
end
