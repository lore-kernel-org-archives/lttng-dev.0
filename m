From: John Smith <whalajam@gmail.com>
Subject: Re: "lttng enable-channel --tracefile-size" bug
Date: Sat, 28 May 2016 14:59:13 -0700
Message-ID: <CANgVouUbJtNjBDajia1E3+CCEg95-=tnqfzBW7ukQxQbn9N_6Q__12466.4285257042$1464631045$gmane$org@mail.gmail.com>
References: <CANgVouVswhgXmy=Dge5h2FA-7xsaJfDqOZ3=seG5dHjP=_4gmA@mail.gmail.com>
 <57499B75.80203@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6650290145456519963=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 610D5A36D9
 for <lttng-dev@lists.lttng.org>; Sat, 28 May 2016 21:59:14 +0000 (UTC)
Received: by mail-oi0-f67.google.com with SMTP id x130so19048572oia.3
 for <lttng-dev@lists.lttng.org>; Sat, 28 May 2016 14:59:14 -0700 (PDT)
In-Reply-To: <57499B75.80203@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============6650290145456519963==
Content-Type: multipart/alternative; boundary=001a1141c7803bb23c0533ee22c0

--001a1141c7803bb23c0533ee22c0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Julien,
thanks, I was mislead by the 2.7 documentation saying:
"...parameters of enable-channel are --tracefile-sizeand --tracefile-count,
which respectively limit the size of each trace file and the their count
for a given channel. "
In this case the tracefile-size option should be removed, will it become
useful in the future releases or has a more subtle use?

thanks, John

On Sat, May 28, 2016 at 6:21 AM, Julien Desfossez <jdesfossez@efficios.com>
wrote:

> > Hi,
> > it looks like for the "enable-channel" command, "tracefile-size" option
> > doesn't take effect, bellow are all the options, the resulted files hav=
e
> > the actual size the same as the size specified by subbuf-size option:
> >
> > # lttng -V
> > lttng (LTTng Trace Control) 2.7.1 - Herbe =C3=A0 D=C3=A9tourne
> >
> > $ lttng enable-channel chan_name -u -s session_name --discard
> > --num-subbuf 8
> >             --subbuf-size 32M --tracefile-size 8K --tracefile-count 8
> > --buffers-pid
>
> Yes, that is the expected behaviour, we work with packets (sub-buffers),
> so the smallest unit we can store is the subbuf-size.
>
> With 2.7.3 I get this warning when I try your command:
> Warning: Tracefile size rounded up from (8192) to subbuffer size (3355443=
2)
>
> Julien
>

--001a1141c7803bb23c0533ee22c0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Julien,</div>thanks, I was mislead by the 2.7 documen=
tation saying:<div>&quot;...<span style=3D"color:rgb(26,26,26);font-family:=
&#39;Open Sans&#39;,Frutiger,&#39;Frutiger Linotype&#39;,Univers,Calibri,&#=
39;Gill Sans&#39;,&#39;Gill Sans MT&#39;,&#39;Myriad Pro&#39;,Myriad,&#39;D=
ejaVu Sans Condensed&#39;,&#39;Liberation Sans&#39;,&#39;Nimbus Sans L&#39;=
,Tahoma,Geneva,&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;font-siz=
e:16px;line-height:27.2px;background-color:rgb(253,253,253)">parameters of=
=C2=A0</span><code class=3D"" style=3D"margin:0px 1px;padding:2px 5px;borde=
r:0px;font-stretch:inherit;font-size:14.4px;line-height:27.2px;font-family:=
&#39;Andale Mono WT&#39;,&#39;Andale Mono&#39;,&#39;Bitstream Vera Sans Mon=
o&#39;,&#39;Liberation Mono&#39;,&#39;Nimbus Mono L&#39;,&#39;Ubuntu Mono&#=
39;,Monaco,Consolas,&#39;Lucida Console&#39;,&#39;Lucida Sans Typewriter&#3=
9;,&#39;Courier New&#39;,Courier,monospace;vertical-align:baseline;white-sp=
ace:nowrap;color:rgb(26,26,26);background-color:rgba(0,0,0,0.0470588)">enab=
le-channel</code><span style=3D"color:rgb(26,26,26);font-family:&#39;Open S=
ans&#39;,Frutiger,&#39;Frutiger Linotype&#39;,Univers,Calibri,&#39;Gill San=
s&#39;,&#39;Gill Sans MT&#39;,&#39;Myriad Pro&#39;,Myriad,&#39;DejaVu Sans =
Condensed&#39;,&#39;Liberation Sans&#39;,&#39;Nimbus Sans L&#39;,Tahoma,Gen=
eva,&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;font-size:16px;line=
-height:27.2px;background-color:rgb(253,253,253)">=C2=A0are=C2=A0</span><co=
de class=3D"" style=3D"margin:12px 1px 0px;padding:2px 5px;border:0px;font-=
stretch:inherit;font-size:14.4px;line-height:27.2px;font-family:&#39;Andale=
 Mono WT&#39;,&#39;Andale Mono&#39;,&#39;Bitstream Vera Sans Mono&#39;,&#39=
