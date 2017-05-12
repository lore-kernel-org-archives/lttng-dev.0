From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: Re: Adding kernel events
Date: Fri, 12 May 2017 10:30:20 -0400
Message-ID: <CADcCL0iY_fEyOtD-SVu2v-nTN=17o2F2-r0xwXG37qRcVNPxhw__31484.9329567098$1494599456$gmane$org@mail.gmail.com>
References: <74bd0e1f-e98a-de97-3932-bf083fbc54bf@nelint.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6097640641196977506=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x22b.google.com (mail-io0-x22b.google.com
 [IPv6:2607:f8b0:4001:c06::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 3wPXT73mbjzk0v
 for <lttng-dev@lists.lttng.org>; Fri, 12 May 2017 14:30:51 +0000 (UTC)
Received: by mail-io0-x22b.google.com with SMTP id f102so41016730ioi.2
 for <lttng-dev@lists.lttng.org>; Fri, 12 May 2017 07:30:41 -0700 (PDT)
In-Reply-To: <74bd0e1f-e98a-de97-3932-bf083fbc54bf@nelint.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Eric Nelson <eric@nelint.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============6097640641196977506==
Content-Type: multipart/alternative; boundary="94eb2c070e4ebb986b054f548ccc"

--94eb2c070e4ebb986b054f548ccc
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

You have to define the LTTng probe in lttng-modules to hook on your custom
kernel tracepoint.
Have a look this commit where a new probe was added:
https://github.com/lttng/lttng-modules/commit/2ca394649a5fb4135bfbe541f090b06ef933a63b

Cheers!
Francis



2017-05-12 10:03 GMT-04:00 Eric Nelson <eric@nelint.com>:

> Hi all,
>
> Please pardon the N00b question, but I'm having trouble figuring out
> how to get lttng to process a new kernel event.
>
> I've added code to my kernel to track scheduler throttling on an RT Linux
> kernel, and can see my new events in /sys/kernel/debug/tracing/avai
> lable_events.
>
> Using "lttng list -k" doesn't show them though.
>
> Do I also need to add the event definitions to lttng-tools?
>
> Thanks in advance for any pointers.
>
>
> Eric Nelson
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- 
Francis Deslauriers
Software developer
EfficiOS inc.

--94eb2c070e4ebb986b054f548ccc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Eric,<div><br></div><div>You have to define the LTTng p=
robe in lttng-modules to hook on your custom kernel tracepoint.</div><div>H=
ave a look this commit where a new probe was added:</div><div><a href=3D"ht=
tps://github.com/lttng/lttng-modules/commit/2ca394649a5fb4135bfbe541f090b06=
ef933a63b">https://github.com/lttng/lttng-modules/commit/2ca394649a5fb4135b=
fbe541f090b06ef933a63b</a><br></div><div><br></div><div>Cheers!</div><div>F=
rancis</div><div><br></div><div><br></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">2017-05-12 10:03 GMT-04:00 Eric Nelson <span dir=
=3D"ltr">&lt;<a href=3D"mailto:eric@nelint.com" target=3D"_blank">eric@neli=
nt.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi all,<br>
<br>
Please pardon the N00b question, but I&#39;m having trouble figuring out<br=
>
how to get lttng to process a new kernel event.<br>
<br>
I&#39;ve added code to my kernel to track scheduler throttling on an RT Lin=
ux<br>
kernel, and can see my new events in /sys/kernel/debug/tracing/avai<wbr>lab=
le_events.<br>
<br>
Using &quot;lttng list -k&quot; doesn&#39;t show them though.<br>
<br>
Do I also need to add the event definitions to lttng-tools?<br>
<br>
Thanks in advance for any pointers.<span class=3D"HOEnZb"><font color=3D"#8=
88888"><br>
<br>
<br>
Eric Nelson<br>
______________________________<wbr>_________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bi<wbr>n/mail=
man/listinfo/lttng-dev</a><br>
</font></span></blockquote></div><br></div><br clear=3D"all"><div><br></div=
>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><=
div dir=3D"ltr"><div><div>Francis Deslauriers</div><div dir=3D"ltr">Softwar=
e developer<div>EfficiOS inc.</div></div></div></div></div></div>

--94eb2c070e4ebb986b054f548ccc--

--===============6097640641196977506==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6097640641196977506==--
