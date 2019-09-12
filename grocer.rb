def consolidate_cart(cart)
  # code here
  answer = {}
  cart.each{ |item|
    if answer[item.keys[0]]
      answer[item.keys[0]][:count] += 1
    else
      answer[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  }
  answer
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        name = "#{coupon[:item]} W/COUPON"
        if cart[name]
          cart[name][:count] += coupon[:num]
        else
          cart[name] = {
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
  # code here
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  clearance_applied = apply_clearance(coupons_applied)
  clearance_applied.keys.each do |item|
    total += (clearance_applied[item][:price] * clearance_applied[item][:count]).round(2)
  end
  if total > 100
    total = total * 0.9
  end
  return total
end
