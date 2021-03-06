import wollok.game.*
import gestionDelJuego.*

/**
 * Rigth Direction Object.
 */
object derecha{
	const property alLado = 1
	
	/**
	 *	Move the object to the right.
	 */
	method mover(_objeto){ _objeto.position(_objeto.position().right(1)) }
	
	/**
	 *	Move the object to the right _cant spaces.
	 */
	method mover(_objeto,_cant){ _objeto.position(_objeto.position().right(_cant)) }
	
	/**
	 *	Logic ecuation for positioning the Tetromino's blocks on right rotation proccess.
	 */
	method proximaPosRotacion(_posBloque, _posPrimerBloque) {
		const desplazamiento = game.at((_posPrimerBloque.x() - _posBloque.x()), (_posPrimerBloque.y() - _posBloque.y()))
		return game.at((-desplazamiento.y() + _posPrimerBloque.x()), (desplazamiento.x()  + _posPrimerBloque.y()))	
	}
	
	/**
	 *	Rotate the Tetrominos to the right.
	 */
	method rotar(_objeto){ 
		(_objeto.bloques()).forEach({bloque =>
			const nuevaPos = self.proximaPosRotacion(bloque.position(), _objeto.bloqueCentral().position()) 
			bloque.position(nuevaPos)
		})
	}
}

/**
 * Left Direction Object.
 */
object izquierda{
	const property alLado = -1
	
	/**
	 *	Move the object to the left.
	 */
	method mover(_objeto){ _objeto.position(_objeto.position().left(1)) }
	
	/**
	 *	Move the object to the left _cant spaces.
	 */
	method mover(_objeto,_cant){ _objeto.position(_objeto.position().left(_cant)) }
	
	/**
	 *	Logic ecuation for positioning the Tetromino's blocks on left rotation proccess.
	 */
	method proximaPosRotacion(_posBloque, _posPrimerBloque) {
		const desplazamiento = game.at((_posBloque.x() - _posPrimerBloque.x()), (_posBloque.y() - _posPrimerBloque.y()))
		return game.at((-desplazamiento.y() + _posPrimerBloque.x()), (desplazamiento.x()  + _posPrimerBloque.y()))	
	}
	
	/**
	 *	Rotate the Tetrominos to the left.
	 */
	method rotar(_objeto){ 
		(_objeto.bloques()).forEach({bloque =>
			const nuevaPos = self.proximaPosRotacion(bloque.position(), _objeto.bloqueCentral().position()) 
			bloque.position(nuevaPos)
		})
	}
}

/**
 * Up Direction Object.
 */
object arriba{
	/**
	 *	Move the object up.
	 */
	method mover(_objeto){ _objeto.position(_objeto.position().up(1)) }
	
	/**
	 *	Move the object to the up _cant spaces.
	 */
	method mover(_objeto,_cant){ _objeto.position(_objeto.position().up(_cant)) }
}

/**
 * Down Direction Object.
 */
object abajo{
	/**
	 *	Move the object down.
	 */
	method mover(_objeto){ _objeto.position(_objeto.position().down(1)) }
	
	/**
	 *	Move the object to the down _cant spaces.
	 */
	method mover(_objeto,_cant){ _objeto.position(_objeto.position().down(_cant)) }
}

/**
 * Configuration of game, keyboard, collisions, timers, etc...
 */
object configuracion{
	/**
	 *	Setup the keys for focus the block.
	 */
	method configurarTeclasPara(_manipulador) { // Configuracion de las teclas 
		keyboard.up().onPressDo		{_manipulador.rotar(derecha)	}		//Up Arrow
		keyboard.down().onPressDo	{_manipulador.bajar()			}		//Down Arrow
		keyboard.right().onPressDo	{_manipulador.moverDerecha()	}		//Right Arrow
		keyboard.left().onPressDo	{_manipulador.moverIzquierda()}		//Left Arrow
		keyboard.space().onPressDo	{_manipulador.caer()			}		//Space
		keyboard.z().onPressDo		{_manipulador.rotar(izquierda)}		//z
		keyboard.r().onPressDo		{gestionDelJuego.resetear()}
	}
	
	/**
	 *	Setup the Tetris music.
	 */
	method configurarMusica(_music){
		const music = game.sound(_music)
		music.shouldLoop(true)
		music.volume(1)
		game.onTick(100, "MUSICA", {
			if(not music.played())
				music.play()
		})
	}
}