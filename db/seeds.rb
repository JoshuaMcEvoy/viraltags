User.destroy_all
u1 = User.create :name => 'Josh', :email => 'josh@ga.com'
u2 = User.create :name => 'Jae', :email => 'jae@ga.com'
u3 = User.create :name => 'Serene', :email => 'serene@ga.com'

Comment.destroy_all
c1 = Comment.create :content => 'This is a comment'
c2 = Comment.create :content => 'Some comment about stuff'
c3 = Comment.create :content => 'I like this comment'
c4 = Comment.create :content => 'My name is Jae, I like art and stuff'
c5 = Comment.create :content => 'I changed the colour of my hair again'
c6 = Comment.create :content => 'Joop threw up in my hair'
c7 = Comment.create :content => 'Did you say dating app?'
c8 = Comment.create :content => 'Are you going to finish eating that?'
c9 = Comment.create :content => 'This is my third breakfast'

Location.destroy_all
l1 = Location.create :longitude => '-33.868679', :latitude => '151.206422'
l2 = Location.create :longitude => '-33.825033', :latitude => '151.193997'
l3 = Location.create :longitude => '-33.870020', :latitude => '151.205882'

u1.comments << c1
u1.comments << c2
u1.comments << c3
u2.comments << c4
u2.comments << c5
u2.comments << c6
u3.comments << c7
u3.comments << c8
u3.comments << c9

u1.locations << l1
u2.locations << l2
u3.locations << l3
