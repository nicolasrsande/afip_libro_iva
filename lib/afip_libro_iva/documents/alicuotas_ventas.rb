require 'afip_libro_iva/records/alicuota_venta'

module AfipLibroIva
  class AlicuotasVentas < Fixy::Document

    def initialize(comprobantes)
      @comprobantes = comprobantes
    end

    def build
      @comprobantes.each do |comprobante|
        comprobante[:alicuotas].each do |alicuota|
          append_record  AlicuotaVenta.new(comprobante, alicuota)
        end
      end
   end
  end
end