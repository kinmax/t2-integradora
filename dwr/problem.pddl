(define (problem pb8)
  (:domain dwr)
  (:objects
   r1 - robot
   l1 l2 l3 l4 l5 l6 - location
   k1 k2 k3 k4 - crane
   p1 p2 p3 p4 - pile
   ca cb cc cd ce cf pallet - container)
   
   (:init
   (adjacent l1 l2)
   (adjacent l1 l4)
   
   (adjacent l2 l1)
   (adjacent l2 l3)
   (adjacent l2 l5)
   
   (adjacent l3 l2)
   (adjacent l3 l6)
   
   (adjacent l4 l1)
   (adjacent l4 l5)
   
   (adjacent l5 l4)
   (adjacent l5 l2)
   (adjacent l5 l6)
   
   (adjacent l6 l3)
   (adjacent l6 l5)
   
   (attached p1 l1)
   (attached p2 l3)
   (attached p3 l4)
   (attached p4 l6)
   
   (belong k1 l1)
   (belong k2 l3)
   (belong k3 l4)
   (belong k4 l6)
   
   (at r1 l2)
   (unloaded r1)
   (occupied l2)
   
   (in ca p1)
   (in cb p1)
   (in ce p1)
   (in cf p1)
   
   (on cf ce)
   (on ce cb)
   (on cb ca)
   (on ca pallet)
   (top cf p1)
   (holding k1 cc)
   
   (holding k2 cd)
   
   (top pallet p2)
   (top pallet p3)
   (top pallet p4)
   
   (empty k3)
   (empty k4)
   )
   (:goal
     (and   
        (in ca p3)  (in cb p2)  (in cc p1)  (in cd p2)  (on cb cd)  (on ce cc)
     )
   )
)