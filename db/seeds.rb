# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

old_posts = Post.create(
  [{title: 'Jesus, you ugly',
    content: 'I’ve never been good at making things look pretty, but I do make them work. Myself included. My websites so far, are not sexy. I would go so far as to say they are ugly. Especially the I&E portal project.

But, for now, I don’t give a shit.

The I&E website has taught me that styling web development is a different beast all together from Ruby. Ruby makes more sense in my head than the front end stuff. Maybe because I’ve tried much harder with Ruby, and assumed the front end would follow. Not so.

I’ve been persevering with Zurb Foundation 5, which is a particularly popular front end development framework for Ruby developers. It works well with dynamic content, which Ruby serves up all the time.

The problem is… I’m just not sure I get it! I can’t seem to make it look the way I want it to look. The buttons are over there and that colour, but I want them over here and this colour goddamit. Don’t even get me started on my footer. Fuck it’s ugly.

I’ve also looked at Bootstrap, the front end development framework created by Twitter. This is also good with Ruby, and supposedly not too dissimilar from Foundation.  I’m not sure it’s easier though.

Anyway, I’ve refused to keep pounding my head against the wall with styling for now, and I’m going to keep focussing on getting more Ruby in my head, and wing the front end stuff by keeping it really simple, perhaps just using some templates in the interim. Clearly I have not learned my lesson yet.'}, 
    {title: 'Knowing when to stop… for now',
    content:'Ok, so I think I have come as far as I can for this Income & Expenditure (I&E) project for now. I have a basic working website, but I have to admit, there is still a lot of functionality that needs adding.

I’ve decided to put this on pause for now, because there is a diminishing marginal return for effort spent from now on in, until I develop my skills elsewhere, on other projects.    Details below:

What: A website built based of a tender request at work, for capturing mortgage applicant Income & Expenditure details

Features:

User interface: Users have to log in before accessing their data.  This uses a Session ID, linked with the User database.
minimum password length
required fields..first name etc…
Admin user interface, for adding, deleting and editing User income data.
Income form:
The consumer data required is captured by a form, with about 90 fields.
Each form is linked directly to one User and one User only.  So the database associations are: ‘Every User Has One Income’ and ‘Every Income Belongs to a User’
Users can save and edit their income data any time, and complete it at a later date.
Static pages… boring, but required: help, about, home…. etc.
Mobile responsive… the page adapts to the viewing device.
Features to add in the future:

Admin portal, with different sign in page
Submit button for income… which organises and validates income data, and  emails it somewhere.
Doesn’t sound like much so far does it?  Well the code behind it, linking it all togehter, it’s a big achievement for me.  I’m  really proud of it, even if it looks like a dogs arse.

My evident lack of ability with styling is worth it’s own post all together, it will be next after this.

Some screen grabs for you.  It looks fucking atrocious, but it works godamit.'}
    
    ])


