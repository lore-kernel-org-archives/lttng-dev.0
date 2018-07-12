From: Shehab Elsayed <shehabyomn@gmail.com>
Subject: Re: Processing large trace files
Date: Thu, 12 Jul 2018 11:36:31 -0400
Message-ID: <CAC-H6tu=PcaiW0ww-_wJUXjo-+KPaBH6wvj7hbHPkyxjq7RWig__28845.1364184313$1531409679$gmane$org@mail.gmail.com>
References: <CAC-H6tsw80-0R+06MJi7k9yz41C=oMp25gZOujVk7JjqEtOpNQ@mail.gmail.com>
 <20180710133745.GB4999@joraj-alpa>
 <CAC-H6ttKES1etr8MY1nNJQDKCw1KDAejW6fpouFKM92Ap1330A@mail.gmail.com>
 <CAB4xu_2hYumLVDg2GRLUwEgz7HTaWo8PQ3u3U-QPcqpNBm3M5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8739454456557438054=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by lists.lttng.org (Postfix) with ESMTPS id 41RKmL2HG3z19Gy
 for <lttng-dev@lists.lttng.org>; Thu, 12 Jul 2018 11:36:34 -0400 (EDT)
Received: by mail-lj1-x22c.google.com with SMTP id r13-v6so22301033ljg.10
 for <lttng-dev@lists.lttng.org>; Thu, 12 Jul 2018 08:36:34 -0700 (PDT)
In-Reply-To: <CAB4xu_2hYumLVDg2GRLUwEgz7HTaWo8PQ3u3U-QPcqpNBm3M5A@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8739454456557438054==
Content-Type: multipart/alternative; boundary="000000000000b2f8700570cf2073"

--000000000000b2f8700570cf2073
Content-Type: text/plain; charset="UTF-8"

Thank you very much, Phil. I will give them a try and see if they help

Shehab Y. Elsayed, MSc.
PhD Student
The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
University of Toronto
E-mail: shehabyomn@gmail.com
<https://webmail.rice.edu/imp/message.php?mailbox=INBOX&index=11#>

On Tue, Jul 10, 2018 at 6:51 PM, Philippe Proulx <eeppeliteloop@gmail.com>
wrote:

> On Tue, Jul 10, 2018 at 11:33 AM Shehab Elsayed <shehabyomn@gmail.com>
> wrote:
> >
> > I haven't tried the C API yet.
> >
> > A smaller trace of about 2.7GB took +5 hrs before I had to kill the
> process.
>
> Wow. The Python bindings are slow by nature, but that's a lot of time!
>
> >
> > As for trace cutting, that sounds promising. How broken is it in
> babeltrace 2? I mean, can I use it to some extent or is it not functioning
> at all?
>
> It works in fact, but the master branch of Babeltrace 2 does not contain
> some important optimizations yet so it can be slow, which is already
> your issue, therefore I can't say if it will help.
>
> Once built, the command line would look like:
>
>     babeltrace /path/to/trace/dir --begin=20:32:17.182738475 \
>                --end=20:32:24.177283746 -octf -w/output/dir
>
> See babeltrace-convert(1) for more details.
>
> Try it and see if you can save time. Moreover I'm working on various
> optimizations, one of which targets faster trimming. This will be part
> of 2.0-rc1.
>
> Phil
>
> >
> > Thanks!
> >
> > Shehab Y. Elsayed, MSc.
> > PhD Student
> > The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering
> > University of Toronto
> > E-mail: shehabyomn@gmail.com
> >
> > On Tue, Jul 10, 2018 at 9:37 AM, Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
> >>
> >> Hi Shehab,
> >>
> >> On Mon, Jul 09, 2018 at 06:48:05PM -0400, Shehab Elsayed wrote:
> >> > Hello All,
> >> >
> >> > I was wondering if anyone had any suggestions on how to speedup trace
> >> > processing. Right now I am using babeltrace in python to read the
> traces
> >> > and process them. Some of the traces I am dealing with reach up to
> 10GB.
> >>
> >> Well Babeltrace also provide a C API. You might get some performance
> gains there.
> >>
> >> Depending of the data you extract you might be able to split the 10 GB
> trace
> >> into smaller chunk and parallelize your analysis. Babeltrace 2 will
> support
> >> trace cutting, it seems that it is broken for now. Babeltrace 1 does
> not support
> >> trace cutting.
> >>
> >> You might want to look at ways to reduce the size of your traces using
> tracing
> >> mechanism such as the snapshot feature and enabling/recording only
> pertinent
> >> event if it is not already the case.
> >>
> >> Could you share with us the time it take for analyzing your bigger
> trace?
> >>
> >> Cheers
> >>
> >> >
> >> > I read the trace, extract the info I need and write them to a csv
> gzipped
> >> > file (all in python). I fill up a list first with all extracted info
> for
> >> > each tracked event and then write once after the script has gone
> through
> >> > all events in the trace.
> >> >
> >> > Thanks,
> >> > Shehab
> >>
> >> > _______________________________________________
> >> > lttng-dev mailing list
> >> > lttng-dev@lists.lttng.org
> >> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >>
> >> --
> >> Jonathan Rajotte-Julien
> >> EfficiOS
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

