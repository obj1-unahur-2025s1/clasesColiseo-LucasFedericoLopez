class ArmasFilo {
  var property filo
  const property longitud
  method valorAtaque() = filo * longitud
}
class ArmasContundentes{
  const property peso
  method valorAtaque() = peso 
}
object casco {
  method defensa(unGladiador) = 10
}
object escudo {
  method defensa(unGladiador) = 5 + unGladiador.destreza() * 0.10
}
class Mirmillon{
  var vida = 100
  const property arma
  var property armadura
  var property fuerza
  method destreza() = 15
  method poderAtaque() = arma.valorAtaque() + fuerza
  method defensa() = armadura.defensa() + self.destreza()
  method atacarA(unGladiador){
    unGladiador.recibirAtaque(self.poderAtaque() - unGladiador.defensa())
  }
  method recibirAtaque(unAtaque){
    vida = 0.max(unAtaque)
  }
  method pelear(unGladiador){
    self.atacarA(unGladiador)
    unGladiador.atacarA(self)
  }
   method puedePelar() = vida > 1
   method crearUnGrupo(otroGladiador){
    const grupo1 = new Grupo(gladiadores = [self,otroGladiador],nombre = "mirmillolandia")
    return grupo1
  }
}
class Dimachaerus {
  var vida = 100
  const property armas = []
  var property destreza
  method fuerza() = 10
  method poderDeArmas() = armas.sum({a=>a.valorAtaque()})
  method poderAtaque() = self.fuerza() + self.poderDeArmas()
  method defensa() = destreza / 2
  method atacarA(unGladiador){
    unGladiador.recibirAtaque(self.poderAtaque() - unGladiador.defensa())
    destreza += 1
  }
  method recibirAtaque(unAtaque){
    vida = 0.max(unAtaque)
  }
  method pelear(unGladiador){
    self.atacarA(unGladiador)
    unGladiador.atacarA(self)
  }
  method puedePelar() = vida >= 1
  method crearUnGrupo(otroGladiador){
    const grupo2 = new Grupo(gladiadores = [self,otroGladiador],
                  nombre = "D-" + (self.poderAtaque() + otroGladiador.poderAtaque()))
    return grupo2
  }
}
class Grupo{
  const gladiadores = []
  const property nombre
  var peleas = 0
  method agregarGladiador(unGladiador){
    gladiadores.add(unGladiador)
  } 
  method quitarGladiador(unGladiador){
    gladiadores.remove(unGladiador)
  }
  method gladiadoresQuePuedenPelear() = gladiadores.filter({g=>g.puedePelear()})
  method campeon() = self.gladiadoresQuePuedenPelear().max({g=>g.poderAtaque()})
  method aumentarPeleas(){
        peleas += 1
    }

  method combatirContra(unGrupo){
      self.aumentarPeleas()
      unGrupo.aumentarPeleas()
      (1..3).forEach({
          round=>
          self.campeon().pelear(unGrupo.campeon())
      })
    }
}
object coliseo {
    method combateEntreGrupos(unGrupo, otroGrupo){
        unGrupo.combatirContra(otroGrupo)
    }
    method curarGrupo(unGrupo, unValor){
        unGrupo.forEach({g => g.vida(unValor)})
    }

    method curarAGladiador(unGladiador, unValor){
        unGladiador.vida(unValor)
    }
}