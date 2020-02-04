require 'fixy'
require "afip_libro_iva/version"
require "afip_libro_iva/documents/ventas"
require "afip_libro_iva/documents/compras"
require "afip_libro_iva/documents/alicuotas_ventas"
require "afip_libro_iva/documents/alicuotas_compras"
require "afip_libro_iva/fixy/formatter/numeric"

module AfipLibroIva
  class Error < StandardError; end

  class AfipVentas
    def initialize(comprobantes)
      @ventas = Ventas.new(comprobantes).generate
      @alicuotas_ventas = AlicuotasVentas.new(comprobantes).generate
    end
  end

  class AfipCompras
    def initialize(comprobantes)
      @compras = Compras.new(comprobantes).generate
      @alicuotas_compras = AlicuotasCompras.new(alicuotas).generate
    end
  end

end