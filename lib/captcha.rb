require 'sinatra/captcha'

class Captcha

  def check_captcha(code)
    code  = code.gsub(/\W/, '')
    open("http://captchator.com/captcha/check_answer/8283/#{code}").read.to_i.nonzero?
  end

end