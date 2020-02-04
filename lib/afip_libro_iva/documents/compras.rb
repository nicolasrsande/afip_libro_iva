require "afip_libro_iva/records/comprobante_compra"

module AfipLibroIva
  class Compras < Fixy::Document

    def initialize(comprobantes)
      @comprobantes = comprobantes
    end

    def build(@comprobantes)
      @comprobantes.each do |comprobante|
        append_record  ComprobanteCompra.new(comprobante)
      end
    end
  end
end