From: =?UTF-8?Q?D=C3=A1vid_Beck?= <david.beck.priv@gmail.com>
Subject: Re: Patch for lttng tools to build on Mac OSX 10.11.6
Date: Tue, 23 May 2017 14:50:26 +0100
Message-ID: <CAA85PfLgiW329AhYcSbup+8jBz=25-pEM7LUC962ucUc3M6Gkw__33608.9065102444$1495547443$gmane$org@mail.gmail.com>
References: <A82E93B1-509F-424C-B36F-7011D685BDC9@gmail.com>
 <CA+jJMxvpuZHDpOF2QvePMihbLRPFme_XpaLmWgzVOmx7QnWhYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3311565065383395065=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-x235.google.com (mail-lf0-x235.google.com
 [IPv6:2a00:1450:4010:c07::235])
 by lists.lttng.org (Postfix) with ESMTPS id 3wXH4P2wJ0z10Lg
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2017 13:51:15 +0000 (UTC)
Received: by mail-lf0-x235.google.com with SMTP id h4so49336769lfj.3
 for <lttng-dev@lists.lttng.org>; Tue, 23 May 2017 06:50:28 -0700 (PDT)
In-Reply-To: <CA+jJMxvpuZHDpOF2QvePMihbLRPFme_XpaLmWgzVOmx7QnWhYQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3311565065383395065==
Content-Type: multipart/alternative; boundary="001a113f219a1e87ce0550314501"

--001a113f219a1e87ce0550314501
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi J=C3=A9r=C3=A9mie,

I guess this is my lack of lttng understanding.

I wanted to play around with relayd on Mac by having a Linux box generating
the traces and give it a remote relayd for storing the traces locally on my
Mac.

I was thinking that I don't need a local sessiond on the Mac for this, do I=
?

To answer your question I want to play around with Rust and Lttng on Mac
because I have a few ideas of how to generate a few statistical performance
metrics from the traces. Since this is a midnight project I have the luxury
to do it in a language that I like as opposed to Java (the viewer) or
C/Python (Babeltrace). So eventually I want to build an event collector in
Rust, and to test the data flow I thought it is good to have the relayd on
Mac.

Thank you, David


2017. m=C3=A1j. 23. du. 2:34 ezt =C3=ADrta ("J=C3=A9r=C3=A9mie Galarneau" <
jeremie.galarneau@efficios.com>):

Hi David,

I'm just wondering what is your use-case for building the lttng client
if the session daemon is not built?
We typically also disable building the client (--disable-bin-lttng)
when building the lttng-relayd for macOS.

Thanks,
J=C3=A9r=C3=A9mie

On 21 May 2017 at 11:30, D=C3=A1vid Beck <david.beck.priv@gmail.com> wrote:
> Hello Lttng Devs,
>
> Please find a patch attached for building lttng tools with these configur=
e
> flags (on Max OSX):
>
> ./configure --without-lttng-ust --disable-man-pages
> --disable-bin-lttng-consumerd --disable-bin-lttng-sessiond
> --disable-bin-lttng-crash --disable-kmod --disable-extras
>
>
> Best, David
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--001a113f219a1e87ce0550314501
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto">Hi=C2=A0J=C3=A9r=C3=A9mie,</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I guess this is my lack of lttng unde=
rstanding.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I wanted to p=
lay around with relayd on Mac by having a Linux box generating the traces a=
nd give it a remote relayd for storing the traces locally on my Mac.</div><=
div dir=3D"auto"><br></div><div dir=3D"auto">I was thinking that I don&#39;=
t need a local sessiond on the Mac for this, do I?</div><div dir=3D"auto"><=
br></div><div>To answer your question I want to play around with Rust and L=
ttng on Mac because I have a few ideas of how to generate a few statistical=
 performance metrics from the traces. Since this is a midnight project I ha=
ve the luxury to do it in a language that I like as opposed to Java (the vi=
ewer) or C/Python (Babeltrace). So eventually I want to build an event coll=
ector in Rust, and to test the data flow I thought it is good to have the r=
elayd on Mac.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thank you,=
 David<br><div><br></div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">2017. m=C3=A1j. 23. du. 2:34 ezt =C3=ADrta (&quot;J=C3=A9r=C3=A9mie=
 Galarneau&quot; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com" targ=
et=3D"_blank">jeremie.galarneau@efficios.<wbr>com</a>&gt;):<br type=3D"attr=
ibution"><blockquote class=3D"gmail-m_4540418638275209943quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Hi David,<br>
<br>
I&#39;m just wondering what is your use-case for building the lttng client<=
br>
if the session daemon is not built?<br>
We typically also disable building the client (--disable-bin-lttng)<br>
when building the lttng-relayd for macOS.<br>
<br>
Thanks,<br>
J=C3=A9r=C3=A9mie<br>
<div class=3D"gmail-m_4540418638275209943elided-text"><br>
On 21 May 2017 at 11:30, D=C3=A1vid Beck &lt;<a href=3D"mailto:david.beck.p=
riv@gmail.com" target=3D"_blank">david.beck.priv@gmail.com</a>&gt; wrote:<b=
r>
&gt; Hello Lttng Devs,<br>
&gt;<br>
&gt; Please find a patch attached for building lttng tools with these confi=
gure<br>
&gt; flags (on Max OSX):<br>
&gt;<br>
&gt; ./configure --without-lttng-ust --disable-man-pages<br>
&gt; --disable-bin-lttng-consumerd --disable-bin-lttng-sessiond<br>
&gt; --disable-bin-lttng-crash --disable-kmod --disable-extras<br>
&gt;<br>
&gt;<br>
&gt; Best, David<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div>&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/=
mailman/listinfo/lttng-dev</a><br>
&gt;<br>
<font color=3D"#888888"><br>
<br>
<br>
--<br>
J=C3=A9r=C3=A9mie Galarneau<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
</font></blockquote></div><br></div></div>
</div>

--001a113f219a1e87ce0550314501--

--===============3311565065383395065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3311565065383395065==--
