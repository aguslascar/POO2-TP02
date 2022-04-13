import empresa.*
import reciboHaberes.*

//Ejercicio 1

class Empleado {
	
	const property nombre
	const property direccion
	const property estadoCivil
	const property fechaNac
	const property sueldoBasico
	const fechaActual = new Date()
	var recibo = null
	
	method edad() {
		// Al restar la fecha de nacimiento a la fecha actual, me da un numero que es la cantidad de dias que tiene la persona. 
		// Para calcular la cantidad de años, divido esos dias por 365.25 que contempla los años bisiestos.
		return (fechaActual - fechaNac) / 365.25
	}
	
	method sueldoNeto() 
	method sueldoBruto()
	method retenciones()
	method retencionOS() {
		//Retencion obra social
		return 0.10
	}
	
	method retencionAportes() 
	
	method generarRecibo() {
		//En la parte de desgloce, no puse ningun valor ya que no comprendi exactamente que es lo que habria que poner.
		recibo = new Recibo(nombreEmpleado = nombre, direccion = direccion, fechaEmision = fechaActual, sueldoBruto = self.sueldoBruto(), sueldoNeto = self.sueldoNeto(), desgloce = "")
		
	}
	
	method tieneRecibo() {
		return recibo != null
	}
}

class PlantaPermanente inherits Empleado {
	const property cantHijos
	const property antiguedad
	
	override method sueldoNeto() {
		return self.sueldoBruto() - self.retenciones()
	}
	
	override method sueldoBruto() {
		return sueldoBasico + self.salarioFamiliar()
	}
	method salarioFamiliar() {
		return self.asignacionHijos() + self.asignacionConyuge() + self.plusAntiguedad()
	}
	
	method asignacionHijos() {
		return cantHijos * 150
	}
	
	method asignacionConyuge() {
		if(estadoCivil == "Casado") {
			return 100
		}
		else return 0
	}
	
	method plusAntiguedad() {
		return antiguedad * 50
		
	}
	
	override method retenciones() {
		return self.sueldoBruto() * (self.retencionOS() + self.retencionAportes()) + self.retencionHijo(cantHijos)
	}
	
	override method retencionAportes() {
		return 0.15
	}
	
	method retencionHijo(cantidad) {
		return 20 * cantidad
	}
	
}

class PlantaTemporaria inherits Empleado {
	const property fechaFin
	const property horasExtra
	
	override method sueldoNeto() {
		return self.sueldoBruto() - self.retenciones() 
	}
	
	override method sueldoBruto() {
		return sueldoBasico + horasExtra * 40
	}
	
	override method retenciones() {
		return self.sueldoBruto() * (self.retencionOS() + self.retencionAportes()) + self.retencionMayorCincuenta() + self.retencionHsExtra(horasExtra)
	}
	method retencionMayorCincuenta() {
		if(self.edad() > 50) {
			return 25
		}
		else return 0
	}
	
	override method retencionAportes() {
		return 0.10
	}
	method retencionHsExtra(cantHoras) {
		return 5 * cantHoras
	}
}

//Ejercicio 2 

/*c) Para realizar esta extensión del modelo, ¿necesitó modificar la clase Empresa? ¿Por qué?
 * 
 * No debo modificar la clase Empresa, ya que como estoy utilizando la herencia y el polimorfismo para cada tipo de empleado,
 * todos los tipos de empleados entienden los mismos mensajes. 
 */

class Contratado inherits Empleado {
	const property numContrato
	const property medioPago
	
	override method sueldoBruto() {
		return sueldoBasico
	}
	
	override method sueldoNeto() {
		return self.sueldoBruto() - self.retenciones()
	}
	
	override method retenciones() {
		return self.sueldoBruto() * (self.retencionOS() + self.retencionAportes()) + self.gastosAdministrativos()
	}
	
	override method retencionAportes() {
		//Aca no me quedo claro cuanto seria la retencion por aportes del empleado contratado asi que utilice el mismo valor que PlantaTemporaria
		return 0.10
	}
	
	method gastosAdministrativos() {
		return 50
	}
}