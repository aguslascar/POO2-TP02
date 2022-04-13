import empleados.*
import reciboHaberes.*

class Empresa {
	
	var property nombre = null
	var property cuit = null
	const empleados = #{}
	
	method agregarEmpleado(empleado) {
		empleados.add(empleado)
	}
	
	method totalPagoSueldos() {
		return empleados.sum{empleado => empleado.sueldoNeto()}
	}
	
	method totalSueldoBruto() {
		return empleados.sum{empleado => empleado.sueldoBruto()}
	}
	
	method totalRetenciones() {
		return empleados.sum{empleado => empleado.retenciones()}
	}
	
	method liquidarSueldos() {
		empleados.forEach{empleado => empleado.generarRecibo()}
	}
	method todosTienenRecibo() {
		return empleados.all{empleado => empleado.tieneRecibo()}
	}	
}