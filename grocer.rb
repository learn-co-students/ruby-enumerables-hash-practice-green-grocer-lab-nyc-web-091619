def consolidate_cart(cart)
 final_hash = {}
 cart.each do |element_hash|
   element_name = element_hash.keys[0]
   element_stats = element_hash.values[0]
   
   if final_hash.has_key?(element_name)
      final_hash[element_name][:count] += 1
   else
      final_hash[element_name] = {
        count: 1,
        price: element_stats[:price],
        clearance: element_stats[:clearance]
      }
   end
  end
  final_hash
end

def apply_coupons(cart, coupons)
 coupons.each do |coupon|
   if cart.keys.include? coupon[:item]
     if cart[coupon[:item]][:count] >= coupon[:num]
       new_name = "#{coupon[:item]} W/COUPON"
       if cart[new_name]
         cart[new_name][:count] += coupon[:num]
       else
         cart[new_name] = {
           count: coupon[:num],
           price: coupon[:cost]/coupon[:num],
           clearance: cart[coupon[:item]][:clearance]
         }
       end
       cart[coupon[:item]][:count] -= coupon[:num]
     end
   end
 end
 cart
end

def apply_clearance(cart)
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]*0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consol_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(consol_cart, coupons)
  cart_with_discounts_applied = apply_clearance(cart_with_coupons_applied)
  
  total = 0.0 
  cart_with_discounts_applied.keys.each do |item|
    total += cart_with_discounts_applied[item][:price]*cart_with_discounts_applied[item][:count]
  end
  total > 100.0 ? (total * 0.90).round : total
end
