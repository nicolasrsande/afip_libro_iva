module AfipLibroIva
  require "afip_libro_iva/fixy/formatter/numeric"
  require "afip_libro_iva/fixy/formatter/numeric_currency"
  require 'afip_libro_iva/constants'

  class AlicuotaVenta < Fixy::Record
    include Fixy::Formatter::Alphanumeric
    include Fixy::Formatter::Numeric
    include Fixy::Formatter::NumericCurrency


    set_record_length 62

    # Fields Declaration:
    # -----------------------------------------------------------
    #       name          size      Range             Format
    # ------------------------------------------------------------
    field :tipo_comprobante,     3,     '1-3' ,      :numeric
    field :punto_venta,     5,     '4-8' ,      :numeric
    field :numero_comprobante,     20,     '9-28' ,      :numeric
    field :importe_neto_gravado,     15,     '29-43' ,      :numeric
    field :alicuota_iva,     4,     '44-47' ,      :numeric
    field :impuesto_liquidado,     15,     '48-62' ,      :numeric

    def initialize(comprobante)
      comprobante[:alicuotas].each do |alicuota|
        @tipo_comprobante = comprobante[:tipo_comprobante]
        @punto_venta = comprobante[:punto_venta]
        @numero_comprobante = comprobante[:numero_comprobante]
        @importe_neto_gravado = alicuota[:importe_neto_gravado]
        @alicuota_iva = TIPO_ALICUOTA.fetch(alicuota[:alicuota_iva])
        @impuesto_liquidado = alicuota[:impuesto_liquidado]
      end
    end
  end
end