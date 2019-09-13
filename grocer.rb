def consolidate_cart(cart)
  # code here
  # using .select 
  new_hash = {}
  cart.each do |item|
    item.each do |key, value|
      if !new_hash[key]
        new_hash[key] = value
        new_hash[key][:count] = 1
      else
        new_hash[key][:count] += 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |element|
    item_name = element[:item]
    if cart[item_name]
    # If the item is in the cart
      if cart[item_name][:count] >= element[:num] and !cart["#{item_name} W/COUPON"]
      # If the # of item in cart is greater than or = what the coupon counts for  
        # if !cart["#{item_name} W/COUPON"]
        # If we havent applied coupons for this item before
          cart[item_name][:count] -= element[:num]
          cart["#{item_name} W/COUPON"] = {
            :price => element[:cost] / element[:num],
            :clearance => cart[item_name][:clearance],
            :count => element[:num]
          }
        # end
      else #if cart["#{item_name} W/COUPON"]
      # If we have applied this coupon before
        if cart[item_name][:count] < element[:num]
          # Do nothing...
          # cart["#{item_name} W/COUPON"][:count] += element[:num]
          # cart[item_name][:count] -= element[:num]
        else
          cart["#{item_name} W/COUPON"][:count] += element[:num]
          cart[item_name][:count] -= element[:num]
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, values|
    if values[:clearance] == true
      values[:price] -= (values[:price] * 0.20)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  new_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(new_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  total = 0.0
  clearance_cart.each do |item, values|
    total += (values[:price] * values[:count])
  end
  if total > 100.0
    total -= (total * 0.10)
  end
  total
end
