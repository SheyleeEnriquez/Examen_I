class Consumos {
  double velocidadMedia;
  double totalLitros;
  double consumoPorKm;
  double consumoCada100Km;

  Consumos({
    required this.velocidadMedia,
    required this.totalLitros,
    required this.consumoPorKm,
    required this.consumoCada100Km,
  });
}

Consumos calcularConsumos(double km, int horas, int minutos, double precio, double dinero) {
  double minutosTotales = (60 * horas + minutos).toDouble();
  double dineroGastado = dinero / precio;

  double velocidadMedia = (km / minutosTotales) * 60;
  double consumoPorKm = dineroGastado / km;
  double consumoCada100Km = consumoPorKm * 100;

  return Consumos(
    velocidadMedia: velocidadMedia,
    totalLitros: dineroGastado,
    consumoPorKm: consumoPorKm,
    consumoCada100Km: consumoCada100Km,
  );
}
