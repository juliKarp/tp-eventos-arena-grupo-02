package edu.algo3.eventos.model

import edu.algo2.eventos.TarifaFija
import edu.algo2.eventos.TarifaPorHora
import edu.algo2.eventos.TarifaPorPersona
import edu.algo2.eventos.TipoTarifa
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.TransactionalAndObservable
import edu.algo2.eventos.Servicio

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
	TipoTarifaFactory tipoTarifaSeleccionado = fija
	Double valor
	Servicio servicio

	def TipoTarifa crearTipoTarifa(){
		tipoTarifaSeleccionado.create(valor)
	}
}

interface TipoTarifaFactory {
	def TipoTarifa create(Double valor)
}

class TarifaFijaBuilder implements TipoTarifaFactory {
	override TipoTarifa create(Double valor){
		new TarifaFija
	}
	override toString(){
		"Tarifa fija"
	}
}

class TarifaPorHoraBuilder implements TipoTarifaFactory {
	override TipoTarifa create(Double valor){
		new TarifaPorHora() => [costoMinimo = valor]
	}
	override toString(){
		"Tarifa por hora"
	}	
}

class TarifaPorPersonaBuilder implements TipoTarifaFactory {
	override TipoTarifa create(Double valor){
		new TarifaPorPersona() => [porcentajeMinimo = valor]
	}
	override toString(){
		"Tarifa por persona"
	}
}
