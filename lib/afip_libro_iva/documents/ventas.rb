require "afip_libro_iva/records/comprobante_venta"

module AfipLibroIva
  class Ventas < Fixy::Document

    def initialize(comprobantes)
      @comprobantes = comprobantes
    end

    def build(@comprobantes)
      @comprobantes.each do |comprobante|
        append_record  ComprobanteVenta.new(comprobante)
      end
    end
  end
end