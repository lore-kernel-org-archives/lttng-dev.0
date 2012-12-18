From: "ajonwa ajonwa" <ajonwa@gmx.com>
Subject: babletrace with python bindings
Date: Tue, 18 Dec 2012 19:40:44 +0100
Message-ID: <20121218184045.288000__18209.423198323$1355856098$gmane$org@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0348272094=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mout.gmx.net ([212.227.17.21])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ajonwa@gmx.com>) id 1Tl261-00041Y-Jq
	for lttng-dev@lists.lttng.org; Tue, 18 Dec 2012 13:40:53 -0500
Received: from mailout-eu.gmx.com ([10.1.101.2]) by mrigmx.server.lan
	(mrigmx001) with ESMTP (Nemesis) id 0LkDzQ-1TERMb1bfG-00cC9C for
	<lttng-dev@lists.lttng.org>; Tue, 18 Dec 2012 19:40:47 +0100
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

--===============0348272094==
Content-Type: multipart/alternative;
 boundary="========GMXBoundary28800135585604526273"

--========GMXBoundary28800135585604526273
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hello everyone,

 I get the following error message while attempting to compile babeltrace with python bindings:

 CC _babeltrace_la-babeltrace_wrap.lo
babeltrace_wrap.c: In function '_wrap__bt_ctf_field_type':
babeltrace_wrap.c:4621:56: warning: passing argument 1 of 'bt_ctf_field_type' from incompatible pointer type [enabled by default]
../../include/babeltrace/ctf/events.h:158:18: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_signedness':
babeltrace_wrap.c:4643:51: warning: passing argument 1 of 'bt_ctf_get_int_signedness' from incompatible pointer type [enabled by default]
../../include/babeltrace/ctf/events.h:167:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_base':
babeltrace_wrap.c:4665:45: warning: passing argument 1 of 'bt_ctf_get_int_base' from incompatible pointer type [enabled by default]
../../include/babeltrace/ctf/events.h:172:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_byte_order':
babeltrace_wrap.c:4687:51: warning: passing argument 1 of 'bt_ctf_get_int_byte_order' from incompatible pointer type [enabled by default]
../../include/babeltrace/ctf/events.h:178:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_len':
babeltrace_wrap.c:4709:39: warning: passing argument 1 of 'bt_ctf_get_int_len' from incompatible pointer type [enabled by default]
../../include/babeltrace/ctf/events.h:184:9: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
babeltrace_wrap.c: In function '_wrap__bt_ctf_get_encoding':
babeltrace_wrap.c:4731:66: warning: passing argument 1 of 'bt_ctf_get_encoding' from incompatible pointer type [enabled by default]
../../include/babeltrace/ctf/events.h:190:26: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
babeltrace_wrap.c: In function '_wrap__bt_ctf_get_array_len':
babeltrace_wrap.c:4753:46: warning: passing argument 1 of 'bt_ctf_get_array_len' from incompatible pointer type [enabled by default]
../../include/babeltrace/ctf/events.h:196:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
babeltrace_wrap.c: In function 'init_babeltrace':
babeltrace_wrap.c:6020:61: error: 'BT_SEEK_END' undeclared (first use in this function)
babeltrace_wrap.c:6020:61: note: each undeclared identifier is reported only once for each function it appears in
make[3]: *** [_babeltrace_la-babeltrace_wrap.lo] Error 1

 I got the source code by checking out bindings/python (git checkout bindings/python).

 I will be grateful if someone would tell how to fix the error.



 Thanks,

 Geoffrey

