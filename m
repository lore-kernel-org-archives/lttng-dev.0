From: Vijay Anand <vjanandr85@gmail.com>
Subject: Re: subbuffers count and size
Date: Tue, 28 Jun 2016 12:44:09 +0530
Message-ID: <CAHxF_R9gUJhe3Tqv=Ju=GG4Oi+E44JwpP5dRCiKGtJ4x01BEBA__8796.40797288648$1467098080$gmane$org@mail.gmail.com>
References: <CAHxF_R85MSZ5LqvH1JGUXyj2HaMNfyO7pT7ypQ=o=zoE1F4ybw@mail.gmail.com>
 <5771452E.6070509@gydle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4048370586519233232=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 49EB8A2B2F
 for <lttng-dev@lists.lttng.org>; Tue, 28 Jun 2016 07:14:10 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id v199so126596883wmv.0
 for <lttng-dev@lists.lttng.org>; Tue, 28 Jun 2016 00:14:10 -0700 (PDT)
In-Reply-To: <5771452E.6070509@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4048370586519233232==
Content-Type: multipart/alternative; boundary=047d7ba97b941e7e6c053651627c

--047d7ba97b941e7e6c053651627c
Content-Type: text/plain; charset=UTF-8

Hi Sebastien,

I have written a simple program with a loop 1 million times adding a trace
everytime.
Please find the simple program at
https://github.com/vjanandr/sampleC/blob/master/lttng/benchmark/lttng_benchmark.c

I first configured the channel and then ran the benchmark program.
More logs @
https://gist.github.com/vjanandr/1db6a6a9d93e6b3f2ac30a05aadcf06b

Here is the observation below:

a. default 4 subbuffers with 128K each takes 1894063 microseconds
b. 16 subbuffers with 1024K each takes 1882392 microseconds
b. 16 subbuffer with 2M each takes 1884999 microseconds

on an average the programs takes about 1.8 seconds for each run.

Is this expected ?, if I have to improve the performance should I configure
anything different ?

Just that I understand this better, I have been trying to understand this
from looking at the code. Could you please point me to the code that might
be impacting this ?

Regards,
Vijay

On Mon, Jun 27, 2016 at 8:54 PM, Sebastien Boisvert <sboisvert@gydle.com>
wrote:

> Hi Vijay,
>
>
> On 06/27/2016 06:12 AM, Vijay Anand wrote:
> > Hi,
> >
> > I have been trying to understand the impact of performance while logging
> user space program based on the subbuffer count and size.
> >
>
> The sub-buffers count and size is well-documented here:
>
>     http://lttng.org/docs/#doc-channel-subbuf-size-vs-subbuf-count
>
>
>
> > I have a simple program logging 1 million traces
>
> Do you mean that you recorded 1 million UST events ?
>
> Or do you mean that you traced your app 1 million times and you generated
> 1 million traces ?
>
>
> > and I dont seem to see any appreciable performance between the below two
> configurations.
> >
> > a. default 4 subbufers 128KB each
> > b. 16 subbufers with 1024kB each.
>
> When you are enabling your UST events (before starting the LTTng session),
> are you enabling your UST events in your custom channel (the one with
> configuration a. or configuration b.) ?
>
>
> If not, it could explain the lack of difference in performance between
> your 2 configurations.
>
>
> Example:
>
>     lttng create
>
>     lttng enable-channel -u --subbuf-size 4M channel7
>     lttng enable-event -u -c channel7
> gydle_om:Allocator_constructor_default
>
>     lttng start
>
>     run-your-app
>
>     lttng stop
>     lttng view > trace.txt
>
>
>
> >
> > Moreover I have been looking at the lttng-ust code to understand the
> performance impacts from the implementation and unable to comprehend what
> is documented at
> >
> > http://lttng.org/docs/#doc-channel-subbuf-size-vs-subbuf-count
> >
> > I see that channel_backend_init, _shm_object_table_alloc_shm seems to
> allocate one big shared memory chunk which again is subdivided into
> subbuffers with each subbuffer referenced using the subbufer index.
> >
> > Further more lib_ring_buffer_write seems to find the subbuffer index and
> write "len" number of bytes into the subbuffer index.
> >
> > Could anyone please enlighten me what is the overhead involved while
> switching from one subbufer to another as documented.
> >
>
> The documentation indicates that the tracer's CPU overhead is caused by 2
> things:
>
> 1) marking the current sub-buffer as consumable, and
> 2) switching to an empty sub-buffer.
>
>
>
>
> > Regards,
> > Vijay
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
>

