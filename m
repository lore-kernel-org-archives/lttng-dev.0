From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: babeltrace 1.2.2 and python3
Date: Fri, 15 Aug 2014 15:47:59 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3D184038__15177.5444196121$1408117774$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XIJjh-0005Ut-KF
 for lttng-dev@lists.lttng.org; Fri, 15 Aug 2014 11:48:21 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

   The babeltrace 1.2.2 README suggests the python3-dev package and states =
configure need only be called with the enable-python-bindings option.

   However, my configure log (on a system with python3-dev (and therefore p=
ython3) and swig2.0 installed) reads in part:

checking for swig... no
checking for swig2.0... /usr/bin/swig2.0
checking SWIG version... 2.0.4
checking for SWIG library... /usr/share/swig2.0
checking for python... /usr/bin/python
checking for python version... 2.7
checking for python platform... linux2
checking for python script directory... ${prefix}/lib/python2.7/dist-packag=
es
checking for python extension module directory... ${exec_prefix}/lib/python=
2.7/dist-packages
checking for python2.7-config... /usr/bin/python2.7-config
checking python include flags... -I/usr/include/python2.7 -I/usr/include/py=
thon2.7

   I get the impression the "wrong" version of python is being bound to.  I=
s this what the export of PYTHON and PYTHON_CONFIG is meant to fix?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
