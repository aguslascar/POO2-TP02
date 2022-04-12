import empresa.*
import reciboHaberes.*

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
		// PAra calcular la cantidad de años, divido esos dias por 365.25 que contempla los años bisiestos.
		return (fechaActual - fechaNac) / 365.25
	}
	
	method sueldoNeto() 
	method sueldoBruto()
	method retenciones(sueldoBruto)
	method generarRecibo() {
		//En la parte de desgloce, no puse ningun valor ya que no comprendi exactamente que es lo que habria que poner.
		recibo = new Recibo(nombreEmpleado = nombre, direccion = direccion, fechaEmision = fechaActual, sueldoBruto = self.sueldoBruto(), sueldoNeto = self.sueldoNeto(), desgloce = "")
		
	}
	
	method tieneRecibo() {
		return recibo != null
	}
	/* method retornarRecibo() {
		//Compruebo que el empleado tenga un recibo generado
		self.comprobarRecibo()
		return recibo
	}
	
	method comprobarRecibo() {
		if(recibo == null) {
			self.error("No se genero un recibo")
		}
	}
	*/
}

class PlantaPermanente inherits Empleado {
	const property cantHijos
	const property antiguedad
	
	override method sueldoNeto() {
		return self.retenciones(self.sueldoBruto())
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
	
	override method retenciones(sueldoBruto) {
		return ((sueldoBruto * 0.90) - 20 * cantHijos) * 0.85
	}
	
}

class PlantaTemporaria inherits Empleado {
	const property fechaFin
	const property horasExtra
	
	override method sueldoNeto() {
		return self.retenciones(self.sueldoBruto()) 
	}
	
	override method sueldoBruto() {
		return sueldoBasico + horasExtra * 40
	}
	
	override method retenciones(sueldoBruto) {
		return ((sueldoBruto * 0.90) - self.retencionMayorCincuenta()) * 0.90 - (5 * horasExtra)
	}
	method retencionMayorCincuenta() {
		if(self.edad() > 50) {
			return 25
		}
		else return 0
	}
}