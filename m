From: Zvi Vered <veredz72@gmail.com>
Subject: Compilation error in LTTng-UST 2.0.8
Date: Sat, 17 Aug 2013 23:26:35 +0300
Message-ID: <CABRndgzoMJn3gQDidOBb+H=2yOi=F=3S0FLTVC9e1_EW08GdGg__40907.8139382929$1376771250$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0043813408=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f179.google.com ([74.125.82.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <veredz72@gmail.com>) id 1VAn58-0002Om-DH
	for lttng-dev@lists.lttng.org; Sat, 17 Aug 2013 16:26:44 -0400
Received: by mail-we0-f179.google.com with SMTP id t57so2635565wes.38
	for <lttng-dev@lists.lttng.org>; Sat, 17 Aug 2013 13:26:36 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0043813408==
Content-Type: multipart/alternative; boundary=089e016347fa12eccd04e42a86ef

--089e016347fa12eccd04e42a86ef
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I downloaded the file lttng-ust-2.0.8.tar.bz2, extracted it and the ran:
./configure
make

After a while I got the following compilcation error:

  CC     ltt-probes.lo
  CC     lttng-probe-ust.lo
In file included from ../include/lttng/ust-tracepoint-event.h:506,
                 from ../include/lttng/tracepoint-event.h:41,
                 from probes/lttng-probe-ust.h:47,
                 from probes/lttng-probe-ust.c:25:
././probes/lttng-probe-ust.h:27: error: weak declaration of
'__ref_loglevel___lttng_ust___metadata' must be public
././probes/lttng-probe-ust.h:27: error:
'__ref_loglevel___lttng_ust___metadata' defined both normally and as an
alias
make[2]: *** [lttng-probe-ust.lo] Error 1
make[2]: Leaving directory `/home/zvivered/GNU/lttng-ust-2.0.8/liblttng-ust'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/zvivered/GNU/lttng-ust-2.0.8'
make: *** [all] Error 2


I'm working with Centos 5.9, gcc 4.1.2 20080704 (Red Hat 4.1.2-54)

Can you help ?

Thanks,
Zvika

--089e016347fa12eccd04e42a86ef
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div>Hello,<br><br></di=
v>I downloaded the file lttng-ust-2.0.8.tar.bz2, extracted it and the ran:<=
br></div>./configure<br></div>make<br><br></div>After a while I got the fol=
lowing compilcation error:<br>
<br>=A0 CC=A0=A0=A0=A0 ltt-probes.lo<br>=A0 CC=A0=A0=A0=A0 lttng-probe-ust.=
lo<br>In file included from ../include/lttng/ust-tracepoint-event.h:506,<br=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from ../include/lttng/tra=
cepoint-event.h:41,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fro=
m probes/lttng-probe-ust.h:47,<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from probes/lttng-probe-us=
t.c:25:<br>././probes/lttng-probe-ust.h:27: error: weak declaration of &#39=
;__ref_loglevel___lttng_ust___metadata&#39; must be public<br>././probes/lt=
tng-probe-ust.h:27: error: &#39;__ref_loglevel___lttng_ust___metadata&#39; =
defined both normally and as an alias<br>
make[2]: *** [lttng-probe-ust.lo] Error 1<br>make[2]: Leaving directory `/h=
ome/zvivered/GNU/lttng-ust-2.0.8/liblttng-ust&#39;<br>make[1]: *** [all-rec=
ursive] Error 1<br>make[1]: Leaving directory `/home/zvivered/GNU/lttng-ust=
-2.0.8&#39;<br>
make: *** [all] Error 2<br><br><br></div>I&#39;m working with Centos 5.9, g=
cc 4.1.2 20080704 (Red Hat 4.1.2-54)<br><br></div>Can you help ?<br><br></d=
iv>Thanks,<br>Zvika <br></div></div>

--089e016347fa12eccd04e42a86ef--


--===============0043813408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0043813408==--