--047d7ba97b941e7e6c053651627c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif;font-size:small"><font color=3D"#000000">Hi Sebastien,</font></d=
iv><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;fon=
t-size:small"><font color=3D"#000000"><br></font></div><div class=3D"gmail_=
default" style=3D"font-family:verdana,sans-serif;font-size:small"><font col=
or=3D"#000000">I have written a simple program with a loop 1 million times =
adding a trace everytime.</font></div><div class=3D"gmail_default" style=3D=
"font-family:verdana,sans-serif;font-size:small"><font color=3D"#000000">Pl=
ease find the simple program at=C2=A0<a href=3D"https://github.com/vjanandr=
/sampleC/blob/master/lttng/benchmark/lttng_benchmark.c">https://github.com/=
vjanandr/sampleC/blob/master/lttng/benchmark/lttng_benchmark.c</a></font></=
div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;fo=
nt-size:small"><font color=3D"#000000"><br></font></div><div class=3D"gmail=
_default" style=3D"font-family:verdana,sans-serif;font-size:small"><font co=
lor=3D"#000000">I first configured the channel and then ran the benchmark p=
rogram.</font></div><div class=3D"gmail_default" style=3D"font-family:verda=
na,sans-serif;font-size:small"><font color=3D"#000000">More logs @=C2=A0<a =
href=3D"https://gist.github.com/vjanandr/1db6a6a9d93e6b3f2ac30a05aadcf06b">=
https://gist.github.com/vjanandr/1db6a6a9d93e6b3f2ac30a05aadcf06b</a></font=
></div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif=
;font-size:small"><font color=3D"#000000"><br></font></div><div class=3D"gm=
ail_default" style=3D"font-family:verdana,sans-serif;font-size:small"><font=
 color=3D"#000000">Here is the observation below:</font></div><div class=3D=
"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:small"><f=
ont color=3D"#000000"><br></font></div><div class=3D"gmail_default" style=
=3D"font-family:verdana,sans-serif;font-size:small"><font color=3D"#000000"=
>a. default 4 subbuffers with 128K each takes 1894063 microseconds</font></=
div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;fo=
nt-size:small"><font color=3D"#000000">b. 16 subbuffers with 1024K each tak=
es 1882392 microseconds</font></div><div class=3D"gmail_default" style=3D""=
><font color=3D"#000000"><font face=3D"verdana, sans-serif">b. 16 subbuffer=
 with 2M each takes 1884999 microseconds</font><br></font></div><div class=
