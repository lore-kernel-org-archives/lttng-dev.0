From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Odd dependency for lttng-ust - resolved
Date: Fri, 25 Jan 2013 12:32:41 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E696987A76__21140.2834546336$1359135463$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1TynD4-0001gN-Gq
	for lttng-dev@lists.lttng.org; Fri, 25 Jan 2013 12:37:03 -0500
Content-class: urn:content-classes:message
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: =?iso-8859-1?Q?Painchaud=2C_Fr=E9d=E9ric?= <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Date: Mon, 21 Jan 2013 14:34:29 -0500
Subject: Re: [lttng-dev] Odd dependency for lttng-ust
-----Message d'origine (int=E9rieur)-----
De?: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com] =

Envoy??: 21 janvier 2013 13:39

As the error messages suggests, please try:
LDFLAGS=3D-L/usr/local/lib ./configure
instead of "./configure"

Mathieu
-----Fin du message d'origine (int=E9rieur)-----
   Interesting, that prefix does allow configure to complete successfully. =
 lttng-tools runs into the same problem as lttng-ust, and requires the same=
 LDFLAGS prefix for its configure.  No other problems arise.

   So how do we fix userspace-rcu so the bootstrap -configure - make - inst=
all sequence doesn't run into this problem?  I'm presuming here that usersp=
ace-rcu's install needs to be touched up.  Or maybe lttng-ust's (and lttng-=
tools's) bootstrap.

   (It's a problem because the ReadMe for the lttng-ust and lttng-tools pac=
kages stipulate a plain ./configure invocation: as they currently stand, th=
e instructions fail)
-----Fin du message d'origine-----

   I've finally stumbled onto what was causing ./configure to fail for lttn=
g-ust and lttng-tools.

   According to the ld-linux man pages, the Linux default library/header pa=
ths are just /lib and /usr/lib: they do not include /usr/local/lib.  Howeve=
r, /etc/ld.so.conf.d/libc.conf (installed by the Ubuntu libc-bin package) a=
dds /usr/local/bin to the system loader's path, so any application that rel=
ies on /usr/local/bin libraries will find them.  Why does ./configure fail,=
 then?

   It turns out this particular failure is a known bug (http://gcc.gnu.org/=
bugzilla/show_bug.cgi?id=3D42756, January 2010) with the gold linker from t=
he binutils-gold package (specified by the lttng-tools ReadMe): unlike the =
linker it replaces, gold's linker does not look into /usr/local/lib by defa=
ult and ignores the ld.so.conf instructions.  Hence the explicit LDFLAGS=3D=
-L/usr/local/lib prefix requirement.

   Until this old gold bug is fixed (which looks unlikely considering its a=
ge), maybe each package's configure.ac could be made to explicitly look int=
o /usr/local/lib when /lib and /usr/lib fail?  Or the ReadMe files of lttng=
-ust and lttng-tools could be modified to mention the workaround?

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0/ Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