;Liberation Mono&#39;,&#39;Nimbus Mono L&#39;,&#39;Ubuntu Mono&#39;,Monaco,=
Consolas,&#39;Lucida Console&#39;,&#39;Lucida Sans Typewriter&#39;,&#39;Cou=
rier New&#39;,Courier,monospace;vertical-align:baseline;white-space:nowrap;=
color:rgb(26,26,26);background-color:rgba(0,0,0,0.0470588)">--tracefile-siz=
e</code><span style=3D"color:rgb(26,26,26);font-family:&#39;Open Sans&#39;,=
Frutiger,&#39;Frutiger Linotype&#39;,Univers,Calibri,&#39;Gill Sans&#39;,&#=
39;Gill Sans MT&#39;,&#39;Myriad Pro&#39;,Myriad,&#39;DejaVu Sans Condensed=
&#39;,&#39;Liberation Sans&#39;,&#39;Nimbus Sans L&#39;,Tahoma,Geneva,&#39;=
Helvetica Neue&#39;,Helvetica,Arial,sans-serif;font-size:16px;line-height:2=
7.2px;background-color:rgb(253,253,253)">and=C2=A0</span><code class=3D"" s=
tyle=3D"margin:12px 1px 0px;padding:2px 5px;border:0px;font-stretch:inherit=
;font-size:14.4px;line-height:27.2px;font-family:&#39;Andale Mono WT&#39;,&=
#39;Andale Mono&#39;,&#39;Bitstream Vera Sans Mono&#39;,&#39;Liberation Mon=
o&#39;,&#39;Nimbus Mono L&#39;,&#39;Ubuntu Mono&#39;,Monaco,Consolas,&#39;L=
ucida Console&#39;,&#39;Lucida Sans Typewriter&#39;,&#39;Courier New&#39;,C=
ourier,monospace;vertical-align:baseline;white-space:nowrap;color:rgb(26,26=
,26);background-color:rgba(0,0,0,0.0470588)">--tracefile-count</code><span =
style=3D"color:rgb(26,26,26);font-family:&#39;Open Sans&#39;,Frutiger,&#39;=
Frutiger Linotype&#39;,Univers,Calibri,&#39;Gill Sans&#39;,&#39;Gill Sans M=
T&#39;,&#39;Myriad Pro&#39;,Myriad,&#39;DejaVu Sans Condensed&#39;,&#39;Lib=
eration Sans&#39;,&#39;Nimbus Sans L&#39;,Tahoma,Geneva,&#39;Helvetica Neue=
&#39;,Helvetica,Arial,sans-serif;font-size:16px;line-height:27.2px;backgrou=
nd-color:rgb(253,253,253)">, which respectively limit the size of each trac=
e file and the their count for a given channel. &quot;</span></div><div><sp=
an style=3D"color:rgb(26,26,26);font-family:&#39;Open Sans&#39;,Frutiger,&#=
39;Frutiger Linotype&#39;,Univers,Calibri,&#39;Gill Sans&#39;,&#39;Gill San=
s MT&#39;,&#39;Myriad Pro&#39;,Myriad,&#39;DejaVu Sans Condensed&#39;,&#39;=
Liberation Sans&#39;,&#39;Nimbus Sans L&#39;,Tahoma,Geneva,&#39;Helvetica N=
eue&#39;,Helvetica,Arial,sans-serif;font-size:16px;line-height:27.2px;backg=
round-color:rgb(253,253,253)">In this case the tracefile-size option should=
 be removed, will it become useful in the future releases or has a more sub=
tle use?=C2=A0</span></div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">thanks, John</div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Sat, May 28, 2016 at 6:21 AM, Julien Desfossez <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:jdesfossez@efficios.com" target=3D"_blank"=
>jdesfossez@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><span class=3D"">&gt; Hi,<br>
&gt; it looks like for the &quot;enable-channel&quot; command, &quot;tracef=
ile-size&quot; option<br>
&gt; doesn&#39;t take effect, bellow are all the options, the resulted file=
s have<br>
&gt; the actual size the same as the size specified by subbuf-size option:<=
br>
&gt;<br>
&gt; # lttng -V<br>
&gt; lttng (LTTng Trace Control) 2.7.1 - Herbe =C3=A0 D=C3=A9tourne<br>
&gt;<br>
&gt; $ lttng enable-channel chan_name -u -s session_name --discard<br>
&gt; --num-subbuf 8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--subbuf-size 32M --tra=
cefile-size 8K --tracefile-count 8<br>
&gt; --buffers-pid<br>
<br>
</span>Yes, that is the expected behaviour, we work with packets (sub-buffe=
rs),<br>
so the smallest unit we can store is the subbuf-size.<br>
<br>
With 2.7.3 I get this warning when I try your command:<br>
Warning: Tracefile size rounded up from (8192) to subbuffer size (33554432)=
<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Julien<br>
</font></span></blockquote></div><br></div></div>

--001a1141c7803bb23c0533ee22c0--

--===============6650290145456519963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6650290145456519963==--
