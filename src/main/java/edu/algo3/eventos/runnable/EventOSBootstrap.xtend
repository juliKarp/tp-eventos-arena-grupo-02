package edu.algo3.eventos.runnable

import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.eventos.TarifaFija
import edu.algo2.eventos.TarifaPorHora
import edu.algo2.eventos.TarifaPorPersona
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoLocaciones
import edu.algo2.repositorio.RepoServicios
import edu.algo2.repositorio.RepoUsuarios
import java.time.LocalDate
import java.time.temporal.ChronoUnit
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.geodds.Point
import org.eclipse.xtend.lib.annotations.Accessors

class EventOSBootstrap extends CollectionBasedBootstrap {
	
	new() {
		ApplicationContext.instance.configureSingleton(typeof(Usuario), new RepoUsuarios)
		ApplicationContext.instance.configureSingleton(typeof(Locacion), new RepoLocaciones)
		ApplicationContext.instance.configureSingleton(typeof(Servicio), new RepoServicios)
		ApplicationContext.instance.configureSingleton(typeof(Actualizacion), new Actualizacion)
		
	}

	override run() {
		val repoUsuarios = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepoUsuarios
		val repoLocaciones = ApplicationContext.instance.getSingleton(typeof(Locacion)) as RepoLocaciones
		val repoServicios = ApplicationContext.instance.getSingleton(typeof(Servicio)) as RepoServicios

		repoUsuarios => [
			create(new Usuario("lucas_capo", tipoUsuarioFree) => [
				fechaNacimiento = LocalDate.now.minus(25, ChronoUnit.YEARS)
				direccion = new Point(-35, -60)
				nombreApellido = "Lucas Lopez"
				email = "lucas_93@hotmail.com"
			])
			create(new Usuario("martin1990", tipoUsuarioFree) => [
				fechaNacimiento = LocalDate.now.minus(28, ChronoUnit.YEARS)
				direccion = new Point(-35, -60)
				nombreApellido = "Martín Varela"
				email = "martinvarela90@yahoo.com"
			])
		]

		repoLocaciones => [
			create(new Locacion("Salón El Abierto", -34.603759, -58.381586, 200.0))
			create(new Locacion("Estadio Obras", -34.572224, -58.535651, 2000.0))
		]

		repoServicios => [
			create(new Servicio("Fotografos unidos", new Point(-34, -51), 1000.0) => [
				tipoTarifa = new TarifaFija
			])
			create(new Servicio("Show en vivo", new Point(-34, -51), 1000.0) => [
				tipoTarifa = new TarifaPorHora
			])
			create(new Servicio("Catering Food Party", new Point(-34, -51), 1000.0) => [
				tipoTarifa = new TarifaPorPersona => [porcentajeMinimo = 0.1]
			])
		]
	}
}

@Accessors
class Actualizacion {
	val actualizacionUsuarios = '[{"nombreUsuario":"nose","nombreApellido":"El Que no sabe","email":"no_se@hotmail.com","fechaNacimiento":"15/01/1992","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires","coordenadas":{"x":-34.572224,"y":51.535651}}},{"nombreUsuario":"martin1990","nombreApellido":"Martín Varela","email":"otromail@yahoo.com","fechaNacimiento":"18/11/1990","direccion":{"calle":"Av. Triunvirato","numero":4065,"localidad":"CABA","provincia":"","coordenadas":{"x":-33.58236,"y":60.516598}}}]'
	
}