=3D"gmail_default" style=3D"font-family:verdana,sans-serif;font-size:small"=
><font color=3D"#000000"><br></font></div><div class=3D"gmail_default" styl=
e=3D"font-family:verdana,sans-serif;font-size:small"><font color=3D"#000000=
">on an average the programs takes about 1.8 seconds for each run.</font></=
div><div class=3D"gmail_default" style=3D"font-family:verdana,sans-serif;fo=
nt-size:small"><font color=3D"#000000"><br></font></div><div class=3D"gmail=
_default" style=3D"font-family:verdana,sans-serif;font-size:small"><font co=
lor=3D"#000000">Is this expected ?, if I have to improve the performance sh=
ould I configure anything different ?</font></div><div class=3D"gmail_defau=
lt" style=3D"font-family:verdana,sans-serif;font-size:small"><font color=3D=
"#000000"><br></font></div><div class=3D"gmail_default" style=3D"font-famil=
y:verdana,sans-serif;font-size:small"><font color=3D"#000000">Just that I u=
nderstand this better, I have been trying to understand this from looking a=
t the code. Could you please point me to the code that might be impacting t=
his ?</font></div></div><div class=3D"gmail_extra"><br clear=3D"all"><div><=
div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><font face=3D"verdana, sans-serif" color=3D"#0000ff">Regards,</fon=
t><div><font face=3D"verdana, sans-serif" color=3D"#0000ff">Vijay</font></d=
iv></div></div></div>
<br><div class=3D"gmail_quote">On Mon, Jun 27, 2016 at 8:54 PM, Sebastien B=
oisvert <span dir=3D"ltr">&lt;<a href=3D"mailto:sboisvert@gydle.com" target=
=3D"_blank">sboisvert@gydle.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi Vijay,<br>
<span class=3D""><br>
<br>
On 06/27/2016 06:12 AM, Vijay Anand wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I have been trying to understand the impact of performance while loggi=
ng user space program based on the subbuffer count and size.<br>
&gt;<br>
<br>
</span>The sub-buffers count and size is well-documented here:<br>
<br>
=C2=A0 =C2=A0 <a href=3D"http://lttng.org/docs/#doc-channel-subbuf-size-vs-=
subbuf-count" rel=3D"noreferrer" target=3D"_blank">http://lttng.org/docs/#d=
oc-channel-subbuf-size-vs-subbuf-count</a><br>
<span class=3D""><br>
<br>
<br>
&gt; I have a simple program logging 1 million traces<br>
<br>
</span>Do you mean that you recorded 1 million UST events ?<br>
<br>
Or do you mean that you traced your app 1 million times and you generated 1=
 million traces ?<br>
<span class=3D""><br>
<br>
&gt; and I dont seem to see any appreciable performance between the below t=
wo configurations.<br>
&gt;<br>
&gt; a. default 4 subbufers 128KB each<br>
&gt; b. 16 subbufers with 1024kB each.<br>
<br>
</span>When you are enabling your UST events (before starting the LTTng ses=
sion),<br>
are you enabling your UST events in your custom channel (the one with confi=
guration a. or configuration b.) ?<br>
<br>
<br>
If not, it could explain the lack of difference in performance between your=
 2 configurations.<br>
<br>
<br>
Example:<br>
<br>
=C2=A0 =C2=A0 lttng create<br>
<br>
=C2=A0 =C2=A0 lttng enable-channel -u --subbuf-size 4M channel7<br>
=C2=A0 =C2=A0 lttng enable-event -u -c channel7 gydle_om:Allocator_construc=
tor_default<br>
<br>
=C2=A0 =C2=A0 lttng start<br>
<br>
=C2=A0 =C2=A0 run-your-app<br>
<br>
=C2=A0 =C2=A0 lttng stop<br>
=C2=A0 =C2=A0 lttng view &gt; trace.txt<br>
<span class=3D""><br>
<br>
<br>
&gt;<br>
&gt; Moreover I have been looking at the lttng-ust code to understand the p=
erformance impacts from the implementation and unable to comprehend what is=
 documented at<br>
&gt;<br>
&gt; <a href=3D"http://lttng.org/docs/#doc-channel-subbuf-size-vs-subbuf-co=
unt" rel=3D"noreferrer" target=3D"_blank">http://lttng.org/docs/#doc-channe=
l-subbuf-size-vs-subbuf-count</a><br>
&gt;<br>
&gt; I see that channel_backend_init, _shm_object_table_alloc_shm seems to =
allocate one big shared memory chunk which again is subdivided into subbuff=
ers with each subbuffer referenced using the subbufer index.<br>
&gt;<br>
&gt; Further more lib_ring_buffer_write seems to find the subbuffer index a=
nd write &quot;len&quot; number of bytes into the subbuffer index.<br>
&gt;<br>
&gt; Could anyone please enlighten me what is the overhead involved while s=
witching from one subbufer to another as documented.<br>
&gt;<br>
<br>
</span>The documentation indicates that the tracer&#39;s CPU overhead is ca=
used by 2 things:<br>
<br>
1) marking the current sub-buffer as consumable, and<br>
2) switching to an empty sub-buffer.<br>
<br>
<br>
<br>
<br>
&gt; Regards,<br>
&gt; Vijay<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
&gt;<br>
</blockquote></div><br></div>

--047d7ba97b941e7e6c053651627c--

--===============4048370586519233232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4048370586519233232==--
