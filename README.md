Takeaway Challenge
==================
```
                            _________
              r==           |       |
           _  //            |  M.A. |   ))))
          |_)//(''''':      |       |
            //  \_____:_____.-------D     )))))
           //   | ===  |   /        \
       .:'//.   \ \=|   \ /  .:'':./    )))))
      :' // ':   \ \ ''..'--:'-.. ':
      '. '' .'    \:.....:--'.-'' .'
       ':..:'                ':..:'

 ```

Getting started
-------

* Clone this repo
* Run `bundle` in the directory of this project to install all associated gems.

### Getting started with Twilio

This project uses the Twilio SMS API to send the user a text message confirmation of their order.

An account is required to use the Twilio service. You can [create a free account](https://www.twilio.com/try-twilio) with Twilio, all you need is a mobile number registered in your country, that you can access.

The Twilio API will need access to an __authentication token__ and an __account SID__, both of which are available from the Twilio console once registered.

> :warning: **WARNING:** think twice before you push your **mobile number** or **Twilio API Key** to a public space like GitHub

The program is going to be looking inside the local __environment variables__ for this information.

Testing
-------

The program contains a series of tests using Rspec (this library should be installed if the steps above were followed)

To run all tests across all class files, do the following:

```bash
cd Navigate/to/project/directory

rspec
```

To run tests for a specific class file, do the following:

```bash
cd Navigate/to/project/directory

rspec spec/order_spec.rb
# or
rspec spec/menu_spec.rb
# or
rspec spec/takeaway_spec.rb
```
> Tests related to formatted currency are looking for the use of the '£', to denote GBP.

Instructions
-------

### IRB
This application will be executed using IRB

```bash
irb
```

### Viewing the menu

The first step to any takeaway order is the menu.

#### Viewing the raw menu

```bash
adamwoodcock@Adams-MacBook-Pro takeaway-challenge % irb 
3.0.2 :001 > require './lib/menu.rb'
 => true 
3.0.2 :002 > menu = Menu.new
 => #<Menu:0x00007f8eb9856480> 
 => 
 {:dish=>"Haddock", :price=>8.75},
 {:dish=>"Sausage", :price=>8.25},
 {:dish=>"Chips", :price=>3.95},
 {:dish=>"Gravy", :price=>0.95},
 {:dish=>"Roll", :price=>1.25},
 {:dish=>"Coke", :price=>1.75},
 {:dish=>"Fanta", :price=>1.75}] 
```
#### Viewing a formatted menu

```bash
adamwoodcock@Adams-MacBook-Pro takeaway-challenge % irb 
3.0.2 :001 > require './lib/menu.rb'
 => true 
3.0.2 :002 > menu = Menu.new
 => #<Menu:0x00007f8eb9856480> 
3.0.3 :002 > menu.view_formatted_menu
Cod - £8.25
Haddock - £8.75
Sausage - £8.25
Chips - £3.95
Gravy - £0.95
Roll - £1.25
Coke - £1.75
Fanta - £1.75
```
  
### Adding an item to the basket

```bash
adamwoodcock@Adams-MacBook-Pro takeaway-challenge % irb    
3.0.2 :001 > require './lib/order.rb'
 => true 
3.0.2 :002 > order = Order.new
 => #<Order:0x00007fb46e0f14f8 @basket={}, @menu=#<Menu:0x00007fb46e0f1408>, @order_total=0.0> 
3.0.2 :003 > order.add("Cod", 2)
 => 2 
3.0.2 :004 > order.add("Chips", 2)
 => 2 
3.0.2 :005 > order.add("Roll", 2)
 => 2 
```

### Getting the price of a basket

```bash
# continuing from the previous example
3.0.2 :006 > order.total
Basket: {"Cod"=>2, "Chips"=>2, "Roll"=>2}
 => "£13.45"
```

### Placing an order

The final step involves using our `Takeaway` class. Some additional steps are required in order to use this part of the program.

#### Using the Twilio API

If you have not done so already, please refer back to the 'Getting started with Twilio' section at the beginning of the article.

It is important to ensure that you add environment variables in the following format:

```bash
adamwoodcock@Adams-MacBook-Pro ~ % irb
3.0.0 :001 > ENV["TWILIO_ACCOUNT_SID"] = "ACf3xxxxxxxxxxxxxxxxxxx"
 => "ACf3xxxxxxxxxxxxxxxxxxx" 
3.0.0 :002 > ENV["TWILIO_AUTH_TOKEN"] = "04axxxxxxxxxxxxx"
 => "04axxxxxxxxxxxxx" 
3.0.0 :003 > ENV["PHONE_NUMBER"] = "+44798765432"
 => "+44798765432" 
```
> Note that the environment variables are instantiated __within IRB__. They must be named exactly as above for the program to work correctly.

#### Create a new takeaway

```bash
3.0.2 :011 > require './lib/takeaway.rb'
 => true 
3.0.2 :012 > takeaway = Takeaway.new(order)
----------------
CAUTION: Before proceeding
If you would like to send SMS messages, please ensure you have entered your credentials as environment variables
----------------
 => 
#<Takeaway:0x00007fb471b2d428
... 
```
#### Verifying the order price is correct
We all have those moments when we're not sure if the bill is correct. If you like to count the pennies, go ahead and feed them into the takeaway:

```bash
3.0.2 :016 > takeaway.check_order_price(13.45)
Basket: {"Chips"=>1, "Cod"=>2, "Roll"=>2}
 => true 
```

### Complete an order
This section will use the Twilio API to send a text message to your __verified__ phone number on Twilio.

```bash
3.0.2 :017 > takeaway.complete_order
Basket: {"Chips"=>1, "Cod"=>2, "Roll"=>2}
 => <Twilio.Api.V2010.MessageInstance body: Sent from your Twilio trial account - Thank you! Your order was placed and will be delivered before 22:47 num_segments: 1 direction: outbound-api from: +17627602250 to: +4479------ date_updated: 2022-03-09 21:47:24 +0000 price:  error_message:  uri: /2010-04-01/Accounts/ACxxxxxxxxxxxxxxxx/Messages/d.json account_sid: ACxxxxxxxxxxxxxx num_media: 0 status: queued messaging_service_sid:  sid: SM77a date_sent:  date_created: 2022-03-09 21:47:24 +0000 error_code:  price_unit: USD api_version: 2010-04-01 subresource_uris: {"media"=>"/2010-04-01/Accounts/ACxxxxxxxxxx22/Messages/SM44d/Media.json"}> 
```


User stories
-----

```
As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes

As a customer
So that I can verify that my order is correct
I would like to check that the total I have been given matches the sum of the various dishes in my order

As a customer
So that I am reassured that my order will be delivered on time
I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered
```
