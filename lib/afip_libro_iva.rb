require 'fixy'
require "afip_libro_iva/version"
require "afip_libro_iva/documents/ventas"
require "afip_libro_iva/documents/compras"
require "afip_libro_iva/documents/alicuotas_ventas"
require "afip_libro_iva/documents/alicuotas_compras"
require "afip_libro_iva/formaters/numeric"

module AfipLibroIva
  class Error < StandardError; end

  class AfipVentas
    def initialize(comprobantes, alicuotas)
      @ventas = Ventas.new(comprobantes).generate
      @alicuotas_ventas = AlicuotasVentas.new(alicuotas).generate
    end
  end

  class AfipCompras
    def initialize(comprobantes, alicuotas)
      @compras = Compras.new(comprobantes).generate
      @alicuotas_compras = AlicuotasCompras.new(alicuotas).generate
    end
  end

end