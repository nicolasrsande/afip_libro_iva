module AfipLibroIva
  class AlicuotaVenta < Fixy::Record
    include Fixy::Formatter::Alphanumeric
    include Fixy::Formatter::Numeric


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

    def initialize(alicuota)
      @tipo_comprobante = alicuota:[tipo_comprobante]
      @punto_venta = alicuota[:punto_venta]
      @numero_comprobante = alicuota[:numero_comprobante]
      @importe_neto_gravado = alicuota[:importe_neto_gravado]
      @alicuota_iva = alicuota[:alicuota_iva]
      @impuesto_liquidado = alicuota[:impuesto_liquidado]
    end

  end
end