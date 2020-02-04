module AfipLibroIva
  require "afip_libro_iva/fixy/formatter/numeric"

  class AlicuotaCompra < Fixy::Record
    include Fixy::Formatter::Alphanumeric
    include Fixy::Formatter::Numeric

    set_record_length 84

    # Fields Declaration:
    # -----------------------------------------------------------
    #       name          size      Range             Format
    # ------------------------------------------------------------
    field :tipo_comprobante,     3,     '1-3' ,      :numeric
    field :punto_venta,     5,     '4-8' ,      :numeric
    field :numero_comprobante,     20,     '9-28' ,      :numeric
    field :tipo_documento_vendedor,     2,     '29-30' ,      :numeric
    field :numero_documento_vendedor,     20,     '31-50' ,      :numeric
    field :importe_neto_gravado,     15,     '51-65' ,      :numeric
    field :alicuota_iva,     4,     '66-69' ,      :numeric
    field :impuesto_liquidado,     15,     '70-84' ,      :numeric

    def initialize(comprobante)
      comprobante[:alicuotas].each do |alicuota|
        @tipo_comprobante = comprobante[:tipo_comprobante]
        @punto_venta = comprobante[:punto_venta]
        @numero_comprobante = comprobante[:numero_comprobante]
        @tipo_documento_vendedor = comprobante[:tipo_documento_vendedor]
        @numero_documento_vendedor = comprobante[:numero_documento_vendedor]
        @importe_neto_gravado = alicuota[:importe_neto_gravado]
        @alicuota_iva = alicuota[:alicuota_iva]
        @impuesto_liquidado = alicuota[:impuesto_liquidado]
      end
    end
  end
end