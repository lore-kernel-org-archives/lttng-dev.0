From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Odd dependency for lttng-ust
Date: Mon, 21 Jan 2013 11:50:02 -0500
Message-ID: <3CA1A65C03C1A34C81BBC6272782E6969878A7__29132.2007928558$1358787073$gmane$org@valcartierex01.valcartier.drdc-rddc.gc.ca>
References: <3CA1A65C03C1A34C81BBC6272782E696987880@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121145954.GA1472@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E696987887@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<20130121152949.GB1912@Krystal>
	<3CA1A65C03C1A34C81BBC6272782E69698788F@valcartierex01.valcartier.drdc-rddc.gc.ca>
	<50FD6474.6070207@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1TxKZi-0003qe-Bx
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 11:50:22 -0500
Content-class: urn:content-classes:message
In-Reply-To: <50FD6474.6070207@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De=A0: David Goulet [mailto:dgoulet@efficios.com] =

Envoy=E9=A0: 21 janvier 2013 10:53

Also, I do still forget it still today but after installing URCU and UST:

$ sudo ldconfig

David
-----Fin du message d'origine-----

   But 'sudo make install' invokes 'ldconfig -n /usr/local/lib'...

   Tried again, without fetching liburcu-dev from the LTTng PPA.  The packa=
ges added to the basic Ubuntu 12.04 install are:

automake        1:1.11.3-1ubuntu2
binutils-gold    2.22-6ubuntu1
bison                  1:2.5.dsfg-2.1
flex                     2.5.35-10ubuntu3
libpopt-dev     1.16-3ubuntu1
libtool                2.4.2-1ubuntu1
libuuid1             2.20.1-1ubuntu3
python-dev     2.7.3-0ubuntu2
swig2.0              2.0.4+really2.0.4-4ubuntu2
linux-headers-3.2.0-36-virtual
texinfo               4.13a.dfsg.1-8ubuntu2
g++                      4:4.6.3-1ubuntu5

This time I did sudo ldconfig after each install (both commands had nothing=
 to say).  After making and installing lttng-modules and userspace-rcu succ=
essfully, lttng-ust's configure fails about a dozen checks earlier than the=
 liburcu-cds check with:

checking for uuid_generate in -luuid... no
checking for uuid_create in -lc... no
configure: error: Cannot find libuuid uuid_generate nor libc uuid_create. U=
se LDFLAGS=3D-Ldir to specify their location.

Even though libuuid1 (includes libuuid-perl, uuid-dev, uuid-runtime) is ins=
talled.  I need to fix this new stumbling block before we can address the l=
iburcu-cds problem.

Logs available.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
