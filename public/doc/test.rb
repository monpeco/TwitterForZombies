arr = ["a", "a", "a", "a", "b", "c", "c", "a", "a", "d", "e", "e", "e", "e"]

resultado = Array.new

#condiciones iniciales
c = 0;
anterior = nil
inicio = true
ultimo = Array.new(2)

#iteramos por cada elemento
arr.each do |letter|
  if (inicio)            #determinamos si es el inicio del arreglo arr
    anterior  = letter
    inicio = false
  end
  
  if(!inicio)            #sino es el inicio
      if anterior == letter  #comparamos cada letra con su anterior
         c = c + 1 
         
      else                   #cuando no es igual, tenemos el final de una "serie de elementos consecutivos duplicados"
          a = Array.new(2)

          a[0] = c
          a[1] = anterior

          resultado << a
          anterior = letter
          c = 1
      end
      
     ultimo[1] = letter     #para la inserción del último elemento del array
     ultimo[0] = c 
  end

end
resultado << ultimo

puts resultado.inspect