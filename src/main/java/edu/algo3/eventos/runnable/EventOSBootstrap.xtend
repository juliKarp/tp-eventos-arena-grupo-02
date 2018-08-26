package edu.algo3.eventos.runnable

import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoUsuarios

class EventOSBootstrap extends CollectionBasedBootstrap {
	
	new() {
		ApplicationContext.instance.configureSingleton(typeof(Usuario), new RepoUsuarios)
	}
	
	override run() {
		val repoUsuarios = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepoUsuarios
	}
}