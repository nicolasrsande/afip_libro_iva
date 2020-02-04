require 'afip_libro_iva/records/alicuota_venta'

module AfipLibroIva
  class AlicuotasVentas < Fixy::Document

    def initialize(comprobantes)
      @comprobantes = comprobantes
    end

    def build
      @comprobantes.each do |comprobante|
        append_record  AlicuotaVenta.new(comprobante)
      end
   end
  end
end