From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Processing large trace files
Date: Tue, 10 Jul 2018 11:32:42 -0400
Message-ID: <CAC-H6ttKES1etr8MY1nNJQDKCw1KDAejW6fpouFKM92Ap1330A__8995.97237953476$1531236646$gmane$org@mail.gmail.com>
References: <CAC-H6tsw80-0R+06MJi7k9yz41C=oMp25gZOujVk7JjqEtOpNQ@mail.gmail.com>
 <20180710133745.GB4999@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2672871745142485646=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by lists.lttng.org (Postfix) with ESMTPS id 41Q5mr6KQbztm3
 for <lttng-dev@lists.lttng.org>; Tue, 10 Jul 2018 11:32:44 -0400 (EDT)
Received: by mail-lj1-x22d.google.com with SMTP id t21-v6so17069192lji.0
 for <lttng-dev@lists.lttng.org>; Tue, 10 Jul 2018 08:32:44 -0700 (PDT)
In-Reply-To: <20180710133745.GB4999@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2672871745142485646==
Content-Type: multipart/alternative; boundary="000000000000552be40570a6d78f"

--000000000000552be40570a6d78f
Content-Type: text/plain; charset="UTF-8"

I haven't tried the C API yet.

A smaller trace of about 2.7GB took +5 hrs before I had to kill the
process.

As for trace cutting, that sounds promising. How broken is it in babeltrace
2? I mean, can I use it to some extent or is it not functioning at all?

Thanks!

Shehab Y. Elsayed, MSc.
PhD Student
The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
University of Toronto
E-mail: shehabyomn@gmail.com
<https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>

On Tue, Jul 10, 2018 at 9:37 AM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Shehab,
>
> On Mon, Jul 09, 2018 at 06:48:05PM -0400, Shehab Elsayed wrote:
> > Hello All,
> >
> > I was wondering if anyone had any suggestions on how to speedup trace
> > processing. Right now I am using babeltrace in python to read the traces
> > and process them. Some of the traces I am dealing with reach up to 10GB.
>
> Well Babeltrace also provide a C API. You might get some performance gains
> there.
>
> Depending of the data you extract you might be able to split the 10 GB
> trace
> into smaller chunk and parallelize your analysis. Babeltrace 2 will support
> trace cutting, it seems that it is broken for now. Babeltrace 1 does not
> support
> trace cutting.
>
> You might want to look at ways to reduce the size of your traces using
> tracing
> mechanism such as the snapshot feature and enabling/recording only
> pertinent
> event if it is not already the case.
>
> Could you share with us the time it take for analyzing your bigger trace?
>
> Cheers
>
> >
> > I read the trace, extract the info I need and write them to a csv gzipped
> > file (all in python). I fill up a list first with all extracted info for
> > each tracked event and then write once after the script has gone through
> > all events in the trace.
> >
> > Thanks,
> > Shehab
>
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--000000000000552be40570a6d78f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I haven&#39;t tried the C API yet. <br></div><div><br=
></div><div>A smaller trace of about 2.7GB took +5 hrs before I had to kill=
 the process. <br></div><div><br></div><div>As for trace cutting, that soun=
ds promising. How broken is it in babeltrace 2? I mean, can I use it to som=
e extent or is it not functioning at all?</div><div><br></div><div>Thanks!<=
br></div></div><div class=3D"gmail_extra"><br clear=3D"all"><div><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><f=
ont color=3D"#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </font><font color=3D"#888888"><a value=
=3D"+20124498360"><span dir=3D"ltr"></span></a><br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></font></div></=
div></div>
<br><div class=3D"gmail_quote">On Tue, Jul 10, 2018 at 9:37 AM, Jonathan Ra=
jotte-Julien <span dir=3D"ltr">&lt;<a href=3D"mailto:jonathan.rajotte-julie=
n@efficios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Shehab,<br>
<span class=3D""><br>
On Mon, Jul 09, 2018 at 06:48:05PM -0400, Shehab Elsayed wrote:<br>
&gt; Hello All,<br>
&gt; <br>
&gt; I was wondering if anyone had any suggestions on how to speedup trace<=
br>
&gt; processing. Right now I am using babeltrace in python to read the trac=
es<br>
&gt; and process them. Some of the traces I am dealing with reach up to 10G=
B.<br>
<br>
</span>Well Babeltrace also provide a C API. You might get some performance=
 gains there.<br>
<br>
Depending of the data you extract you might be able to split the 10 GB trac=
e<br>
into smaller chunk and parallelize your analysis. Babeltrace 2 will support=
<br>
trace cutting, it seems that it is broken for now. Babeltrace 1 does not su=
pport<br>
trace cutting.<br>
<br>
You might want to look at ways to reduce the size of your traces using trac=
ing<br>
mechanism such as the snapshot feature and enabling/recording only pertinen=
t<br>
event if it is not already the case.<br>
<br>
Could you share with us the time it take for analyzing your bigger trace?<b=
r>
<br>
Cheers<br>
<span class=3D""><br>
&gt; <br>
&gt; I read the trace, extract the info I need and write them to a csv gzip=
ped<br>
&gt; file (all in python). I fill up a list first with all extracted info f=
or<br>
&gt; each tracked event and then write once after the script has gone throu=
gh<br>
&gt; all events in the trace.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Shehab<br>
<br>
</span>&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</font></span></blockquote></div><br></div>

--000000000000552be40570a6d78f--

--===============2672871745142485646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2672871745142485646==--
