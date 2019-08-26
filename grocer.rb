def consolidate_cart(cart)
  c_cart = {}
  cart.map do |item|
    if c_cart[item.keys[0]]
      c_cart[item.keys[0]][:count] += 1
    else
      c_cart[item.keys[0]] = {
        count: 1,
        price: item.values[0][:price],
        clearance: item.values[0][:clearance]
      }
    end
  end
  c_cart
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
  cart.keys.each do |clear|
    if cart[clear][:clearance]==true
      cart[clear][:price]=(0.80*cart[clear][:price]).round(2)
    end
  end
    cart
end


def checkout(cart, coupons)
  # c_cart = consolidate_cart(cart)
  # c_cart_coup = apply_coupons(c_cart, coupons)
  # c_cart_coup_clear = apply_clearance(c_cart_coup)
  
  # subtotal=0.00
  # c_cart_coup_clear.keys.each do |item|
  #   subtotal += (c_cart_coup_clear[item][:price]*c_cart_coup_clear[item][:count]).round(2)
  # end
  # c_cart_coup_clear.keys.each do |thingz|
  #   sum+=(c_cart_coup_clear[thingz][:price]*c_cart_coup_clear[thingz][:count]).round(2)
  # end
  # subtotal=(subtotal*0.9).round(2) if subtotal>100
  
  
  cart1 = consolidate_cart(cart)
  cart2 = apply_coupons(cart1, coupons)
  cart3 = apply_clearance(cart2)

  subtotal = 0.0
  cart3.keys.each do |element|
    subtotal += cart3[element][:price]*cart3[element][:count]
  end
subtotal=(subtotal*0.9).round(2) if subtotal>100


    