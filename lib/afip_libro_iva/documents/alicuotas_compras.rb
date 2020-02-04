require 'afip_libro_iva/records/alicuota_compra'

module AfipLibroIva
  class AlicuotasCompras < Fixy::Document

    def initialize(comprobantes)
      @comprobantes = comprobantes
    end

    def build
      @comprobantes.each do |comprobante|
        append_record  AlicuotaCompra.new(comprobante)
      end
    end
  end
end