--========GMXBoundary28800135585604526273
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<span style=3D'font-family:Verdana'><span style=3D'font-size:12px'><span st=
yle=3D"font-family:verdana;"><span style=3D"font-size:12px;"><span style=3D=
"font-size:16px;">Hello everyone,<br />=20
<br />=20
I get the&nbsp;following error message while attempting to compile&nbsp;</s=
pan></span></span><span style=3D"font-size:16px;">babeltrace<span name=3D"m=
isspelled-babletrace">&nbsp;with python bindings:<br />=20
<br />=20
&nbsp;&nbsp;</span>&nbsp; CC &nbsp; &nbsp; _babeltrace_la-babeltrace_wrap.l=
o</span>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c: In function '_wrap__bt_=
ctf_field_type':</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c:4621:56: warning: passin=
g argument 1 of 'bt_ctf_field_type' from incompatible pointer type [enabled=
 by default]</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">../../include/babeltrace/ctf/events.h:158:=
18: note: expected 'const struct declaration *' but argument is of type 'co=
nst struct definition *'</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c: In function '_wrap__bt_=
ctf_get_int_signedness':</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c:4643:51: warning: passin=
g argument 1 of 'bt_ctf_get_int_signedness' from incompatible pointer type =
[enabled by default]</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">../../include/babeltrace/ctf/events.h:167:=
5: note: expected 'const struct declaration *' but argument is of type 'con=
st struct definition *'</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c: In function '_wrap__bt_=
ctf_get_int_base':</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c:4665:45: warning: passin=
g argument 1 of 'bt_ctf_get_int_base' from incompatible pointer type [enabl=
ed by default]</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">../../include/babeltrace/ctf/events.h:172:=
5: note: expected 'const struct declaration *' but argument is of type 'con=
st struct definition *'</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c: In function '_wrap__bt_=
ctf_get_int_byte_order':</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c:4687:51: warning: passin=
g argument 1 of 'bt_ctf_get_int_byte_order' from incompatible pointer type =
[enabled by default]</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">../../include/babeltrace/ctf/events.h:178:=
5: note: expected 'const struct declaration *' but argument is of type 'con=
st struct definition *'</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c: In function '_wrap__bt_=
ctf_get_int_len':</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c:4709:39: warning: passin=
g argument 1 of 'bt_ctf_get_int_len' from incompatible pointer type [enable=
d by default]</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">../../include/babeltrace/ctf/events.h:184:=
9: note: expected 'const struct declaration *' but argument is of type 'con=
st struct definition *'</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c: In function '_wrap__bt_=
ctf_get_encoding':</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c:4731:66: warning: passin=
g argument 1 of 'bt_ctf_get_encoding' from incompatible pointer type [enabl=
ed by default]</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">../../include/babeltrace/ctf/events.h:190:=
26: note: expected 'const struct declaration *' but argument is of type 'co=
nst struct definition *'</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c: In function '_wrap__bt_=
ctf_get_array_len':</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c:4753:46: warning: passin=
g argument 1 of 'bt_ctf_get_array_len' from incompatible pointer type [enab=
led by default]</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">../../include/babeltrace/ctf/events.h:196:=
5: note: expected 'const struct declaration *' but argument is of type 'con=
st struct definition *'</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c: In function 'init_babel=
trace':</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c:6020:61: error: 'BT_SEEK=
_END' undeclared (first use in this function)</span></div>=20
<div>=20
	<span style=3D"font-size:16px;">babeltrace_wrap.c:6020:61: note: each unde=
clared identifier is reported only once for each function it appears in</sp=
an></div>=20
<div>=20
	<span style=3D"font-size:16px;">make[3]: *** [_babeltrace_la-babeltrace_wr=
ap.lo] Error 1<br />=20
	<br />=20
	I got the source code by checking out&nbsp;&nbsp;bindings/python (</span><=
span style=3D"font-size: 16px; ">git checkout&nbsp;</span><span style=3D"fo=
nt-size: 16px; ">bindings/python</span><span style=3D"font-size: 16px; ">).=
<br />=20
	<br />=20
	I will be grateful if someone would tell how to fix the error.<br />=20
	<br />=20
	<br />=20
	<br />=20
	Thanks,<br />=20
	<br />=20
	Geoffrey</span></div>=20
<div>=20
	=C2=A0</div>=20
</span></span>

--========GMXBoundary28800135585604526273--


--===============0348272094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0348272094==--
