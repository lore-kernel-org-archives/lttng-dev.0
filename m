From: Alexis Martin <alexis.martin@inria.fr>
Subject: Re: Unable to use libbabeltrace for trace reading in C
	program
Date: Wed, 24 Feb 2016 09:50:41 +0100
Message-ID: <84273593-6A25-46AD-B530-4CF3EB57FB3C__14348.8101930872$1456312225$gmane$org@inria.fr>
References: <CE3666D6-C823-40D2-914A-83E17C0FDAA1@inria.fr>
 <20160224001305.GB14724@sinkpad>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3120\))
Content-Type: multipart/mixed; boundary="===============0157307004=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexis.martin@inria.fr>) id 1aYV9h-0004a2-Mc
 for lttng-dev@lists.lttng.org; Wed, 24 Feb 2016 03:50:48 -0500
In-Reply-To: <20160224001305.GB14724@sinkpad>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


--===============0157307004==
Content-Type: multipart/alternative; boundary="Apple-Mail=_79911BD1-427E-4F64-A278-B6A0E42B97BE"


--Apple-Mail=_79911BD1-427E-4F64-A278-B6A0E42B97BE
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

> On 24 Feb 2016, at 01:13, Julien Desfossez <jdesfossez@efficios.com> =
wrote:
>=20
> Hi,
>=20
>> Hi,
>>=20
>> I=E2=80=99m trying to use the babeltrace library to be able to load =
and read a CTF trace in a C program.
>>=20
>> =46rom the doc:
>>=20
>>> In order to use libbabeltrace to read a trace, the first step is to =
create a
>>> context structure and to add a trace to it. This is done using the
>>> bt_context_create() and bt_context_add_trace() functions. As long as =
this
>>> context structure is allocated and the trace is valid, the trace can =
be
>>> manipulated by the library.
>>=20
>>=20
>> But for a simple program like this:
>>=20
>>> #include <stdio.h>
>>> #include <babeltrace/context.h>
>>>=20
>>> int main(void){
>>>=20
>>>    struct bt_context *ctx =3D bt_context_create();
>>>=20
>>>    int ret =3D bt_context_add_trace(ctx, =
"/home/alex/trace/ffmpeg/kernel/", "ctf", NULL, NULL, NULL);
>>>=20
>>>    return ret;
>>>=20
>>> }
>>=20
>>=20
>> I got the following error message:
>>=20
>>> [error] [Context] Format "ctf" unknown.
>=20
> It sounds like a linking problem, try to compile with this, it should
> work:
> gcc -o a a.c -lbabeltrace -Wl,=E2=80=94no-as-needed -lbabeltrace-ctf
>=20

It was indeed a linking problem, I was linking only with the =
libbabeltrace and not also with libbabeltrace-ctf=E2=80=A6
Works perfectly now.

Thanks for helping

> I don't know if there is a cleaner solution, others will know.
>=20
> Babeltrace discovers its supported formats with the libraries loaded
> when the program starts.
>=20
> Julien


=E2=80=94
Alexis Martin
PhD. Student
INRIA / LIG POLARIS-Team=

--Apple-Mail=_79911BD1-427E-4F64-A278-B6A0E42B97BE
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><div style=3D"color: rgb(0, 0, 0); =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D"">Hi,</div><div style=3D"color: rgb(0, 0, =
0); letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><br =
class=3D""></div></div></div></div></div></div><div><blockquote =
type=3D"cite" class=3D""><div class=3D"">On 24 Feb 2016, at 01:13, =
Julien Desfossez &lt;<a href=3D"mailto:jdesfossez@efficios.com" =
class=3D"">jdesfossez@efficios.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Hi,</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">Hi,<br =
class=3D""><br class=3D"">I=E2=80=99m trying to use the babeltrace =
library to be able to load and read a CTF trace in a C program.<br =
class=3D""><br class=3D"">=46rom the doc:<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">In order to use =
libbabeltrace to read a trace, the first step is to create a<br =
class=3D"">context structure and to add a trace to it. This is done =
using the<br class=3D"">bt_context_create() and bt_context_add_trace() =
functions. As long as this<br class=3D"">context structure is allocated =
and the trace is valid, the trace can be<br class=3D"">manipulated by =
the library.<br class=3D""></blockquote><br class=3D""><br class=3D"">But =
for a simple program like this:<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">#include &lt;stdio.h&gt;<br class=3D"">#include =
&lt;babeltrace/context.h&gt;<br class=3D""><br class=3D"">int =
main(void){<br class=3D""><br class=3D"">&nbsp;&nbsp;&nbsp;struct =
bt_context *ctx =3D bt_context_create();<br class=3D""><br =
class=3D"">&nbsp;&nbsp;&nbsp;int ret =3D bt_context_add_trace(ctx, =
"/home/alex/trace/ffmpeg/kernel/", "ctf", NULL, NULL, NULL);<br =
class=3D""><br class=3D"">&nbsp;&nbsp;&nbsp;return ret;<br class=3D""><br =
class=3D"">}<br class=3D""></blockquote><br class=3D""><br class=3D"">I =
got the following error message:<br class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">[error] [Context] Format "ctf" unknown.<br =
class=3D""></blockquote></blockquote><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">It sounds like a linking problem, try to =
compile with this, it should</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">work:</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">gcc -o a a.c -lbabeltrace =
-Wl,=E2=80=94no-as-needed -lbabeltrace-ctf</span><br style=3D"font-family:=
 Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>It was =
indeed a linking problem, I was linking only with the libbabeltrace and =
not also with libbabeltrace-ctf=E2=80=A6</div><div>Works perfectly =
now.</div><div><br class=3D""></div><div>Thanks for helping</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">I don't know if there is a cleaner solution, =
others will know.</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">Babeltrace =
discovers its supported formats with the libraries loaded</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" class=3D"">when the program =
starts.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
float: none; display: inline !important;" =
class=3D"">Julien</span></div></blockquote></div><div class=3D""><br =
class=3D""><div class=3D""><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div style=3D"word-wrap: break-word; -webkit-nbsp-mode: =
space; -webkit-line-break: after-white-space;" class=3D""><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D""><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D""><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D"">=E2=80=94<br =
class=3D"">Alexis Martin<br class=3D"">PhD. Student</div><div =
style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D"">INRIA / LIG =
POLARIS-Team</div></div></div></div></div></div></div></body></html>=

--Apple-Mail=_79911BD1-427E-4F64-A278-B6A0E42B97BE--


--===============0157307004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0157307004==--
