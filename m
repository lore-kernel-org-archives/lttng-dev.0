From: Ilya Mirsky <ilya.mirsky@gmail.com>
Subject: Re: Performance impact using the "filter" option
Date: Wed, 19 Mar 2014 21:51:34 +0200
Message-ID: <CANRvXTMAYGjiQsRO+-4wsGQkaTVpBGtuuoUu=E-SVuMU5BXFLw__12044.2662424923$1395258841$gmane$org@mail.gmail.com>
References: <OF6F0C7C97.315DE372-ONC2257CA0.00489386-C2257CA0.0048D132@il.ibm.com>
	<1112565932.1656317.1395241782380.JavaMail.root@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2073180250=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ilya.mirsky@gmail.com>) id 1WQMXF-0008DR-MT
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 15:52:22 -0400
Received: by mail-ve0-f170.google.com with SMTP id pa12so9682039veb.1
	for <lttng-dev@lists.lttng.org>; Wed, 19 Mar 2014 12:52:16 -0700 (PDT)
In-Reply-To: <1112565932.1656317.1395241782380.JavaMail.root@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2073180250==
Content-Type: multipart/alternative; boundary=e89a8f92190656429604f4fafd11

--e89a8f92190656429604f4fafd11
Content-Type: text/plain; charset=ISO-8859-1

Amit and Michel, I appreciate your replies.
Please see my comments below.

On Wed, Mar 19, 2014 at 5:09 PM, Michel Dagenais <michel.dagenais@polymtl.ca
> wrote:

>  If I understand correctly, filtering is done at the client application
> side.
>
> With UST yes.
>
> This means that filtering could theoretically lower the performance of the
> running application which has to check, for each event, whether it should
> be sent to the daemon or not.
>
> Each event is checked against the filter and then written to the buffer or
> not. With a simple filter and most events filtered out, checking the filter
> is faster than writing to the buffer (with atomic operations to increment
> the buffer counters) and you definitely save (at each tracepoint and in the
> daemon with trace buffers filling more slowly). If the filter is
> complicated and most often keeps the event, then you certainly loose.
>

That's what I thought, but benchmarking showed that there's practically no
difference.
The filter is a simple ID comparison of the form 'id % 1,000 == 0', so 999
out of 1K tracepoints are filtered out.
Could you please point me to some references on this topic?

Thanks,
Ilya

--e89a8f92190656429604f4fafd11
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">Amit=
 and Michel, I appreciate your replies.</div><div class=3D"gmail_quote">Ple=
ase see my comments below.</div><div class=3D"gmail_quote"><br></div><div c=
lass=3D"gmail_quote">

On Wed, Mar 19, 2014 at 5:09 PM, Michel Dagenais <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:michel.dagenais@polymtl.ca" target=3D"_blank">michel.dagenais=
@polymtl.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div><div style=3D"font-size:12pt;font-family:times new roman,new york,time=
s,serif"><div class=3D""><blockquote style=3D"padding-left:5px;font-size:12=
pt;font-style:normal;margin-left:5px;font-family:Helvetica,Arial,sans-serif=
;text-decoration:none;font-weight:normal;border-left:2px solid #1010ff">

<font face=3D"sans-serif">If I understand correctly, filtering is
done at the client application side.</font>
<br></blockquote></div>With UST yes.<div class=3D""><br><blockquote style=
=3D"padding-left:5px;font-size:12pt;font-style:normal;margin-left:5px;font-=
family:Helvetica,Arial,sans-serif;text-decoration:none;font-weight:normal;b=
order-left:2px solid #1010ff">

<font face=3D"sans-serif">This means that filtering could theoretically
lower the performance of the running application which has to check, for
each event, whether it should be sent to the daemon or not.</font>
<br></blockquote></div>Each event is checked against the filter and then wr=
itten to the buffer or not. With a simple filter and most events filtered o=
ut, checking the filter is faster than writing to the buffer (with atomic o=
perations to increment the buffer counters) and you definitely save (at eac=
h tracepoint and in the daemon with trace buffers filling more slowly). If =
the filter is complicated and most often keeps the event, then you certainl=
y loose.<br>

</div></div></blockquote><div><br></div><div>That&#39;s what I thought, but=
 benchmarking showed that there&#39;s practically no difference.</div><div>=
The filter is a simple ID comparison of the form &#39;id % 1,000 =3D=3D 0&#=
39;, so 999 out of 1K tracepoints are filtered out.</div>

<div>Could you please point me to some references on this topic?</div><div>=
<br></div><div>Thanks,</div><div>Ilya</div><div>=A0</div></div><br></div></=
div>

--e89a8f92190656429604f4fafd11--


--===============2073180250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2073180250==--
