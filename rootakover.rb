require 'net/http'
require 'uri'

def ascii_art
  puts "\033[91m"
  puts %q{
  ____             _                  _       _   _ _______________ 
 |  _ \  __ _ _ __| | _____  ___ _ __(_)_ __ | |_/ |___ /___ /___  |
 | | | |/ _` | '__| |/ / __|/ __| '__| | '_ \| __| | |_ \ |_ \  / / 
 | |_| | (_| | |  |   <\__ \ (__| |  | | |_) | |_| |___) |__) |/ /  
 |____/ \__,_|_|  |_|\_\___/\___|_|  |_| .__/ \__|_|____/____//_/   
                                       |_|                          
  }
  puts "\033[92mCoder By: RootAyyildiz Turkish Hacktivist\033[0m\n"
end

def http_request(url)
  uri = URI.parse(url)
  response = Net::HTTP.get(uri)
  response.force_encoding('UTF-8').scrub 
  response
end

def visit_url(url)
  response = nil
  begin
    response = http_request("http://#{url}")
    puts "HTTP üzerinden ziyaret edildi: #{url}".encode('UTF-8')
  rescue => e
    puts "HTTP başarısız: #{e.message.encode('UTF-8')}, HTTPS deneniyor...".encode('UTF-8')
    begin
      response = http_request("https://#{url}")
      puts "HTTPS üzerinden ziyaret edildi: #{url}".encode('UTF-8')
    rescue => e
      puts "HTTPS başarısız: #{e.message.encode('UTF-8')}, URL kontrol edilemedi: #{url}".encode('UTF-8')
    end
  end
  response
end

def takeover_kontrol(url, belirtiler)
  puts "Ziyaret ediliyor: #{url}".encode('UTF-8')
  response = visit_url(url)

  if response
    belirtiler.each do |platform, belirti|
      if response =~ /#{belirti}/
        puts "Takeover tespit edildi: #{url} (#{platform})".encode('UTF-8')
        return true
      end
    end
    puts "Takeover tespit edilmedi: #{url}".encode('UTF-8')
  else
    puts "Ziyaret edilemedi: #{url}".encode('UTF-8')
  end
  false
end

def url_isle(file_path, belirtiler)
  takeover_bulundu = false
  takeover_dosyasi = nil

  File.readlines(file_path).each do |url|
    url.strip!
    if takeover_kontrol(url, belirtiler)
      takeover_bulundu = true
      takeover_dosyasi ||= File.open("takeoverlar.txt", "w")
      takeover_dosyasi.puts "Takeover tespit edildi: #{url}".encode('UTF-8')
    end
  end

  if takeover_dosyasi
    takeover_dosyasi.close
    puts "Tespit edilen takeover'lar 'takeoverlar.txt' dosyasına kaydedildi.".encode('UTF-8')
  else
    puts "Hiç takeover tespit edilmedi, dosya oluşturulmadı.".encode('UTF-8')
  end
end

belirtiler = {
  "AWS/S3" => "The specified bucket does not exist",
  "BitBucket" => "Repository not found",
  "Github" => "There isn\\\'t a Github Pages site here\.|a Github Pages site here",
  "Shopify" => "Sorry\, this shop is currently unavailable\.",
  "Fastly" => "Fastly error\: unknown domain\:",
  "Ghost" => "The thing you were looking for is no longer here\, or never was",
  "Heroku" => "no-such-app.html|<title>no such app</title>|herokucdn.com/error-pages/no-such-app.html|No such app",
  "Pantheon" => "The gods are wise, but do not know of the site which you seek|404 error unknown site",
  "Tumbler" => "Whatever you were looking for doesn\\\'t currently exist at this address.",
  "Wordpress" => "Do you want to register",
  "TeamWork" => "Oops - We didn\'t find your site.",
  "Helpjuice" => "We could not find what you\'re looking for.",
  "Helpscout" => "No settings were found for this company:",
  "Cargo" => "<title>404 &mdash; File not found</title>",
  "Uservoice" => "This UserVoice subdomain is currently available",
  "Surge.sh" => "project not found",
  "Intercom" => "This page is reserved for artistic dogs\.|Uh oh\. That page doesn\'t exist</h1>",
  "Webflow" => "<p class=\"description\">The page you are looking for doesn\'t exist or has been moved.</p>|The page you are looking for doesn\'t exist or has been moved",
  "Kajabi" => "<h1>The page you were looking for doesn\'t exist.</h1>",
  "Thinkific" => "You may have mistyped the address or the page may have moved.",
  "Tave" => "<h1>Error 404: Page Not Found</h1>",
  "Wishpond" => "<h1>https://www.wishpond.com/404?campaign=true",
  "Aftership" => "Oops.</h2><p class=\"text-muted text-tight\">The page you\'re looking for doesn\'t exist.",
  "Aha" => "There is no portal here \.\.\. sending you back to Aha!",
  "Tictail" => "to target URL: <a href=\"https://tictail.com|Start selling on Tictail.",
  "Brightcove" => "<p class=\"bc-gallery-error-code\">Error Code: 404</p>",
  "Bigcartel" => "<h1>Oops! We couldn&#8217;t find that page.</h1>",
  "ActiveCampaign" => "alt=\"LIGHTTPD - fly light.\"",
  "Campaignmonitor" => "Double check the URL or <a href=\"mailto:help@createsend.com|Trying to access your account",
  "Acquia" => "The site you are looking for could not be found.|If you are an Acquia Cloud customer and expect to see your site at this address|Web Site Not Found",
  "Proposify" => "If you need immediate assistance, please contact <a href=\"mailto:support@proposify.biz",
  "Simplebooklet" => "We can\'t find this <a href=\"https://simplebooklet.com",
  "GetResponse" => "With GetResponse Landing Pages, lead generation has never been easier",
  "Vend" => "Looks like you\'ve traveled too far into cyberspace.",
  "Jetbrains" => "is not a registered InCloud YouTrack.",
  "Smartling" => "Domain is not configured",
  "Pingdom" => "pingdom|Sorry, couldn\'t find the status page",
  "Tilda" => "Domain has been assigned|Please renew your subscription",
  "Surveygizmo" => "data-html-name",
  "Mashery" => "Unrecognized domain <strong>|Unrecognized domain",
  "Divio" => "Application not responding",
  "Feedpress" => "The feed has not been found.",
  "Readme.io" => "Project doesnt exist... yet!",
  "Statuspage" => "You are being <a href=\'https>",
  "Zendesk" => "Help Center Closed",
  "Worksites.net" => "Hello! Sorry, but the website you’re looking for doesn’t exist.",
  "Agile CRM" => "this page is no longer available",
  "Anima" => "try refreshing in a minute|this is your website and you've just created it",
  "Fly.io" => "404 Not Found",
  "Gemfury" => "This page could not be found",
  "HatenaBlog" => "404 Blog is not found",
  "Kinsta" => "No Site For Domain",
  "LaunchRock" => "It looks like you may have taken a wrong turn somewhere|worry...it happens to all of us",
  "Ngrok" => "ngrok.io not found",
  "SmartJobBoard" => "This job board website is either expired or its domain name is invalid",
  "Strikingly" => "page not found",
  "Tumblr" => "Whatever you were looking for doesn\'t currently exist at this address",
  "Uberflip" => "hub domain\, The URL you\'ve accessed does not provide a hub",
  "Unbounce" => "The requested URL was not found on this server",
  "Uptimerobot" => "page not found"
}

ascii_art
puts "Lütfen URL'lerin bulunduğu .txt dosyasının yolunu girin: ".encode('UTF-8')
file_path = gets.chomp.encode('UTF-8')

if File.exist?(file_path)
  url_isle(file_path, belirtiler)
else
  puts "Dosya bulunamadı!".encode('UTF-8')
end
