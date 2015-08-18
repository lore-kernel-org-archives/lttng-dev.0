From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Fix: don't access missing ctf
 trace when getting metadata
Date: Tue, 18 Aug 2015 01:58:23 +0000 (UTC)
Message-ID: <131699098.24017.1439863103972.JavaMail.zimbra__48827.105042483$1439863168$gmane$org@efficios.com>
References: <1439855624-9915-1-git-send-email-mathieu.desnoyers@efficios.com>
 <CA+jJMxsYMkE_fgBDs26Ox5xrKhsmZj60DcnmkDtksCMtqGx0kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1085350597=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZRWAe-0003H7-OY
 for lttng-dev@lists.lttng.org; Mon, 17 Aug 2015 21:58:39 -0400
In-Reply-To: <CA+jJMxsYMkE_fgBDs26Ox5xrKhsmZj60DcnmkDtksCMtqGx0kw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1085350597==
Content-Type: multipart/alternative;
	boundary="----=_Part_24016_920839965.1439863103971"

------=_Part_24016_920839965.1439863103971
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Aug 17, 2015, at 5:50 PM, Jeremie Galarneau <jeremie.galarneau@eff=
icios.com> wrote:=20

> On Mon, Aug 17, 2015 at 7:53 PM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com > wrote:

>> We can get metadata when still in the trace open functions, in which
>> case the ctf trace is now allocated nor available yet. This fixes a

> Do you mean "is neither allocated nor available yet"?

yes, sorry.=20

Thanks,=20

Mathieu=20

>> segmentation fault in stress-test.

>> Signed-off-by: Mathieu Desnoyers < mathieu.desnoyers@efficios.com >
>> ---
>> formats/lttng-live/lttng-live-comm.c | 5 +++++
>> 1 file changed, 5 insertions(+)

>> diff --git a/formats/lttng-live/lttng-live-comm.c
>> b/formats/lttng-live/lttng-live-comm.c
>> index 9b409bc..57586a1 100644
>> --- a/formats/lttng-live/lttng-live-comm.c
>> +++ b/formats/lttng-live/lttng-live-comm.c
>> @@ -600,6 +600,11 @@ int append_metadata(struct lttng_live_ctx *ctx,
>> struct lttng_live_viewer_stream *metadata;
>> char *metadata_buf =3D NULL;

>> + if (!viewer_stream->ctf_trace->handle) {

> If the ctf_trace can be unallocated, shouldn't we check for:

> if (!viewer_stream->ctf_trace) ?

> J=C3=A9r=C3=A9mie

>> + printf_verbose("append_metadata: trace handle not ready yet.\n");
>> + return 0;
>> + }
>> +
>> printf_verbose("get_next_index: new metadata needed\n");
>> ret =3D get_new_metadata(ctx, viewer_stream, &metadata_buf);
>> if (ret < 0) {
>> --
>> 2.1.4

> --
> J=C3=A9r=C3=A9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

------=_Part_24016_920839965.1439863103971
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Aug 17, 2015, at 5:50 PM, Jeremie Galarneau &lt;jeremie.galarn=
eau@efficios.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TE=
XT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=
=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On M=
on, Aug 17, 2015 at 7:53 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desno=
yers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">W=
e can get metadata when still in the trace open functions, in which<br>
case the ctf trace is now allocated nor available yet. This fixes a<br></bl=
ockquote><br><div>Do you mean "is neither allocated nor available yet"?</di=
v></div></div></div></blockquote><div><br></div><div>yes, sorry.<br data-mc=
e-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
segmentation fault in stress-test.<br><br>
Signed-off-by: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
---<br>
&nbsp;formats/lttng-live/lttng-live-comm.c | 5 +++++<br>
&nbsp;1 file changed, 5 insertions(+)<br><br>
diff --git a/formats/lttng-live/lttng-live-comm.c b/formats/lttng-live/lttn=
g-live-comm.c<br>
index 9b409bc..57586a1 100644<br>
--- a/formats/lttng-live/lttng-live-comm.c<br>
+++ b/formats/lttng-live/lttng-live-comm.c<br>
@@ -600,6 +600,11 @@ int append_metadata(struct lttng_live_ctx *ctx,<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct lttng_live_viewer_stream *metadata;<br>
&nbsp; &nbsp; &nbsp; &nbsp; char *metadata_buf =3D NULL;<br><br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (!viewer_stream-&gt;ctf_trace-&gt;handle) {<=
br></blockquote><br><div>If the ctf_trace can be unallocated, shouldn't we =
check for:</div><br><div>if (!viewer_stream-&gt;ctf_trace) ?</div><br><div>=
J=C3=A9r=C3=A9mie</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;printf_verbose("app=
end_metadata: trace handle not ready yet.\n");<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;}<br>
+<br>
&nbsp; &nbsp; &nbsp; &nbsp; printf_verbose("get_next_index: new metadata ne=
eded\n");<br>
&nbsp; &nbsp; &nbsp; &nbsp; ret =3D get_new_metadata(ctx, viewer_stream, &a=
mp;metadata_buf);<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (ret &lt; 0) {<br><span class=3D"HOEnZb"><sp=
an style=3D"color: #888888;" data-mce-style=3D"color: #888888;" color=3D"#8=
88888">--<br>
2.1.4<br>
<br>
</span></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a hr=
ef=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.com</a=
><br data-mce-bogus=3D"1"></div></div></div><br></blockquote></div><div><br=
></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyer=
s<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_24016_920839965.1439863103971--


--===============1085350597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1085350597==--
