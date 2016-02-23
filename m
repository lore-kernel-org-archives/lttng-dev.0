From: Alexis Martin <alexis.martin@inria.fr>
Subject: Unable to use libbabeltrace for trace reading in C
	program
Date: Wed, 24 Feb 2016 00:14:33 +0100
Message-ID: <CE3666D6-C823-40D2-914A-83E17C0FDAA1__26091.9937435121$1456271478$gmane$org@inria.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3120\))
Content-Type: multipart/mixed; boundary="===============0320705660=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexis.martin@inria.fr>) id 1aYMAB-0001SK-Tn
 for lttng-dev@lists.lttng.org; Tue, 23 Feb 2016 18:14:41 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0320705660==
Content-Type: multipart/alternative; boundary="Apple-Mail=_78EC5C02-F920-494B-893E-557D11FF1488"


--Apple-Mail=_78EC5C02-F920-494B-893E-557D11FF1488
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I=E2=80=99m trying to use the babeltrace library to be able to load and =
read a CTF trace in a C program.

=46rom the doc:

> In order to use libbabeltrace to read a trace, the first step is to =
create a
> context structure and to add a trace to it. This is done using the
> bt_context_create() and bt_context_add_trace() functions. As long as =
this
> context structure is allocated and the trace is valid, the trace can =
be
> manipulated by the library.


But for a simple program like this:

> #include <stdio.h>
> #include <babeltrace/context.h>
>=20
> int main(void){
>=20
>     struct bt_context *ctx =3D bt_context_create();
>    =20
>     int ret =3D bt_context_add_trace(ctx, =
"/home/alex/trace/ffmpeg/kernel/", "ctf", NULL, NULL, NULL);
>=20
>     return ret;
>=20
> }


I got the following error message:

> [error] [Context] Format "ctf" unknown.


and ret =3D -1.

The trace is a valide CTF trace that I can read using the babeltrace =
program.

I=E2=80=99m running a Debian with linux kernel 4.3
I compiled babeltrace from the git (branch master) earlier today, the =
babeltrace binary reports a version number : 2.0.0-pre
This behavior is the same if I use the Debian packages of the 1.3.1 =
version.

How can I solve this ?
Thanks,

=E2=80=94
Alexis Martin
PhD. Student
INRIA / LIG POLARIS-Team


--Apple-Mail=_78EC5C02-F920-494B-893E-557D11FF1488
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D"">Hi,</div><div class=3D""><br =
class=3D""></div><div class=3D"">I=E2=80=99m trying to use the =
babeltrace library to be able to load and read a CTF trace in a C =
program.</div><div class=3D""><br class=3D""></div><div class=3D"">=46rom =
the doc:</div><div class=3D""><br class=3D""><blockquote type=3D"cite" =
class=3D"">In order to use libbabeltrace to read a trace, the first step =
is to create a<br class=3D"">context structure and to add a trace to it. =
This is done using the<br class=3D"">bt_context_create() and =
bt_context_add_trace() functions. As long as this<br class=3D"">context =
structure is allocated and the trace is valid, the trace can be<br =
class=3D"">manipulated by the library.</blockquote></div><div =
class=3D""><br class=3D""></div><div class=3D"">But for a simple program =
like this:</div><div class=3D""><br class=3D""></div><div =
class=3D""><blockquote type=3D"cite" class=3D"">#include =
&lt;stdio.h&gt;<br class=3D"">#include &lt;babeltrace/context.h&gt;<br =
class=3D""><br class=3D"">int main(void){<br class=3D""><br =
class=3D"">&nbsp; &nbsp;&nbsp;struct bt_context *ctx =3D =
bt_context_create();<br class=3D"">&nbsp; &nbsp;&nbsp;<br =
class=3D"">&nbsp; &nbsp;&nbsp;int ret =3D bt_context_add_trace(ctx, =
"/home/alex/trace/ffmpeg/kernel/", "ctf", NULL, NULL, NULL);<br =
class=3D""><br class=3D"">&nbsp; &nbsp;&nbsp;return =
ret;</blockquote><blockquote type=3D"cite" class=3D""><br =
class=3D""></blockquote><blockquote type=3D"cite" class=3D"">}<br =
class=3D""></blockquote></div><div class=3D""><br class=3D""></div><div =
class=3D"">I got the following error message:</div><div class=3D""><br =
class=3D""></div><div class=3D""><div style=3D"margin: 0px; line-height: =
normal;" class=3D""><blockquote type=3D"cite" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">[error] =
[Context] Format "ctf" unknown.</span></blockquote></div></div><div =
class=3D""><br class=3D""></div><div class=3D"">and ret =3D =
-1.</div><div class=3D""><br class=3D""></div><div class=3D"">The trace =
is a valide CTF trace that I can read using the babeltrace =
program.</div><div class=3D""><br class=3D""></div><div class=3D""><div =
class=3D"">I=E2=80=99m running a Debian with linux kernel =
4.3</div></div><div class=3D"">I compiled babeltrace from the git =
(branch master) earlier today, the babeltrace binary reports a version =
number :&nbsp;2.0.0-pre</div><div class=3D"">This behavior is the same =
if I use the Debian packages of the&nbsp;1.3.1 version.</div><div =
class=3D""><br class=3D""></div><div class=3D"">How can I solve this =
?</div><div class=3D"">Thanks,</div><div class=3D""><br =
class=3D""></div><div class=3D"">
<div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; orphans: =
auto; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">=E2=80=94<br class=3D"">Alexis Martin<br class=3D"">PhD. =
Student</div><div style=3D"color: rgb(0, 0, 0); letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">INRIA / LIG POLARIS-Team</div></div></div></div></div>
</div>
<br class=3D""></body></html>=

--Apple-Mail=_78EC5C02-F920-494B-893E-557D11FF1488--


--===============0320705660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0320705660==--
