
<mano> è il nome abbreviato del manoscritto.
es.
PARIGI  => par
VENEZIA => ven
TOUr    => tor
TOLOSA  => tou
=================================
file TEI-XML per ogni manoscritto:
./xml/{<mano>}/flori{<mano>}.xml
es:
./xml/par/floripar.xml

=================================
eleconco scripts
=================================
build_mano.sh <mano>
    costruisce il singolo manoscritto
lo script invoca tutti gli script necessari
alla produzione dei file html a
partire dal file xml del maoscritto
=================================
fl2eps.sh <mano>
  trasformazioni per il manoscritto
sax.sh
    invoca saxon.jar
set_xsl_text.py
    nei file rimpiazza __TEXT__ con la <mano>
-----------------------------
xsynfl2h.sh
  trasformazioni synoptica per <mano>
-----------------------------
xsynep2h.sh
  trasformazioni synoptica per <mano> + episodio
-----------------------------
xtxtfl2h.sh
  trasformazioni diplomatica-interpretativa  per <mano>
-----------------------------
xtxtep2h.sh
  trasformazioni diplomatica-interpretativa  per <mano> + espisodio
========================
Elenco delle chiamate degli script
=======================
build_mano.sh <mano>
    source ./setflenv.sh (setta le variabili ambiente)
    fl2eps.sh <mano>
    xtxtfl2h.sh <mano>
    xsynfl2h.sh <mano>
=======================
fl2eps.sh <mano>
    fl2eps.py -i "xml/<mano>/flori<mano>.xml" -o "xml/<mano>/<mano>"
    utilizza il file
    ./xml/<mano>/flori<mano>.xml
    Che Contiene tutti gli  episodi e le note
produce;
<mano>.txt (elenco epsisodi)
<mano>.xml (elenco epsisodi + note)
<epsisodio_1>.xml
<epsisodio_2>.xml
<epsisodio_..>.xml
=========================
xtxtfl2h.sh <mano>
utilizza il files xsl:
./xsl/syndp.xls
./xsl/synit.xls
che produce:
./html/<mano>/syn/xint.html
legge
./xml/<mano>/<manno>.txt
elenco episodi per ognuno esegue
xtxtep2h.sh <episodio> <<mano>>
ad ogni episodio esegue trasformazione
diplomatica con
xsl/fldip.xsl
interpretaticìva con
xsl/flint.xsl
unisce i files html prodotti
