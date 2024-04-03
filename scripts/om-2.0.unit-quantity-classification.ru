PREFIX om: <http://www.ontology-of-units-of-measure.org/resource/om-2/>
PREFIX owl: <http://www.w3.org/2002/07/owl#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

INSERT {
	?instance rdf:type ?class .
	?subclass rdfs:subClassOf ?class .
}
WHERE {
	?class rdfs:subClassOf* om:Unit ;
		owl:equivalentClass ?equivalentClass .
	OPTIONAL {
		?equivalentClass owl:unionOf/rdf:rest*/rdf:first ?subclass .
		FILTER (!isBlank(?subclass))
	}
	OPTIONAL {
		?equivalentClass (owl:unionOf/rdf:rest*/rdf:first)?/owl:oneOf/rdf:rest*/rdf:first ?instance .
	}
};
DELETE {
	?class owl:equivalentClass ?equivalentClass .
	?between ?p ?end .
}
WHERE {
	?class rdfs:subClassOf* om:Unit ;
		owl:equivalentClass ?equivalentClass .
	?equivalentClass (owl:unionOf|owl:oneOf|rdf:rest|rdf:first)* ?between .
	?between ?p ?end .
	VALUES ?p { owl:unionOf owl:oneOf rdf:rest rdf:first }
}