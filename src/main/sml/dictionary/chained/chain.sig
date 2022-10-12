signature CHAIN = sig
	val get : (''k*'v) list * ''k -> 'v option
	val put : (''k*'v) list * ''k * 'v -> ((''k*'v) list * 'v option)
	val remove : (''k*'v) list * ''k -> ((''k*'v) list * 'v option)
end