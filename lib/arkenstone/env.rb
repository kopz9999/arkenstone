module Arkenstone
  class Environment
    attr_accessor :url, :verb, :body

    def initialize(options)
      options.each do |key, value|
        self.send("#{key}=".to_sym, value) if self.respond_to? key
      end
    end

    def build_request
      klass = eval("Net::HTTP::#{@verb.capitalize}")
      request = klass.new URI(@url)
      unless @body.nil?
        if body.class == Proc
          body[request]
        else
          request.body = body
        end
      end
      #binding.pry
      request
    end

    def to_s
      "#{@verb} #{@url}\n#{@body}"
    end
  end
end