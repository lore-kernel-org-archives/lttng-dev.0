From: John Smith <whalajam@gmail.com>
Subject: Re: "lttng enable-channel --tracefile-size" bug
Date: Thu, 2 Jun 2016 17:15:06 -0700
Message-ID: <CANgVouUiQTn-TWVAwasG5VaO6jJbTvw+d9AqZbqjgfY4Y8iiig__31824.3503723808$1464979670$gmane$org@mail.gmail.com>
References: <CANgVouVswhgXmy=Dge5h2FA-7xsaJfDqOZ3=seG5dHjP=_4gmA@mail.gmail.com>
 <57499B75.80203@efficios.com>
 <CANgVouUbJtNjBDajia1E3+CCEg95-=tnqfzBW7ukQxQbn9N_6Q@mail.gmail.com>
 <574B4791.905@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8455377354401643476=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id D6DE3A0242
 for <lttng-dev@lists.lttng.org>; Fri,  3 Jun 2016 00:15:07 +0000 (UTC)
Received: by mail-oi0-f51.google.com with SMTP id e72so103481295oib.1
 for <lttng-dev@lists.lttng.org>; Thu, 02 Jun 2016 17:15:07 -0700 (PDT)
In-Reply-To: <574B4791.905@efficios.com>
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

--===============8455377354401643476==
Content-Type: multipart/alternative; boundary=001a113729826d2d5a0534549d04

--001a113729826d2d5a0534549d04
Content-Type: text/plain; charset=UTF-8

thanks, just one more question, I would think that it would be more
efficient to have multiple sub-buffers writing to a file versus one
sub-buffer to one file,. Of course, when the file gets overwritten
(rolled-over by the tracefile-count option)  multiple sub-buffers are lost.
Do you have any use case recommendation?
John

On Sun, May 29, 2016 at 12:48 PM, Julien Desfossez <jdesfossez@efficios.com>
wrote:

> > Julien,
> > thanks, I was mislead by the 2.7 documentation saying:
> > "...parameters
> > of |enable-channel| are |--tracefile-size|and |--tracefile-count|, which
> > respectively limit the size of each trace file and the their count for a
> > given channel. "
> > In this case the tracefile-size option should be removed, will it become
> > useful in the future releases or has a more subtle use?
>
> No, the tracefile-size options does what it says, the limitation is that
> the smallest unit it can work with is the subbuf-size. So the smallest
> tracefile size you can have is the subbuf-size.
>
> If you are using 4k subbuffers and you limit the size of the tracefiles
> to 4M, then you will have at most 1000 full packets in each tracefile.
> But if you have subbuffers of 8M, the smallest tracefile size you can
> have is 8M.
>
> Julien
>

--001a113729826d2d5a0534549d04
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">thanks, just one more question, I would think that it woul=
d be more efficient to have multiple sub-buffers writing to a file versus o=
ne sub-buffer to one file,. Of course, when the file gets overwritten (roll=
ed-over by the=C2=A0<span style=3D"font-size:12.8px">tracefile-count option=
</span>) =C2=A0multiple sub-buffers are lost.<div>Do you have any use case =
recommendation?<div>John</div></div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Sun, May 29, 2016 at 12:48 PM, Julien Desfossez=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:jdesfossez@efficios.com" target=3D=
"_blank">jdesfossez@efficios.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">&gt; Julien,<br>
&gt; thanks, I was mislead by the 2.7 documentation saying:<br>
&gt; &quot;...parameters<br>
</span>&gt; of |enable-channel| are |--tracefile-size|and |--tracefile-coun=
t|, which<br>
<span class=3D"">&gt; respectively limit the size of each trace file and th=
e their count for a<br>
&gt; given channel. &quot;<br>
&gt; In this case the tracefile-size option should be removed, will it beco=
me<br>
&gt; useful in the future releases or has a more subtle use?<br>
<br>
</span>No, the tracefile-size options does what it says, the limitation is =
that<br>
the smallest unit it can work with is the subbuf-size. So the smallest<br>
tracefile size you can have is the subbuf-size.<br>
<br>
If you are using 4k subbuffers and you limit the size of the tracefiles<br>
to 4M, then you will have at most 1000 full packets in each tracefile.<br>
But if you have subbuffers of 8M, the smallest tracefile size you can<br>
have is 8M.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Julien<br>
</font></span></blockquote></div><br></div>

--001a113729826d2d5a0534549d04--

--===============8455377354401643476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8455377354401643476==--
