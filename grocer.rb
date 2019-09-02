def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  cart.each do |i| #for each... can this array be mapped?
    if consolidated_cart[i.keys[0]] #checks if present in cart
      consolidated_cart[i.keys[0]][:count] += 1
    else #adds if it wasn't
      consolidated_cart[i.keys[0]] = {
        :count => 1,
        :price => i.values[0][:price],
        :clearance => i.values[0][:clearance]
      }
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |i|
    if cart.keys.include? i[:item] #is the item present in the cart?
      if cart[i[:item]][:count] >= i[:num] #checks if item count exceeds qty limit
        couponed_item = "#{i[:item]} W/COUPON"
        if cart[couponed_item] #if couponed item is already present, increments
          cart[couponed_item][:count] += i[:num]
        else  #adds the item if it wasn't already there
          cart[couponed_item] = {
            count: i[:num],
            price: i[:cost]/i[:num],
            clearance: cart[i[:item]][:clearance]
          }
        end
        cart[i[:item]][:count] -= i[:num] #the remaining non-couponed items updated into cart
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.keys.each do |i|
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price]*0.80).round(2) #self-explanatory
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  discounted_cart = apply_clearance(couponed_cart)

  total = 0.0 #using float because dollars have centssssss
  discounted_cart.keys.each do |i|
    total += discounted_cart[i][:price]*discounted_cart[i][:count]
  end
  total > 100.00 ? (total * 0.90).round(2) : total
end
