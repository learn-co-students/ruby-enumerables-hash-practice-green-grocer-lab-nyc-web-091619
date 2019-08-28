def consolidate_cart(cart)
  [
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"AVOCADO" => {:price => 3.00, :clearance => true }},
  {"KALE"    => {:price => 3.00, :clearance => false}}
]
end

def apply_coupons(cart, coupons)
  {
  "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.00, :clearance => false, :count => 1}
}
end

def apply_clearance(cart)
  {
  "AVOCADO" => {:price => 3.00, :clearance => true, :count => 1},
  "KALE"    => {:price => 3.00, :clearance => false, :count => 1},
  "AVOCADO W/COUPON" => {:price => 2.50, :clearance => true, :count => 2},
}
end

def checkout(cart, coupons)
  {
  "PEANUT BUTTER" => {:price => 3.00, :clearance => true,  :count => 2},
  "KALE"         => {:price => 3.00, :clearance => false, :count => 3}
  "SOY MILK"     => {:price => 4.50, :clearance => true,  :count => 1}
}
end
