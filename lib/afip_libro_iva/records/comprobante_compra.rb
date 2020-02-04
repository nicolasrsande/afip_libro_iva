module AfipLibroIva
  require "afip_libro_iva/fixy/formatter/numeric"
  require "afip_libro_iva/fixy/formatter/numeric_currency"
  require "afip_libro_iva/fixy/formatter/numeric_cot"

  class ComprobanteCompra < Fixy::Record
    include Fixy::Formatter::Alphanumeric
    include Fixy::Formatter::Numeric
    include Fixy::Formatter::NumericCurrency
    include Fixy::Formatter::NumericCot

    set_record_length 325

    # Fields Declaration:
    # -----------------------------------------------------------
    #       name          size      Range             Format
    # ------------------------------------------------------------
    field :fecha,     8,     '1-8' ,      :numeric
    field :tipo_comprobante ,     3,     '9-11',      :numeric
    field :punto_venta ,     5,     '12-16',      :numeric
    field :numero_comprobante ,     20,     '17-36',      :numeric
    field :despacho_importacion ,     16,     '37-52',      :alphanumeric
    field :cod_documento_vendedor ,     2,     '53-54',      :numeric
    field :numero_identificador_vendedor,     20,     '55-74',      :alphanumeric
    field :identificacion_vendedor ,     30,     '75-104',      :alphanumeric
    field :importe_total ,     15,     '105-119',      :numeric_currency
    field :importe_no_gravado ,     15,     '120-134',      :numeric_currency
    field :importe_exento ,     15,     '135-149',      :numeric_currency
    field :importe_pagos_a_cuenta_iva ,     15,     '150-164',      :numeric_currency
    field :importe_nacionales ,     15,     '165-179',      :numeric_currency
    field :importe_iibb ,     15,     '180-194',      :numeric_currency
    field :importe_municipales ,     15,     '195-209',      :numeric_currency
    field :importe_internos ,     15,     '210-224',      :numeric_currency
    field :codigo_moneda ,     3,     '225-227',      :alphanumeric
    field :tipo_cambio ,     10,     '228-237',      :numeric_cot
    field :cantidad_alicuotas ,     1,     '238-238',      :numeric
    field :codigo_operacion ,     1,     '239-239',      :alphanumeric
    field :credito_fiscal_computable ,     15,     '240-254',      :numeric_currency
    field :importe_otros_tributos ,     15,     '255-269',      :numeric_currency
    field :cuit_emisor_corredor ,     11,     '270-280',      :numeric
    field :denominacion_corredor ,     30,     '281-310',      :alphanumeric
    field :iva_comision ,     15,     '311-325',      :numeric_currency

    def initialize(comprobante)
      @fecha = comprobante[:fecha].strftime('%Y%m%d')
      @tipo_comprobante = comprobante[:tipo_comprobante]
      @punto_venta = comprobante[:punto_venta]
      @numero_comprobante = comprobante[:numero_comprobante]
      @despacho_importacion = comprobante[:despacho_importacion] || 0
      @cod_documento_vendedor = comprobante[:cod_documento_vendedor] || 80
      @numero_identificador_vendedor = comprobante[:numero_identificador_vendedor]
      @identificacion_vendedor = comprobante[:identificacion_vendedor].truncate(29) || 'SIN IDENTIFICAR'
      @importe_total = total(comprobante)
      @importe_no_gravado = comprobante[:importe_no_gravado] || 0
      @importe_exento = comprobante[:importe_exento] || 0
      @importe_pagos_a_cuenta_iva = comprobante[:importe_pagos_a_cuenta_iva] || 0
      @importe_nacionales = comprobante[:importe_nacionales] || 0
      @importe_iibb = comprobante[:importe_iibb] || 0
      @importe_municipales = comprobante[:importe_municipales] || 0
      @importe_internos = comprobante[:importe_internos] || 0
      @codigo_moneda = comprobante[:moneda] || 'PES'
      @tipo_cambio = comprobante[:tipo_cambio] || 1
      @cantidad_alicuotas = comprobante[:alicuotas].count
      @codigo_operacion = comprobante[:codigo_operacion] || 0
      @credito_fiscal_computable = comprobante[:credito_fiscal_computable] || 0
      @importe_otros_tributos = comprobante[:otros_tributos] || 0
      @cuit_emisor_corredor = comprobante[:cuit_emisor_corredor] || 0
      @denominacion_corredor = comprobante[:denominacion_corredor] || ''
      @iva_comision = comprobante[:iva_comision] || 0
    end

    attr_reader :fecha, :tipo_comprobante, :punto_venta, :numero_comprobante, :despacho_importacion, :cod_documento_vendedor, :identificacion_vendedor,
                :numero_identificador_vendedor, :importe_total, :importe_no_gravado, :importe_pagos_a_cuenta_iva, :importe_exento, :importe_nacionales,
                :importe_iibb, :importe_municipales, :importe_internos, :codigo_moneda, :tipo_cambio, :cantidad_alicuotas, :codigo_operacion, :importe_otros_tributos,
                :credito_fiscal_computable, :cuit_emisor_corredor, :denominacion_corredor, :iva_comision

    def total(comprobante) # Calcularemos el total en base a las alicuotas y impuestos para que el valor sea exacto.
      importe_total = 0
      importe_total += comprobante.values_at(:importe_internos, :importe_exento, :importe_iibb, :importe_municipales,
                                             :importe_a_cuenta_iva, :importe_no_gravado, :importe_nacionales).compact.reduce(0, :+)
      comprobante[:alicuotas].each do |alicuota|
        importe_total += alicuota.values_at(:importe_neto_gravado, :impuesto_liquidado).compact.reduce(0, :+)
      end
      importe_total
    end
  end
end