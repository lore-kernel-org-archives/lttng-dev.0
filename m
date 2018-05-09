From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng-tools 2.10.4 broken when auto loading session
Date: Wed, 9 May 2018 17:53:31 -0400
Message-ID: <CA+jJMxuNJu7L+haTuoNBrXT8rzH2F7qY9Y9pwpjPhewVkW7JAw__49693.8303731897$1525902718$gmane$org@mail.gmail.com>
References: <CAF2baFdqgzUQyfDn6gi8-+SvDYy058EzMkG8k3a5gnA1Df7tnw@mail.gmail.com>
 <20180503153252.GA2332@joraj-alpa>
 <CAF2baFdYyXhXwLvjY89SPu_rPigOZB2dyaQfO_QVH5TRA8PsMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6127605766299087621=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 40h99H5slWz17cb
 for <lttng-dev@lists.lttng.org>; Wed,  9 May 2018 17:53:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id DA1381BD1AE
 for <lttng-dev@lists.lttng.org>; Wed,  9 May 2018 17:53:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ZKEgL1TBBSPc for <lttng-dev@lists.lttng.org>;
 Wed,  9 May 2018 17:53:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 319F31BD198
 for <lttng-dev@lists.lttng.org>; Wed,  9 May 2018 17:53:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail02.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id BAVB5Q6RoR1X for <lttng-dev@lists.lttng.org>;
 Wed,  9 May 2018 17:53:54 -0400 (EDT)
Received: from mail-lf0-f41.google.com (mail-lf0-f41.google.com
 [209.85.215.41])
 by mail.efficios.com (Postfix) with ESMTPSA id C973D1BD17D
 for <lttng-dev@lists.lttng.org>; Wed,  9 May 2018 17:53:53 -0400 (EDT)
Received: by mail-lf0-f41.google.com with SMTP id h197-v6so46121lfg.11
 for <lttng-dev@lists.lttng.org>; Wed, 09 May 2018 14:53:53 -0700 (PDT)
In-Reply-To: <CAF2baFdYyXhXwLvjY89SPu_rPigOZB2dyaQfO_QVH5TRA8PsMw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Anders Wallin <wallinux@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6127605766299087621==
Content-Type: multipart/alternative; boundary="00000000000046ed7e056bccf0a2"

--00000000000046ed7e056bccf0a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anders,

Can you try with the latest stable-2.10?

Thanks,
J=C3=A9r=C3=A9mie

On 3 May 2018 at 13:57, Anders Wallin <wallinux@gmail.com> wrote:

> File appended
>
> Regards
> Anders
>
>
> tors 3 maj 2018 kl 17:33 skrev Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com>:
>
>> On Thu, May 03, 2018 at 12:27:48PM +0000, Anders Wallin wrote:
>> > Hi,
>> >
>> > lttng-tools hangs when a session is stored /etc/lttng/session/auto/
>> >
>> > $ head -10 /etc/lttng/sessions/auto/test.lttng
>> > <?xml version=3D"1.0" encoding=3D"UTF-8"?>
>> > <sessions>
>> >         <session>
>> >                 <name>test</name>
>> >                 <domains>
>> >                         <domain>
>> >                                 <type>UST</type>
>> >                                 <buffer_type>PER_UID</buffer_type>
>> >                                 <channels>
>> >                                         <channel>
>>
>> Could you give us the complete xml?
>>
>> Cheers
>>
>> > $ lttng-sessiond -d  # Hanging forever
>> >
>> > I will continue investigate why, but I though you wanna know ASAP
>> >
>> > Regards
>> > Anders Wallin
>>
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>> --
>> Jonathan Rajotte-Julien
>> EfficiOS
>>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>


--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--00000000000046ed7e056bccf0a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Anders,<br><br></div>Can you try with th=
e latest stable-2.10?<br><br></div>Thanks,<br></div>J=C3=A9r=C3=A9mie<br></=
div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 3 May 2018=
 at 13:57, Anders Wallin <span dir=3D"ltr">&lt;<a href=3D"mailto:wallinux@g=
mail.com" target=3D"_blank">wallinux@gmail.com</a>&gt;</span> wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div dir=3D"ltr">File appended<div><br></div><d=
iv>Regards</div><div><span class=3D"HOEnZb"><font color=3D"#888888">Anders<=
/font></span><div><div class=3D"h5"><br><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr">tors 3 maj 2018 kl 17:33 skrev Jonathan Rajotte-Julien &lt;<a =
href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">jona=
than.rajotte-julien@<wbr>efficios.com</a>&gt;:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On Thu, May 03, 2018 at 12:27:48PM +0000, Anders Wallin wrote=
:<br>
&gt; Hi,<br>
&gt; <br>
&gt; lttng-tools hangs when a session is stored /etc/lttng/session/auto/<br=
>
&gt; <br>
&gt; $ head -10 /etc/lttng/sessions/auto/test.<wbr>lttng<br>
&gt; &lt;?xml version=3D&quot;1.0&quot; encoding=3D&quot;UTF-8&quot;?&gt;<b=
r>
&gt; &lt;sessions&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;session&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;name&=
gt;test&lt;/name&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;domai=
ns&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&lt;domain&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;type&gt;UST&lt;/type&gt=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;buffer_type&gt;PER_UID&=
lt;/buffer_<wbr>type&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;channels&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&lt;channel&gt;<br>
<br>
Could you give us the complete xml?<br>
<br>
Cheers<br>
<br>
&gt; $ lttng-sessiond -d=C2=A0 # Hanging forever<br>
&gt; <br>
&gt; I will continue investigate why, but I though you wanna know ASAP<br>
&gt; <br>
&gt; Regards<br>
&gt; Anders Wallin<br>
<br>
&gt; ______________________________<wbr>_________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/=
mailman/listinfo/lttng-dev</a><br>
<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div></div></div></div></div>
<br>______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-<wbr>bin/mail=
man/listinfo/lttng-dev</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail=
_signature" data-smartmail=3D"gmail_signature">J=C3=A9r=C3=A9mie Galarneau<=
br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">h=
ttp://www.efficios.com</a></div>
</div>

--00000000000046ed7e056bccf0a2--

--===============6127605766299087621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6127605766299087621==--
