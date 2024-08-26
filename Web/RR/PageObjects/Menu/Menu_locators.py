latest_nav = "//span[normalize-space()='Latest']"
ipl_24_nav = "//span[normalize-space()='IPL 2024']"
fanzone_nav= "//span[normalize-space()='Fan Zone']"
royals_corner_nav = "//span[normalize-space()='Royals Corner']"
news = "//span[normalize-space()='News']"
videos = "//span[normalize-space()='Videos']"
photos = "//span[normalize-space()='Photos']"
press_release = "//span[normalize-space()='Press Releases']"
newsletter = "//span[normalize-space()='Newsletters']"
squad= "//span[normalize-space()='Squad']"
matches= "//span[normalize-space()='Matches']"
points_table = "//span[normalize-space()='Points Table']"
stats = "//span[normalize-space()='Stats']"
auction="//span[normalize-space()='Auction']"
quizzerr="//span[normalize-space()='QuizzeRR']"
predictor = "//span[normalize-space()='Predictor']"
fanpoll = "//span[normalize-space()='Fan Poll']"
fan_blogs = " //span[normalize-space()='Fan Blogs']"
hindi_nav = "//span[text()='हिंदी']"

# page  verification
news_page = '//h1[text()="News"]'
videos_page = '//h1[text()="Videos"]'
photos_page = '//h1[text()="Photos"]'
press_release_page = '//h1[text()="Press Releases"]'
newsletter_page = '//button[text()="Login to Download"]'
squad_page = "//span[text()='Support Staff']"
matches_page = "//h1[text()='Matches']"
points_table_page = "//h1[text()='Points Table']"
stats_page = '//h1[text()="Stats"]'
auction_page = "//h3[text()='Players Bought']"
royals_academy_page = '//h1[text()="Welcome to the Rajasthan Royals Academy"]'
royal_rajasthan_foundation_page = "//span[text()='Donation']"
hindi_page = "//h2[text()='मैच']"
quizzerr_page = "//div[text()='Let’s get QUIZZING!']"
royal_school_of_business_page = '//section[@class="navbar-section"]'


# url verification
player_profile_url= 'https://stg-rr.sportz.io/rr-players/dhruv-jurel-ipl-profile-71370'

# profile verification for squad
view_profile ='//p[text()="Dhruv"]//parent::Div//following-sibling::div[@class="player-stats-list"]//child::div[@class="card-action"]//child::a[@title="View Profile"]'
# player_card="//p[text()='Dhruv']//ancestor::div[contains(@class,'squad-item')]"
player_card ="//p[text()='Dhruv']//parent::div[@class='player-name']"
merchandise ='//p[text()="Dhruv"]//parent::Div//following-sibling::div[@class="player-stats-list"]//child::div[@class="card-action"]//child::a[@title="Merchandise"]'
date_of_birth = "//p[text()='born']//following-sibling::p"
batting_style = "//p[text()='Batting Style']//following-sibling::p"
bowling_style = "//p[text()='Bowling Style']//following-sibling::p"
player_name ='//h1[@class="player-name"]'

# upper menu
royals_academy_nav = "//span[text()='Royals Academy']"
royals_school_of_buisness_nav = "//span[text()='Royals School of Business']"
royal_rajasthan_foundation = "//span[text()='Royal Rajasthan Foundation']"
# player's ipl stats
ipl_stats_name = '//h2[@class="title"]//parent::div[@class="stats-head"]'