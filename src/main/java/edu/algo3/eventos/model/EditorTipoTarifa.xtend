package edu.algo3.eventos.model

import edu.algo2.eventos.TarifaFija
import edu.algo2.eventos.TarifaPorHora
import edu.algo2.eventos.TarifaPorPersona
import edu.algo2.eventos.TipoTarifa
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import edu.algo2.eventos.Servicio
import org.uqbar.commons.model.annotations.Dependencies

@Accessors
@TransactionalAndObservable
class EditorTipoTarifa {
	
	val fija = new TarifaFijaBuilder
	val porHora = new TarifaPorHoraBuilder
	val porPersona = new TarifaPorPersonaBuilder
	val tipoTarifaPosibles = newArrayList => [
		add(fija)
		add(porHora)
		add(porPersona)
	]
	TipoTarifaFactory tipoTarifaSeleccionado
	Double costoMinimo = 0.0
	Double porcentajeMinimo = 1.0
	Servicio servicio

	def TipoTarifa crearTipoTarifa() {
		tipoTarifaSeleccionado.create(costoMinimo,porcentajeMinimo)
	}

	@Dependencies("tipoTarifaSeleccionado")
	def getHabilitaCostoMinimo() {
		porHora.equals(tipoTarifaSeleccionado)
	}
	@Dependencies("tipoTarifaSeleccionado")
	def getHabilitaPorcentajeMinimo() {
		porPersona.equals(tipoTarifaSeleccionado)
	}
}

interface TipoTarifaFactory {
	def TipoTarifa create(Double costoMinimo, Double porcentajeMinimo)
}

class TarifaFijaBuilder implements TipoTarifaFactory {
	override TipoTarifa create(Double costoMinimo, Double porcentajeMinimo){
		new TarifaFija
	}
	override toString(){
		"Tarifa fija"
	}
}

class TarifaPorHoraBuilder implements TipoTarifaFactory {
	override TipoTarifa create(Double _costoMinimo, Double _porcentajeMinimo){
		new TarifaPorHora() => [costoMinimo = _costoMinimo]
	}
	override toString(){
		"Tarifa por hora"
	}	
}

class TarifaPorPersonaBuilder implements TipoTarifaFactory {
	override TipoTarifa create(Double _costoMinimo, Double _porcentajeMinimo){
		new TarifaPorPersona() => [porcentajeMinimo = _porcentajeMinimo]
	}
	override toString(){
		"Tarifa por persona"
	}
}