--000000000000b2f8700570cf2073
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you very much, Phil. I will give them a try and see =
if they help<br></div><div class=3D"gmail_extra"><br clear=3D"all"><div><di=
v class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"=
ltr"><font color=3D"#888888">Shehab Y. Elsayed, MSc.<br>
PhD Student<br>The Edwards S. Rogers Sr. Dept. of Electrical and Computer E=
ngineering<br>University of Toronto </font><font color=3D"#888888"><a value=
=3D"+20124498360"><span dir=3D"ltr"></span></a><br>
E-mail: <a href=3D"https://webmail.rice.edu/imp/message.php?mailbox=3DINBOX=
&amp;index=3D11#" target=3D"_blank">shehabyomn@gmail.com</a></font></div></=
div></div>
<br><div class=3D"gmail_quote">On Tue, Jul 10, 2018 at 6:51 PM, Philippe Pr=
oulx <span dir=3D"ltr">&lt;<a href=3D"mailto:eeppeliteloop@gmail.com" targe=
t=3D"_blank">eeppeliteloop@gmail.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><span class=3D"">On Tue, Jul 10, 2018 at 11:33 AM Shehab =
Elsayed &lt;<a href=3D"mailto:shehabyomn@gmail.com">shehabyomn@gmail.com</a=
>&gt; wrote:<br>
&gt;<br>
&gt; I haven&#39;t tried the C API yet.<br>
&gt;<br>
&gt; A smaller trace of about 2.7GB took +5 hrs before I had to kill the pr=
ocess.<br>
<br>
</span>Wow. The Python bindings are slow by nature, but that&#39;s a lot of=
 time!<br>
<span class=3D""><br>
&gt;<br>
&gt; As for trace cutting, that sounds promising. How broken is it in babel=
trace 2? I mean, can I use it to some extent or is it not functioning at al=
l?<br>
<br>
</span>It works in fact, but the master branch of Babeltrace 2 does not con=
tain<br>
some important optimizations yet so it can be slow, which is already<br>
your issue, therefore I can&#39;t say if it will help.<br>
<br>
Once built, the command line would look like:<br>
<br>
=C2=A0 =C2=A0 babeltrace /path/to/trace/dir --begin=3D20:32:17.182738475 \<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--end=3D20:32:24.177=
283746 -octf -w/output/dir<br>
<br>
See babeltrace-convert(1) for more details.<br>
<br>
Try it and see if you can save time. Moreover I&#39;m working on various<br=
>
optimizations, one of which targets faster trimming. This will be part<br>
of 2.0-rc1.<br>
<br>
Phil<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; Thanks!<br>
&gt;<br>
&gt; Shehab Y. Elsayed, MSc.<br>
&gt; PhD Student<br>
&gt; The Edwards S. Rogers Sr. Dept. of Electrical and Computer Engineering=
<br>
&gt; University of Toronto<br>
&gt; E-mail: <a href=3D"mailto:shehabyomn@gmail.com">shehabyomn@gmail.com</=
a><br>
&gt;<br>
&gt; On Tue, Jul 10, 2018 at 9:37 AM, Jonathan Rajotte-Julien &lt;<a href=
=3D"mailto:jonathan.rajotte-julien@efficios.com">jonathan.rajotte-julien@<w=
br>efficios.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Shehab,<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Jul 09, 2018 at 06:48:05PM -0400, Shehab Elsayed wrote:<br=
>
&gt;&gt; &gt; Hello All,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I was wondering if anyone had any suggestions on how to speed=
up trace<br>
&gt;&gt; &gt; processing. Right now I am using babeltrace in python to read=
 the traces<br>
&gt;&gt; &gt; and process them. Some of the traces I am dealing with reach =
up to 10GB.<br>
&gt;&gt;<br>
&gt;&gt; Well Babeltrace also provide a C API. You might get some performan=
ce gains there.<br>
&gt;&gt;<br>
&gt;&gt; Depending of the data you extract you might be able to split the 1=
0 GB trace<br>
&gt;&gt; into smaller chunk and parallelize your analysis. Babeltrace 2 wil=
l support<br>
&gt;&gt; trace cutting, it seems that it is broken for now. Babeltrace 1 do=
es not support<br>
&gt;&gt; trace cutting.<br>
&gt;&gt;<br>
&gt;&gt; You might want to look at ways to reduce the size of your traces u=
sing tracing<br>
&gt;&gt; mechanism such as the snapshot feature and enabling/recording only=
 pertinent<br>
&gt;&gt; event if it is not already the case.<br>
&gt;&gt;<br>
&gt;&gt; Could you share with us the time it take for analyzing your bigger=
 trace?<br>
&gt;&gt;<br>
&gt;&gt; Cheers<br>
&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I read the trace, extract the info I need and write them to a=
 csv gzipped<br>
&gt;&gt; &gt; file (all in python). I fill up a list first with all extract=
ed info for<br>
&gt;&gt; &gt; each tracked event and then write once after the script has g=
one through<br>
&gt;&gt; &gt; all events in the trace.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Thanks,<br>
&gt;&gt; &gt; Shehab<br>
&gt;&gt;<br>
&gt;&gt; &gt; ______________________________<wbr>_________________<br>
&gt;&gt; &gt; lttng-dev mailing list<br>
&gt;&gt; &gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.=
lttng.org</a><br>
&gt;&gt; &gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-=
<wbr>bin/mailman/listinfo/lttng-dev</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; Jonathan Rajotte-Julien<br>
&gt;&gt; EfficiOS<br>
&gt;<br>
&gt;<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
</div></div></blockquote></div><br></div>

--000000000000b2f8700570cf2073--

--===============8739454456557438054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8739454456557438054==--
