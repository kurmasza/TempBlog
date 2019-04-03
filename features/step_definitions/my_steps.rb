puts "In my_steps"

When(/^I visit the posts page$/) do
  visit posts_url
end

And(/^I click on "([^"]*)"$/) do |text|
  find('a', text: text).click
end

Then(/^I should see the new post form$/) do

  # Don't need any asserts.  Will fail if not found
  find_by_id('post_title')
  find_button('Create Post')
end

When(/^I fill in and submit the New Post form$/) do
  fill_in('post_title', with: "War and Peace")
  fill_in('post_article', with: "It was a dark and stormy night....")
  fill_in('post_likes', with: '423')
  select("unpublished", from: 'post_status').click
  select("Jones, Davy", from: 'post_author_id').click
  find_button('Create Post').click

  save_and_open_page
end

Then(/^I should see all "([^"]*)" posts$/) do |num_posts|
  all_rows = page.all(:xpath, "//table//tbody//tr")
  expect(all_rows.count).to eq(num_posts.to_i)
end

Then(/^I should see the Post Created page$/) do
 expect(page).to have_content("Post was successfully created")

 # Using ids would make this test stronger
 expect(page).to have_content("War and Peace")
end

And(/^I should see "([^"]*)"$/) do |text|
  expect(page).to have_content(text)
end