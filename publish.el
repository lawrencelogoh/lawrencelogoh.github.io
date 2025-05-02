(add-to-list 'load-path "~/.config/emacs/straight/repos/weblorg")
(add-to-list 'load-path "~/.config/emacs/straight/repos/templatel")
(require 'weblorg)

(weblorg-site
 :template-vars '(("site_name" . "Lawrence Logoh")
                  ("site_owner" . "lawrencelogoh@gmail.com (Owner)")
                  ("site_description" . "Lawrence Logoh's Personal Blog")))

;; (if (string= (getenv "ENV") "prod")
;;     (setq weblorg-default-url "https://lawrencelogoh.com"))

(setq weblorg-default-url "")

;; route for rendering the homepage
;; (weblorg-route
;;  :name "index"
;;  :input-pattern "src/index.org"
;;  :template "blog_post.html"
;;  :output "index.html"
;;  :url "/")

;; route for rendering each post
(weblorg-route
 :name "blog"
 :input-pattern "blog/src/*.org"
 :template "blog_post.html"
 :output "blog/{{ slug }}.html"
 :url "/blog/{{ slug }}.html")

;; route for rendering the index page of the blog
(weblorg-route
 :name "blog index"
 :input-pattern "blog/src/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "blog_index.html"
 :output "blog/index.html"
 :url "/blog")

;; route for the rss feed
(weblorg-route
 :name "rss feed"
 :input-pattern "blog/src/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "feed.xml"
 :output "rss.xml"
 :url "/rss.xml")


;;route for rendering other "top-level" pages
(weblorg-route
 :name "pages"
 :input-pattern "src/*.org"
 :input-exclude "index\.org$"
 :template "page.html"
 :output "{{ file_slug }}/index.html"
 :url "/{{ file_slug }}")

;; route for static assets that also copies files to output directory
(weblorg-route
 :name "static"
 :template nil
 :url "/theme/static/{{ file }}")



;; fire the engine and export all the files declared in the routes above
(weblorg-export)
