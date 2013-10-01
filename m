From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Making 32-bit user-space events on a 64-bit Linux
 system
Date: Tue, 1 Oct 2013 21:13:04 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD2679540E__377.99837668917$1380662051$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1VR7Fn-0000w5-FP
	for lttng-dev@lists.lttng.org; Tue, 01 Oct 2013 17:13:17 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De : jeremie.galarneau@gmail.com [mailto:jeremie.galarneau@gmail.com]
Envoy=E9 : 30 septembre 2013 18:34

>>    The problem is the "incompatible /usr/local/lib/liblttng-ust.so".  I =
even tried rebuilding the entire lttng suite (originally built *before* gcc=
-multilib was added), but that changed nothing.  How do I do this?  More ge=
nerally, how does one add tracepoints to a 32-bit application running on a =
64-bit system?
>
> The complete LTTng toolchain must be built for 32-bit (including the depe=
ndencies). Please refer to your distribution's documentation on how to buil=
d or install 32-bit packages.

   I'm assuming the lttng-modules are to be excluded from the 32-bit build =
(since I'm concerned with just 32-bit user-space events anyway).  I manage =
to rebuild userspace-rcu and lttng-ust with no apparent trouble, changing j=
ust the ./configure line in each case:

userspace-rcu-32bits:
$ ./configure --libdir=3D/usr/local/lib32 CFLAGS=3D"-m32 -g -O2"
$ make
$ sudo make install
$ sudo ldconfig

lttng-ust-32bits:

$ ./configure LDFLAGS=3D-L/usr/local/lib32 --with-jni-interface --with-java=
-jdk=3D`./doc/examples/drdc/findjdk` --with-sdt --libdir=3D/usr/local/lib32=
 CFLAGS=3D"-m32 -g -O2"
$ make
$ sudo make install
$ sudo ldconfig

lttng-tools is more challenging.  I figure I'll need to build just the 32-b=
it lttng-consumerd, then rebuild the 64-bit lttng-tools with --with-consume=
rd32-libdir and --with-consumerd32-bin properly set:

lttng-tools-32bits:
$ ./configure LDFLAGS=3D-L/usr/local/lib32 --enable-python-bindings --bindi=
r=3D/usr/local/bin32 --libdir=3D/usr/local/lib32 CFLAGS=3D"-m32 -g -O2" --w=
ith-consumerd-only
$ make
$ sudo make install
$ sudo ldconfig

lttng-tools-64bits:
$ ./configure LDFLAGS=3D-L/usr/local/lib --enable-python-bindings --with-co=
nsumerd32-bin=3D/usr/local/bin32/lttng/lttng-consumerd --with-consumerd32-l=
ibdir=3D/usr/local/lib32
$ make
$ sudo make install
$ sudo ldconfig

Haven't tried this yet.  Am I on the right track to get 64-bit lttng-tools =
to capture 32-bit user-space events?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
