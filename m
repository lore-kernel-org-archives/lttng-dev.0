From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: dlopen, gcc -l and LD_PRELOAD
Date: Wed, 20 Mar 2013 16:52:41 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD028AF5__9278.93706034428$1363798465$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UIMGb-00025Y-PN
	for lttng-dev@lists.lttng.org; Wed, 20 Mar 2013 12:53:33 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
Message: 6
Date: Wed, 20 Mar 2013 12:38:59 -0400

>    Meanwhile I've been playing with some very simple examples of .so use,=
 and found that the behaviour of LD_PRELOAD is incompletely documented.  Fo=
r instance, if I run:

Take a look at "man 8 ld.so". It should answer most of the questions you ha=
ve about the dynamic linker libraries lookup mechanism.

>    The above should explain the trouble I've been having with lttng-ust's=
 doc/examples/easy-ust and tests/demo.

Glad to see that you solved your issue!
------------------------------

   That's what I meant by incompletely documented.  The ld.so man pages don=
't mention rpath/runpath in the description, do not explain the LD_PRELOAD =
caveats, do not mention the nodeflib executable tag, and don't detail how t=
he ld.so.conf inclusions are sorted.  The online version (http://man7.org/l=
inux/man-pages/man8/ld.so.8.html) is much better (though still lacking a bi=
t) and certainly more up to date (February 2013 vs. Ubuntu's May 2007 versi=
on!).

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
