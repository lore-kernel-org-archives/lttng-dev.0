From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Missing discarded events message in live-reading
 mode
Date: Thu, 28 Sep 2017 14:04:03 +0000 (UTC)
Message-ID: <1066884817.20960.1506607443853.JavaMail.zimbra__26716.9214472689$1506607392$gmane$org@efficios.com>
References: <CAMYaK0RsEf4NaEV5ATXDyVoWq4sWQ5uLu4eWW0nVOzn43VwWGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6353822258094677153=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3y2xGh4qTCzCZ9
 for <lttng-dev@lists.lttng.org>; Thu, 28 Sep 2017 14:02:52 +0000 (UTC)
In-Reply-To: <CAMYaK0RsEf4NaEV5ATXDyVoWq4sWQ5uLu4eWW0nVOzn43VwWGw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: liguang li <liguang.lee6@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6353822258094677153==
Content-Type: multipart/alternative;
	boundary="=_407905ea-ad09-4704-be78-367e87c271d2"

--=_407905ea-ad09-4704-be78-367e87c271d2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

---- On Sep 20, 2017, at 5:37 AM, liguang li <liguang.lee6@gmail.com> wrote: 

> Hi,

> Babeltrace in live mode is not displaying the discarded events message. But
> on CTF traces the discarded events message will be printed on stderr.

> Why? Is there any restriction?

> I added the following patch into the ctf_live_packet_seek() function, and found
> it works well. Is there any side effect?

Hi, 

I re-implemented this patch to have the proper declarations exported, and tested 
it. It indeed works fine, and I don't expect odd side-effects. 

See https://lists.lttng.org/pipermail/lttng-dev/2017-September/027485.html 
for the resulting patch. 

Thanks, 

Mathieu 

> diff --git a/formats/lttng-live/lttng-live-comm.c
> b/formats/lttng-live/lttng-live-comm.c
> index a1c95bb..dc14bf5 100644
> --- a/formats/lttng-live/lttng-live-comm.c
> +++ b/formats/lttng-live/lttng-live-comm.c
> @@ -1297,6 +1297,11 @@ retry:
> ctf_update_current_packet_index(&file_stream->parent,
> prev_index, cur_index);

> + if ((&file_stream->parent)->stream_class->trace->parent.collection) {
> + ctf_print_discarded_lost(stderr, &file_stream->parent);
> + }
> +
> +
> file_stream->parent.cycles_timestamp =
> cur_index->ts_cycles.timestamp_begin;
> file_stream->parent.real_timestamp =
> ...

> Regards,
> Liguang

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_407905ea-ad09-4704-be78-367e87c271d2
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">---- On Sep 20, 2017, at 5:37 AM, liguang li &lt;liguang.lee6@gmail.com=
&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquot=
e style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;c=
olor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fa=
mily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div>Hi,<=
br><br>Babeltrace in live mode is not displaying the discarded events messa=
ge.=20
But <br>on CTF traces the discarded events message will be printed on stder=
r. <br></div><br><div>Why? Is there any restriction?<br></div><br><div>I ad=
ded the following patch into the ctf_live_packet_seek() function, and found=
</div><div>it works well. Is there any side effect?</div></div></blockquote=
><div><br></div><div>Hi,<br data-mce-bogus=3D"1"></div><div><br data-mce-bo=
gus=3D"1"></div><div>I re-implemented this patch to have the proper declara=
tions exported, and tested<br data-mce-bogus=3D"1"></div><div>it. It indeed=
 works fine, and I don't expect odd side-effects.<br data-mce-bogus=3D"1"><=
/div><div><br data-mce-bogus=3D"1"></div><div>See https://lists.lttng.org/p=
ipermail/lttng-dev/2017-September/027485.html<br data-mce-bogus=3D"1"></div=
><div>for the resulting patch.<br data-mce-bogus=3D"1"></div><div><br data-=
mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br d=
ata-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><=
br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1=
010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-s=
tyle:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fon=
t-size:12pt;"><div dir=3D"ltr"><br><div>diff --git a/formats/lttng-live/ltt=
ng-live-comm.c b/formats/lttng-live/lttng-live-comm.c<br>index a1c95bb..dc1=
4bf5 100644<br>--- a/formats/lttng-live/lttng-live-comm.c<br>+++ b/formats/=
lttng-live/lttng-live-comm.c<br>@@ -1297,6 +1297,11 @@ retry:<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ctf_update_current_packet_index(&amp;file_stream-&gt;parent,<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev_index, cur_index);<br><br>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f ((&amp;file_stream-&gt;parent)-&gt;stream_class-&gt;trace-&gt;parent.coll=
ection) {<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctf=
_print_discarded_lost(stderr, &amp;file_stream-&gt;parent);<br>+&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
<br>+<br>+<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; file_stream-&gt;parent.cycles_timestamp =3D<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cur_index-&gt;ts_cycles.timestamp_be=
gin;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; file_stream-&gt;parent.real_timestamp =3D<br></div>=
<div>...</div><br><br><div>Regards,</div><div>Liguang<br></div></div><br>__=
_____________________________________________<br>lttng-dev mailing list<br>=
lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listin=
fo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__SIG=
_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www=
.efficios.com</div></div></body></html>
--=_407905ea-ad09-4704-be78-367e87c271d2--

--===============6353822258094677153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6353822258094677153==--
