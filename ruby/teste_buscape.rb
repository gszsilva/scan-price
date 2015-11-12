require 'net/http'
require 'json'
require "active_support/core_ext/hash"

def buscaproduto(barras)
	url = URI.parse("http://sandbox.buscape.com/service/findProductList/645337496c6b4432696e513d/?keyword=#{barras}&format=json")
	req = Net::HTTP::Get.new(url.to_s)
	res = Net::HTTP.start(url.host, url.port) {|http|
		http.request(req)
	}
	json = JSON.parse(res.body)
	if json["totalresultsreturned"] > 0
		base = json["product"][0]["product"]
		resultados = Hash.new
		resultados["nome"]= base["productname"]
		resultados["valormin"]= base["pricemin"]
		resultados
	else
		raise "Produto não encontrado"
	end
end

puts
puts "Busca de produto"
puts "Digite o código de barras"
puts
keyword = gets
puts

resultados = buscaproduto(keyword)

puts "Produto: #{resultados["nome"]}"
puts "Valor mínimo: #{resultados["valormin"]}"