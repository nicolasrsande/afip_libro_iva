require 'afip_libro_iva/records/alicuota_compra'

module AfipLibroIva
  class AlicuotasCompras < Fixy::Document

    def initialize(alicuotas)
      @alicuotas = alicuotas
    end

    def build
      @alicuotas.each do |alicuota|
        append_record  AlicuotaCompra.new(alicuota)
      end
    end
  end
end