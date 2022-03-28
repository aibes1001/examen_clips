(deffacts datos
    (pedido cajas_naranjas 2 cajas_caquis 1 cajas_uvas 1 cajas_manzanas 3)
    (robot posicion 0 carga 0 pedido_acumulado cajas_naranjas 0 cajas_caquis 0 cajas_uvas 0 cajas_manzanas 0 palet_naranjas posicion 1 stock 5
    palet_manzanas posicion 2 stock 5 palet_caquis posicion 3 stock 5 palet_uvas posicion 4 stock 5)
    (max 3)
)

(defrule mover_derecha
    (robot posicion ?p $?l1)
    (test (< ?p 4))
=>
    (assert (robot posicion (+ ?p 1) $?l1))
)

(defrule mover_izquierda
    (robot posicion ?p $?l1)
    (test (> ?p 0))
=>
    (assert (robot posicion (- ?p 1) $?l1))
)

(defrule dejar_cajas
    (declare(salience 90))
    (robot posicion 0 carga ?cajas_fruta ?num_cajas pedido_acumulado $?l1 ?cajas_fruta_pedido ?num_actual_cajas $?l2 )
    (test (eq ?cajas_fruta ?cajas_fruta_pedido))
=>
    (assert (robot posicion 0 carga 0 pedido_acumulado $?l1 ?cajas_fruta (+ ?num_actual_cajas ?num_cajas) $?l2))
)


(defrule recojer_cajas_naranjas
    (declare(salience 80))
    (robot posicion ?x carga 0 pedido_acumulado $?l1 cajas_naranjas ?pa $?l2 palet_naranjas posicion ?x stock ?s $?l3)
    (pedido $?lp1 cajas_naranjas ?p $?lp2)
    (max ?m)
    (and (test (> ?s ?p)) (test (< ?pa ?p)))

=>
    (assert (robot posicion ?x carga cajas_naranjas (- ?p ?pa) pedido_acumulado $?l1 cajas_naranjas ?pa $?l2 palet_naranjas posicion ?x stock (- ?s (- ?p ?pa)) $?l3)
))

(defrule recojer_cajas_caquis
    (declare(salience 80))
    (robot posicion ?x carga 0 pedido_acumulado $?l1 cajas_caquis ?pa $?l2 palet_caquis posicion ?x stock ?s $?l3)
    (pedido $?lp1 cajas_caquis ?p $?lp2)
    (max ?m)
    (and (test (> ?s ?p)) (test (< ?pa ?p)))

=>
    (assert (robot posicion ?x carga cajas_caquis (- ?p ?pa) pedido_acumulado $?l1 cajas_caquis ?pa $?l2 palet_caquis posicion ?x stock (- ?s (- ?p ?pa)) $?l3)
))

(defrule recojer_cajas_uvas
    (declare(salience 80))
    (robot posicion ?x carga 0 pedido_acumulado $?l1 cajas_uvas ?pa $?l2 palet_uvas posicion ?x stock ?s $?l3)
    (pedido $?lp1 cajas_uvas ?p $?lp2)
    (max ?m)
    (and (test (> ?s ?p)) (test (< ?pa ?p)))

=>
    (assert (robot posicion ?x carga cajas_uvas (- ?p ?pa) pedido_acumulado $?l1 cajas_uvas ?pa $?l2 palet_uvas posicion ?x stock (- ?s (- ?p ?pa)) $?l3)
))

(defrule recojer_cajas_manzanas
    (declare(salience 80))
    (robot posicion ?x carga 0 pedido_acumulado $?l1 cajas_manzanas ?pa $?l2 palet_manzanas posicion ?x stock ?s $?l3)
    (pedido $?lp1 cajas_manzanas ?p $?lp2)
    (max ?m)
    (and (test (> ?s ?p)) (test (< ?pa ?p)))

=>
    (assert (robot posicion ?x carga cajas_manzanas (- ?p ?pa) pedido_acumulado $?l1 cajas_manzanas ?pa $?l2 palet_manzanas posicion ?x stock (- ?s (- ?p ?pa) ?m) $?l3)
))

(defrule final
    (declare(salience 100))
    (pedido cajas_naranjas ?n cajas_caquis ?c cajas_uvas ?u cajas_manzanas ?m)
    (robot posicion 0 carga 0 pedido_acumulado cajas_naranjas ?n cajas_caquis ?c cajas_uvas ?u cajas_manzanas ?m $?l1)
=>
    (halt)
    (printout t "FINAAAAAAAAAL!!!" crlf)
    (printout t "Pedido final: naranjas " ?n "; caquis " ?c "; uvas " ?u "; manzanas " ?m crlf)
)



