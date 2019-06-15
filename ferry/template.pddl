(define (problem ferryProblem)
(:domain ferry)
(:objects l0 l1 l2 l3 
          c0 c1 c2 c3 c4 c5 c6 c7 c8 c9 
)
(:init
(location l0)
(location l1)
(location l2)
(location l3)
(car c0)
(car c1)
(car c2)
(car c3)
(car c4)
(car c5)
(car c6)
(car c7)
(car c8)
(car c9)
(not-eq l0 l1)
(not-eq l1 l0)
(not-eq l0 l2)
(not-eq l2 l0)
(not-eq l0 l3)
(not-eq l3 l0)
(not-eq l1 l2)
(not-eq l2 l1)
(not-eq l1 l3)
(not-eq l3 l1)
(not-eq l2 l3)
(not-eq l3 l2)
(empty-ferry)
(at c0 l2)
(at c1 l0)
(at c2 l1)
(at c3 l2)
(at c4 l3)
(at c5 l0)
(at c6 l0)
(at c7 l3)
(at c8 l2)
(at c9 l2)
(at-ferry l2)
)
(:goal
(and
	<HYPOTHESIS>      
)))