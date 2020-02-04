require 'fixy'
require "afip_libro_iva/version"
require 'afip_libro_iva/constants'
require "afip_libro_iva/documents/ventas"
require "afip_libro_iva/documents/compras"
require "afip_libro_iva/documents/alicuotas_ventas"
require "afip_libro_iva/documents/alicuotas_compras"
require "afip_libro_iva/fixy/formatter/numeric"
require "afip_libro_iva/fixy/formatter/numeric_currency"
require "afip_libro_iva/fixy/formatter/numeric_cot"

module AfipLibroIva
  class Error < StandardError; end

  ## Call the class with AfipLibroIva::AfipVentas.new(comprobantes). Return: Object with comprobantes and alicuotas.
  # AfipLibroIva::AfipVentas.new(comprobantes).ventas - ventas.txt
  # AfipLibroIva::AfipVentas.new(comprobantes).alicuotas_ventas - alicuotas_ventas.txt
  class AfipVentas
    def initialize(comprobantes)
      @ventas = Ventas.new(comprobantes).generate
      @alicuotas_ventas = AlicuotasVentas.new(comprobantes).generate
    end

    attr_accessor :ventas, :alicuotas_ventas
  end

  ## Call the class with AfipLibroIva::AfipCompras.new(comprobantes). Return: Object with comprobantes and alicuotas.
  # AfipLibroIva::AfipCompras.new(comprobantes).ventas - compras.txt
  # AfipLibroIva::AfipCompras.new(comprobantes).alicuotas_ventas - alicuotas_compras.txt
  class AfipCompras
    def initialize(comprobantes)
      @compras = Compras.new(comprobantes).generate
      @alicuotas_compras = AlicuotasCompras.new(alicuotas).generate
    end

    attr_accessor :compras, :alicuotas_compras
  end

end