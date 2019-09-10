def consolidate_cart(cart)
new_hash = {}
cart.each do |items|
  items.each do |groceryName, groceryV|
    if new_hash[groceryName]
    new_hash[groceryName][:count] += 1
    else
    new_hash[groceryName] = groceryV
    new_hash[groceryName][:count] = 1
  end
end
end
new_hash
end


def apply_coupons(cart, coupons = nil)
  if coupons.length == 0 || coupons == nil
  return cart
  elsif cart.size == 0
     return cart
  end
new_hash = {}
coupons.each do |coupon|
cart.each do |itemName, itemValue|
 if coupon[:item] == itemName && cart[itemName][:count] >= coupon[:num]
if new_hash["#{itemName} W/COUPON"]
new_hash["#{itemName} W/COUPON"][:count] += 2
else
new_hash["#{itemName} W/COUPON"] = {:price => coupon[:cost] / coupon[:num], :clearance => cart[itemName][:clearance], :count => coupon[:num] }
end
cart[itemName][:count] = cart[itemName][:count] - coupon[:num]
end
new_hash[itemName] = cart[itemName]
end
end
new_hash
  end

  def apply_clearance(cart)
  cart.each do |item, v|
  	if cart[item][:clearance] == true
  	discount20 = (cart[item][:price] * 0.20)
  	cart[item][:price]=  cart[item][:price] - discount20
  	end
  end
  cart
  end

  def checkout(items, coupons)
     cart = consolidate_cart(items)
     coupons_for_items = apply_coupons(cart, coupons)
     clearance_items = apply_clearance(coupons_for_items)

       total_price = clearance_items.reduce(0) do |memo, (key, val)|
       p  memo + (val[:price] * val[:count])
       end
       total_price > 100 ? total_price * 0.9 : total_price
     end
