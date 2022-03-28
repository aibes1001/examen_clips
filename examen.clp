(deffacts datos
    (pedido cajas_naranjas 2 cajas_caquis 0 cajas_uvas 1 cajas_manzanas 3)
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
    (robot posicion ?p $?)
    (test (> ?p 0))
=>
    (assert (robot posicion (- ?p 1) $?))
)

(defrule dejar_cajas
    (robot posicion 0 carga ?cajas_fruta ?num_cajas pedido_acumulado $?l1 ?cajas_fruta ?num_actual_cajas $?l2 $?)
=>
    (assert (robot posicion 0 carga 0 pedido_acumulado $?l1 ?cajas_fruta (+ ?num_actual_cajas ?num_cajas) $?l2 $?))
)


(defrule recojer_cajas_naranjas
    (robot posicion ?x carga 0 pedido_acumulado $? cajas_naranjas ?pa $? palet_naranjas posicion ?x stock ?s $?)
    (pedido $? cajas_naranjas ?p $?)
    (max ?m)
    (and (test (> ?s ?p)) (test (< ?pa ?p)))

=>
    (assert (robot posicion ?x carga cajas_naranjas (max (- ?p ?pa) ?m) pedido_acumulado $? cajas_naranjas ?pa $? palet_naranjas posicion ?x stock (- ?s (max (- ?p ?pa) ?m) $?))
)

(defrule recojer_cajas_caquis
    (robot posicion ?x carga 0 pedido_acumulado $? cajas_caquis ?pa $? palet_caquis posicion ?x stock ?s $?)
    (pedido $? cajas_caquis ?p $?)
    (max ?m)
    (and (test (> ?s ?p)) (test (< ?pa ?p)))

=>
    (assert (robot posicion ?x carga cajas_caquis (max (- ?p ?pa) ?m) pedido_acumulado $? cajas_caquis ?pa $? palet_caquis posicion ?x stock (- ?s (max (- ?p ?pa) ?m) $?))
)

(defrule recojer_cajas_uvas
    (robot posicion ?x carga 0 pedido_acumulado $? cajas_uvas ?pa $? palet_uvas posicion ?x stock ?s $?)
    (pedido $? cajas_uvas ?p $?)
    (max ?m)
    (and (test (> ?s ?p)) (test (< ?pa ?p)))

=>
    (assert (robot posicion ?x carga cajas_uvas (max (- ?p ?pa) ?m) pedido_acumulado $? cajas_uvas ?pa $? palet_uvas posicion ?x stock (- ?s (max (- ?p ?pa) ?m) $?))
)

(defrule recojer_cajas_manzanas
    (robot posicion ?x carga 0 pedido_acumulado $? cajas_manzanas ?pa $? palet_manzanas posicion ?x stock ?s $?)
    (pedido $? cajas_manzanas ?p $?)
    (max ?m)
    (and (test (> ?s ?p)) (test (< ?pa ?p)))

=>
    (assert (robot posicion ?x carga cajas_manzanas (max (- ?p ?pa) ?m) pedido_acumulado $? cajas_manzanas ?pa $? palet_manzanas posicion ?x stock (- ?s (max (- ?p ?pa) ?m) $?))
)

(defrule final
    (pedido cajas_naranjas ?n cajas_caquis ?c cajas_uvas ?u cajas_manzanas ?m)
    (robot posicion 0 carga 0 pedido_acumulado cajas_naranjas ?n cajas_caquis ?c cajas_uvas ?u cajas_manzanas ?m $?)
=>
    (halt)
    (printout t "FINAAAAAAAAAL!!!" crlf)
)



