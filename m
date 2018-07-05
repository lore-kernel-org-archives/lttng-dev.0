From: Vidushi Vashishth <reachvidu@gmail.com>
Subject: Re: Query reagrding babeltrace generated output
Date: Thu, 5 Jul 2018 06:10:47 +0530
Message-ID: <CAF7HkZMxPiYuY8VchPGOb5wSx5CKjez0b4XPpsiWvF-cbfZ0OA__30.4856840104506$1530799969$gmane$org@mail.gmail.com>
References: <CAF7HkZNg7yxDne042jNhZn6pmyxw98=0mBuPcx-EsEUTThXUOg@mail.gmail.com>
 <20180703143920.GA19455@joraj-alpa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0890891344438490782=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by lists.lttng.org (Postfix) with ESMTPS id 41LfD131M8z19pK
 for <lttng-dev@lists.lttng.org>; Wed,  4 Jul 2018 20:40:49 -0400 (EDT)
Received: by mail-ed1-x52b.google.com with SMTP id u11-v6so5082961eds.10
 for <lttng-dev@lists.lttng.org>; Wed, 04 Jul 2018 17:40:49 -0700 (PDT)
In-Reply-To: <20180703143920.GA19455@joraj-alpa>
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
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0890891344438490782==
Content-Type: multipart/alternative; boundary="0000000000005fd84b057035cc15"

--0000000000005fd84b057035cc15
Content-Type: text/plain; charset="UTF-8"

Sorry for the delayed response.

>We would need the complete "babeltrace run" command. But it seems that
this is a
permission problem more than a problem with babeltrace

I figured it out. The problem was with my run command. I was using:

sudo babeltrace run --component=A:source.text.dmesg
--params='no-extract-timestamp=yes' --key=path --value ~/Desktop/add.txt
--component=B:sink.ctf.fs --key=path --value ~/Desktop/ --connect=A:B

The `sudo` in the command was creating problems. It works when I drop it. I
have another question, RTEMS trace output is either printed on console or
can be saved in binary files. How should I go about creating a plugin for
RTEMS binary output? Are there any samples or documentation which can guide
me in this regard?

Thanks

On Tue, Jul 3, 2018 at 8:09 PM, Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi Vidushi,
>
> On Tue, Jul 03, 2018 at 12:23:04AM +0530, Vidushi Vashishth wrote:
> > Hi!
> >
> > I am Vidushi. I am working on adding CTF trace generation capability to
> the
> > tracing framework of RTEMS this summer (as a part of my GSoC project).
>
> Nice!
>
> >I am
> > using babeltrace in this regard. While I am able to convert the RTEMS
> text
> > output to CTF format using `babeltrace run` on the command line, the
> output
> > is stored in a directory which does not have access permissions.
>
> We would need the complete "babeltrace run" command. But it seems that
> this is a
> permission problem more than a problem with babeltrace.
>
> > I am able
> > to get inside the directory by changing permissions (chmod) and list its
> > contents (sudo ls) but I cannot view the metadata and CTF stream output
> or
> > delete the said directory. Is there a way I can view/delete the contents
> of
> > the trace directory?
>
> Do you have "tree" installed on you system?
>
> Could you try "tree -ugp <directory>"
>
> What do you mean by "I cannot view the metadata and CTF stream output"?
>
> Cheers
>
>
> >
> > I am sorry if this is too obvious. I am new to this.
> >
> > Thanks
> > Vidushi Vashishth
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

--0000000000005fd84b057035cc15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sorry for the delayed response. <br></div><div><span =
style=3D"color:rgb(76,17,48)"><br></span></div><div><span style=3D"color:rg=
b(76,17,48)">&gt;We would need the complete &quot;babeltrace run&quot; comm=
and. But it seems that this is a<br>
permission problem more than a problem with babeltrace</span></div><div><br=
></div><div><font color=3D"#000000">I figured it out. The problem was with =
my run command. I was using:</font></div><div><font color=3D"#000000"><br><=
/font></div><div><font color=3D"#000000">sudo babeltrace run --component=3D=
A:source.text.dmesg --params=3D&#39;no-extract-timestamp=3Dyes&#39; --key=
=3Dpath --value ~/Desktop/add.txt --component=3DB:sink.ctf.fs --key=3Dpath =
--value ~/Desktop/ --connect=3DA:B<br></font></div><div><font color=3D"#000=
000"><br></font></div><div><span style=3D"color:rgb(0,0,0)">The `sudo` in t=
he command was creating problems. It works when I drop it. I have another q=
uestion, RTEMS trace output is either printed on console or can be saved in=
 binary files. How should I go about creating a plugin for RTEMS binary out=
put? Are there any samples or documentation which can guide me in this rega=
rd?<br></span></div><div><span style=3D"color:rgb(0,0,0)"><br></span></div>=
<div><span style=3D"color:rgb(0,0,0)">Thanks</span></div></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Jul 3, 2018 at 8:09=
 PM, Jonathan Rajotte-Julien <span dir=3D"ltr">&lt;<a href=3D"mailto:jonath=
an.rajotte-julien@efficios.com" target=3D"_blank">jonathan.rajotte-julien@e=
fficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Vidu=
shi,<br>
<span class=3D""><br>
On Tue, Jul 03, 2018 at 12:23:04AM +0530, Vidushi Vashishth wrote:<br>
&gt; Hi!<br>
&gt; <br>
&gt; I am Vidushi. I am working on adding CTF trace generation capability t=
o the<br>
&gt; tracing framework of RTEMS this summer (as a part of my GSoC project).=
<br>
<br>
</span>Nice!<br>
<span class=3D""><br>
&gt;I am<br>
&gt; using babeltrace in this regard. While I am able to convert the RTEMS =
text<br>
&gt; output to CTF format using `babeltrace run` on the command line, the o=
utput<br>
&gt; is stored in a directory which does not have access permissions.<br>
<br>
</span>We would need the complete &quot;babeltrace run&quot; command. But i=
t seems that this is a<br>
permission problem more than a problem with babeltrace.<br>
<span class=3D""><br>
&gt; I am able<br>
&gt; to get inside the directory by changing permissions (chmod) and list i=
ts<br>
&gt; contents (sudo ls) but I cannot view the metadata and CTF stream outpu=
t or<br>
&gt; delete the said directory. Is there a way I can view/delete the conten=
ts of<br>
&gt; the trace directory?<br>
<br>
</span>Do you have &quot;tree&quot; installed on you system?<br>
<br>
Could you try &quot;tree -ugp &lt;directory&gt;&quot;<br>
<br>
What do you mean by &quot;I cannot view the metadata and CTF stream output&=
quot;?<br>
<br>
Cheers<br>
<span class=3D""><br>
<br>
&gt; <br>
&gt; I am sorry if this is too obvious. I am new to this.<br>
&gt; <br>
&gt; Thanks<br>
&gt; Vidushi Vashishth<br>
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

--0000000000005fd84b057035cc15--

--===============0890891344438490782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0890891344438490782==--
