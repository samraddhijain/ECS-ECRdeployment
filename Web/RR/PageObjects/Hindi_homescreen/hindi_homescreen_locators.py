hindi_menu = '//span[contains(text(),"हिंदी")]'
match_text = '//h2[@class="title"]'
view_more_link = '//a[@class="view-all"]'
filter_button = '//span[normalize-space()="Filter"]'
filter_by_year_dropdown = '//p[normalize-space()="Filter by Year"]'
filter_by_year_2023 = '//button[normalize-space()="2023"]'
apply_filter_button = '//span[normalize-space()="Apply Filters"]'
matches_2023 = '//div[@class="date-time"]//span[contains(text(),"2023")]'

parinam_text = '//span[@class="status"]'
match_card = '//div[@class="card-item recent "]'
matchcenter_button = '//span[text()="मैचसेंटर"]'
point_table_aur_dekhe_link = '//a[@href="/hi/points-table"]'
point_table_title = '//h1[@class="title"]'

# qualifier_text = '//p[@class="text qualifier-position"]'
qualifier_text = '(//div[@class="row-head"])[index]//child::p[@class="text qualifier-position" and text()="Q"]'
point_table_qualifier_text='(//div[@class="table-row table-row-head qualifier"])[index]//child::p[@class="position-indicator" and text()="Q"]'
join_now_button = '(//span[@class="btn-text" and text()="join now"])[1]'
yaha_click_kare_button = '//img[@alt="membership"]'

video_aur_dekhe_link = '//a[@href="/hi/videos"]'


squad_right_arrow = '//div[@class="swiper squad-listing swiper-initialized swiper-horizontal swiper-pointer-events"]//div[@aria-label="Next slide"]'
squad_left_arrow = '//div[@class="swiper squad-listing swiper-initialized swiper-horizontal swiper-pointer-events"]//div[@aria-label="Previous slide"]'

squad_player_name = '//div[@class="player-name"]'

# photos
aur_dekhe_photos_link='//a[@href="/hi/photos"]'
photo_card='//a[@href="https://stg-rr.sportz.io/hi/photos/rr-vs-rcb-ipl-2024-the-pink-promise-win-hindi"]//figure'
total_photo_count='//span[@class="meta-count meta"]'
photo_buttons='(//div[contains(@class,"img-4by3")]//following-sibling::button[@class="btn-more"])[1]'
photos_page_verification="//h1[text()='फ़ोटोस']"
photo_buttons_articles='//div[@class="article-thumbnail"]//following::figure[@class="img-box"]'
download_btn="//span[text()='Download']"
photo_article1='//img[@src="https://stg-rr.sportz.io/static-assets/waf-images/fd/3c/58/0/OI1aGIyLKz.jpg?v=1.38&w=400"]'
photo_article2='//img[@src="https://stg-rr.sportz.io/static-assets/waf-images/fa/1c/74/0/eVT2hqsrUI.JPG?v=1.38&w=400"]'
swipe_right='//div[@class="swiper-button-next"]'
swipe_left='//div[@class="swiper-button-prev"]'