package edu.algo3.eventos.runnable

import edu.algo2.eventos.config.ServiceBootstrap
import edu.algo2.eventos.config.ServiceLocator
import edu.algo2.eventos.Evento
import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.eventos.Usuario
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext

class EventOSBootstrap extends CollectionBasedBootstrap {

	new() {
		ApplicationContext.instance.configureSingleton(typeof(Usuario), ServiceLocator.instance.repoUsuarios)
		ApplicationContext.instance.configureSingleton(typeof(Locacion), ServiceLocator.instance.repoLocaciones)
		ApplicationContext.instance.configureSingleton(typeof(Servicio), ServiceLocator.instance.repoServicios)
		ApplicationContext.instance.configureSingleton(typeof(Evento), ServiceLocator.instance.repoEventos)
	}

	override run() {
		ServiceBootstrap.run
	}
	
}
