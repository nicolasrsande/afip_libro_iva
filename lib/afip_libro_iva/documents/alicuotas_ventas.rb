require 'afip_libro_iva/records/alicuota_venta'

module AfipLibroIva
  class AlicuotasVentas < Fixy::Document

    def initialize(alicuotas)
      @alicuotas = alicuotas
    end

    def build(@alicuotas)
      @alicuotas.each do |alicuota|
        append_record  AlicuotaVenta.new(alicuota)
      end
   end
  end
end