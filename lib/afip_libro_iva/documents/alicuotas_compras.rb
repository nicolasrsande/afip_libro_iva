require 'afip_libro_iva/records/alicuota_compra'

module AfipLibroIva
  class AlicuotasCompras < Fixy::Document

    def initialize(comprobantes)
      @comprobantes = comprobantes
    end

    def build
      @comprobantes.each do |comprobante|
        comprobante[:alicuotas].each do |alicuota|
          append_record  AlicuotaCompra.new(comprobante, alicuota)
        end
      end
    end
  end
end