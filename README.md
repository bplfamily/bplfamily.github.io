# Bitcoin Gang

Steps to run locally:
1. Clone repository and open folder in terminal
2. Ensure ruby and rubygems is installed (run `gem env` to check)
3. Run the following in the folder:

		bundle install jekyll
		bundle install --gemfile=.env-files/Gemfile.github
		bundle install --gemfile=.env-files/Gemfile.gitlab
		jekyll serve --incremental

4. Open `localhost:4000` in your web-browser
