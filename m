From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Fwd: [Bug 925071] New: babeltrace: Does not support
 aarch64 in f19 and rawhide
Date: Fri, 22 Mar 2013 20:18:19 -0400
Message-ID: <CAEzWAe+K1bbq9EFX9j5dd1atVGWGGVBKib0V1N_vnMpy3hfkEQ__7072.495079092$1363997959$gmane$org@mail.gmail.com>
References: <bug-925071-315593@bugzilla.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1775998197=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UJCAD-0003Ta-JC
	for lttng-dev@lists.lttng.org; Fri, 22 Mar 2013 20:18:25 -0400
Received: by mail-vb0-f54.google.com with SMTP id p14so561417vbm.41
	for <lttng-dev@lists.lttng.org>; Fri, 22 Mar 2013 17:18:20 -0700 (PDT)
In-Reply-To: <bug-925071-315593@bugzilla.redhat.com>
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

--===============1775998197==
Content-Type: multipart/alternative; boundary=20cf307ca04c4ec47004d88c8263

--20cf307ca04c4ec47004d88c8263
Content-Type: text/plain; charset=ISO-8859-1

I think that's a problem that might occur for other distribution soon
---------- Mensaje remitido ----------
De: <bugzilla@redhat.com>
Fecha: mar 22, 2013 8:06 p.m.
Asunto: [Bug 925071] New: babeltrace: Does not support aarch64 in f19 and
rawhide
Para: <yannick.brosseau@gmail.com>
Cc:

Product: Fedora
https://bugzilla.redhat.com/show_bug.cgi?id=925071

            Bug ID: 925071
           Summary: babeltrace: Does not support aarch64 in f19 and
                    rawhide
           Product: Fedora
           Version: rawhide
         Component: babeltrace
          Severity: unspecified
          Priority: unspecified
          Assignee: yannick.brosseau@gmail.com
          Reporter: dennis@ausil.us
        QA Contact: extras-qa@fedoraproject.org
                CC: yannick.brosseau@gmail.com
            Blocks: 922257 (ARM64)

Support for the ARM 64 bit CPU architecture (aarch64) was introduced in
autoconf 2.69.  babeltrace appears to use an earlier version of
autoconf, preventing its being built.  This can be fixed in of three ways
(In
order of preference):

1. Work with upstream to migrate the package to autoconf 2.69.

2. Rerun autoconf or autoreconf in %prep or %build prior to running
configure.

3. Apply the patch at
http://ausil.fedorapeople.org/aarch64/babeltrace/babeltrace-aarch64.patch
which updates config.guess and config.sub to recognize aarch64.

--
You are receiving this mail because:
You are on the CC list for the bug.
You are the assignee for the bug.

--20cf307ca04c4ec47004d88c8263
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I think that&#39;s a problem that might occur for other dist=
ribution soon </p>
<div class=3D"gmail_quote">---------- Mensaje remitido ----------<br>De:  &=
lt;<a href=3D"mailto:bugzilla@redhat.com">bugzilla@redhat.com</a>&gt;<br>Fe=
cha: mar 22, 2013 8:06 p.m.<br>Asunto: [Bug 925071] New: babeltrace: Does n=
ot support aarch64 in f19 and rawhide<br>
Para:  &lt;<a href=3D"mailto:yannick.brosseau@gmail.com">yannick.brosseau@g=
mail.com</a>&gt;<br>Cc: <br><br type=3D"attribution">Product: Fedora<br>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D925071" target=3D"=
_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D925071</a><br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 Bug ID: 925071<br>
=A0 =A0 =A0 =A0 =A0 =A0Summary: babeltrace: Does not support aarch64 in f19=
 and<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rawhide<br>
=A0 =A0 =A0 =A0 =A0 =A0Product: Fedora<br>
=A0 =A0 =A0 =A0 =A0 =A0Version: rawhide<br>
=A0 =A0 =A0 =A0 =A0Component: babeltrace<br>
=A0 =A0 =A0 =A0 =A0 Severity: unspecified<br>
=A0 =A0 =A0 =A0 =A0 Priority: unspecified<br>
=A0 =A0 =A0 =A0 =A0 Assignee: <a href=3D"mailto:yannick.brosseau@gmail.com"=
>yannick.brosseau@gmail.com</a><br>
=A0 =A0 =A0 =A0 =A0 Reporter: <a href=3D"mailto:dennis@ausil.us">dennis@aus=
il.us</a><br>
=A0 =A0 =A0 =A0 QA Contact: <a href=3D"mailto:extras-qa@fedoraproject.org">=
extras-qa@fedoraproject.org</a><br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CC: <a href=3D"mailto:yannick.brosseau@gmai=
l.com">yannick.brosseau@gmail.com</a><br>
=A0 =A0 =A0 =A0 =A0 =A0 Blocks: 922257 (ARM64)<br>
<br>
Support for the ARM 64 bit CPU architecture (aarch64) was introduced in<br>
autoconf 2.69. =A0babeltrace appears to use an earlier version of<br>
autoconf, preventing its being built. =A0This can be fixed in of three ways=
 (In<br>
order of preference):<br>
<br>
1. Work with upstream to migrate the package to autoconf 2.69.<br>
<br>
2. Rerun autoconf or autoreconf in %prep or %build prior to running<br>
configure.<br>
<br>
3. Apply the patch at<br>
<a href=3D"http://ausil.fedorapeople.org/aarch64/babeltrace/babeltrace-aarc=
h64.patch" target=3D"_blank">http://ausil.fedorapeople.org/aarch64/babeltra=
ce/babeltrace-aarch64.patch</a><br>
which updates config.guess and config.sub to recognize aarch64.<br>
<br>
--<br>
You are receiving this mail because:<br>
You are on the CC list for the bug.<br>
You are the assignee for the bug.<br>
</div>

--20cf307ca04c4ec47004d88c8263--


--===============1775998197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1775998197==--
