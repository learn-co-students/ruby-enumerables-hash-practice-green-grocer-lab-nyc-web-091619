require 'pry'

def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |memo|
    memo.each_key do |key|
      cart_hash[key] ? cart_hash[key][:count] += 1 : (cart_hash[key] = memo[key]; cart_hash[key][:count] = 1)
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    discounted = "#{item} W/COUPON"
    if cart[item]
      if cart[item] && cart[item][:count] >= coupon[:num] && !cart[discounted]
        cart[discounted] = {price: coupon[:cost]/coupon[:num], clearance: cart[item][:clearance], count: coupon[:num]}
        cart[item][:count] -= coupon[:num]
      elsif cart[discounted] && cart[item][:count] >= coupon[:num] 
        cart[discounted][:count] += coupon[:num]
        cart[item][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |key, value|
  sale = value[:clearance]
  sale ? (value[:price] = (value[:price] * 0.8 ).round(2)) : value[:price]
  end
  cart
end

def checkout(cart, coupons)
  
end
