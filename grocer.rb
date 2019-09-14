def consolidate_cart(cart)

    cons_cart = {}

    # adds a count of one to each item when there are no duplicates
    cart.each do |item|

        item_name = item.keys[0]

        if cons_cart[item_name]
            cons_cart[item_name][:count] += 1
        else
            cons_cart[item_name] = {
                :price => item.values[0][:price],
                :clearance => item.values[0][:clearance],
                :count => 1
            }
        end
    end

    return cons_cart
end

def apply_coupons(cart, coupons)

    coupon_cart = cart.clone

    cart.each do |item|
        item_name = item[0]
        item_count = cart[item_name][:count]

        coupons.each do |coupon|
            coupon_item = coupon[:item]

            # if coupon matches and is new coupon
            if coupon_item == item_name && !coupon_cart["#{item_name} W/COUPON"] && coupon_cart[item_name][:count] >= coupon[:num]
                coupon_cart["#{item_name} W/COUPON"] = {
                    # adds the coupon price to the property hash of couponed item
                    :price => coupon[:cost] / coupon[:num],
                    # adds the count number to the property hash of couponed item
                    :count => coupon[:num],
                    # remembers if the item was on clearance
                    :clearance => cart[item_name][:clearance]
                }

                coupon_cart[item_name][:count] -= coupon[:num]
             
             elsif coupon_item == item_name && coupon_cart["#{item_name} W/COUPON"] && coupon_cart[item_name][:count] >= coupon[:num]
                coupon_cart["#{item_name} W/COUPON"][:count] += coupon[:num]
                coupon_cart[item_name][:count] -= coupon[:num] 
            end

        end
    end

    return coupon_cart
end

def apply_clearance(cart)
    clearance_cart = cart.clone

    clearance_cart.each do |item|
        item_name = item[0]

        if clearance_cart[item_name][:clearance] == true
          clearance_cart[item_name][:price] -= clearance_cart[item_name][:price] * 0.20
        end 
    end

    clearance_cart
end

def checkout(cart, coupons)
    consolidated_cart = consolidate_cart(cart)
    coupon_cart = apply_coupons(consolidated_cart, coupons)
    clearance_cart = apply_clearance(coupon_cart)

    total = 0

    clearance_cart.each do |item|
        total += (item[1][:price] * item[1][:count])
    end 
    
    if total > 100
      total -= total * 0.10
    end

    return total
end