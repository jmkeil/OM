PREFIX om: <http://www.ontology-of-units-of-measure.org/resource/om-2/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>

DELETE {
	?class owl:equivalentClass ?equivalentClass .
	?between ?p ?end .
}
INSERT {
	?prefixedUnit rdf:type ?class .
}
WHERE {
	?class rdfs:subClassOf* om:Unit ;
		owl:equivalentClass ?equivalentClass .
	?equivalentClass owl:intersectionOf/rdf:rest*/rdf:first [ rdf:type owl:Restriction ;
                                                              owl:onProperty om:hasPrefix ;
                                                              owl:allValuesFrom ?prefixClass
                                                            ] ,
                                                            [ rdf:type owl:Restriction ;
                                                              owl:onProperty om:hasUnit ;
                                                              owl:hasValue ?unprefixedUnit
                                                            ] ,
                                                            [ rdf:type owl:Restriction ;
                                                              owl:onProperty om:hasPrefix ;
                                                              owl:cardinality "1"^^xsd:nonNegativeInteger
                                                            ] ,
                                                            [ rdf:type owl:Restriction ;
                                                              owl:onProperty om:hasUnit ;
                                                              owl:cardinality "1"^^xsd:nonNegativeInteger
                                                            ] .
	?prefixedUnit rdf:type om:PrefixedUnit ;
		om:hasPrefix/rdf:type/rdfs:subClassOf* ?prefixClass ;
		om:hasUnit ?unprefixedUnit .
	
	?equivalentClass (owl:intersectionOf|rdf:rest|rdf:first)* ?between .
	?between ?p ?end .
	VALUES ?p { owl:intersectionOf rdf:rest rdf:first rdf:type owl:onProperty owl:allValuesFrom owl:hasValue owl:cardinality }
}