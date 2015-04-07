# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'open-uri'

# First work
scArtist = Artist.create(
  name: "Satellite Collective",
  contact: "langston.nathan@gmail.com",
  url: "http://satellitecollective.org",
  location: "New York City New York USA"
)

scWork = Work.create(
  title: "Breton Fisherman's Prayer",
  orig_id: "0001",
  full_orig_id: "0001_0000",
  medium: "Prose",
  parent_id: nil,
  artist_id: scArtist.id
)

WorkRepresentation.create(
  work_id: scWork.id,
  fileext: 'md',
  text_body_markdown: "<div style=\"font-size: 40px;\"><em>&#0147;Oh God thy sea is so great and my boat is so small.&#0147;</em><br>&#8212; Breton Fisherman&#8217;s Prayer</div>"
)

# Placeholder Curated Tour
danielPadnosCuratedTour = CuratedTour.create(
  tour_author: 'Daniel Padnos',
  tour_name: 'A Curated Tour'
)
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'Original Message: Oh god thy sea is so great and my boat is so small.')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'The first recipient of the original message works through her resistance to “ideas of godhood”, finding comfort in “the idea of an expanding cosmos”. Her naked subject launches a folded paper boat onto the sea.')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'After viewing Weaver’s painting, poet Bob Holman writes Naked Night, telling of  “…the poem that floats its message across the land that recedes to the stars themselves…” ')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'In his musical composition for the Telephone, David Williams sustains a synthesized dominant C-chord throughout the 10 minute piece. Over this, a steely electric guitar twinkles as it picks out a repetitive G-A-B-G theme that never resolves, and as the piece goes on, sounds recorded in the deserts of Utah are perhaps carrying messages back to shore.')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'From Williams’ music, Portland photographer Tom Patterson captures a decayed and abandoned pumping station and follows its pipeline to his final photo: a marvelous, natural, multi-tiered waterfall.')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'Britain’s Claire Burke viewed Patterson’s photos, and then wrote her poem “The Flow of All Things”. As you continue through the line you may discover that it serves as a genuine game-changer!')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'East village pub Jimmy’s No. 43 hosts a bimonthly reading series called Hearth Gods. Part of Hearth Gods’ 43rd session included Michael Rau’s direction and projection design with Sarah Mollo’s dramatic reading of Claire Burke’s poem. Mollo’s voice and body together with the brass instrumental accompaniment could provide a compelling eulogy at a New Orleans street funeral – or a New York East Village experience.')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'From New York Burke’s poem was sent to Buenos Aires, where Sole Majdalani transformed it into an installation made from blocks of resin with drawings, origami and lights in a glass box. To fully appreciate it, watch the film she made, which reveals her work together with the poem, bit by bit.')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'For Jana Weaver, the message flowed from the ocean to the cosmos; for Holman over land to the stars. In William’s music, the deserts of Utah and Patterson’s photos, as water through a mountain. Then Burke wrote “The Flow of All Things” about the loss of a loved one, amplified in Rau’s arousing production and then idealized in Majdalani’s elaborate sculpture. Now Chicago’s Kayce Bayer gives us his animation: “Afterlife” and the message moves on.')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'Back in the UK, Emanuela Marenz and 11 others described their ideas of heaven. Visualizing each as a photographic subject, she produced this piece, called “Heavens”.')
CuratedTourStop.create(work_id: scWork.id, curated_tour_id: danielPadnosCuratedTour.id, 
  caption_text: 'Roberta Orlando of Italy did not know the title of Marenz’s photographic collage. In fact, none of the artists were privy to the titles of the works that inspired them. Even so, her translation of the message given to her was this surprising photograph, taken in Spain, which she calls “High Set”. A full year after Jana Weaver received the sailor’s prayer, nine works of art were inspired, one after the other, traversing the United States, the Western Hemisphere and the Atlantic ocean (twice), and still reminding us of our diminutive presence beside the greatness of nature.')  
  
  
# FAKE SECURITY (it's a little sad this is the only way I know to clear the cache)
danielUser = User.create(:email => 'danieltalsky@gmail.com')
danielUser.update_password 'fatalisticfaithful'
jonathanUser = User.create(:email => 'jonathan.harford@gmail.com')
jonathanUser.update_password 'somethingwhenthepeopledo'
nathanUser = User.create(:email => 'langston.nathan@gmail.com')
nathanUser.update_password 'notsodamnedskillful'
kevinUser = User.create(:email => 'kevin@satellite-collective.org')
kevinUser.update_password 'painfullycorrect'
danielPadmosUser = User.create(:email => 'daniel@dexnewyork.com')
danielPadmosUser.update_password 'sushiisdelicious'
mattUser = User.create(:email => 'mattdabrowiak@gmail.com')
mattUser.update_password 'borneoisacountry'
ryzikUser = User.create(:email => 'ryzik@nytimes.com')
ryzikUser.update_password 'Is&&The&&Pen&&Indeed&&Mightier?'
guestUser = User.create(:email => 'preview@satellitecollective.org')
guestUser.update_password 'collectiveguest'


