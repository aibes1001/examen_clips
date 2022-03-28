(deffacts datos
    (pedido cajas_naranjas 2 cajas_caquis 0 cajas_uvas 1 cajas_manzanas 3)
    (robot posicion 0 carga 0 pedido_acumulado cajas_naranjas 0 cajas_caquis 0 cajas_uvas 0 cajas_manzanas 0 palet_naranjas posicion 1 stock 5
    palet_manzanas posicion 2 stock 5 palet_caquis posicion 3 stock 5 palet_uvas posicion 4 stock 5)
)

(defrule mover_derecha
    (robot posicion ?p $?)
    (test (< ?p 4))
=>
    (assert (robot posicion (+ ?p 1) $?))
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
    (robot posicion ?x carga 0 $? palet_naranjas posicion ?x stock ?s $?)
    (pedido $?l1 cajas_naranjas ?p $?l2 )
    (and (test (> ?s 0))
)

