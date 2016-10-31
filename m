From: Jean Spector <jean.spector@gmail.com>
Subject: Re: Babeltrace python bindings documentation is no
	up-to-date
Date: Mon, 31 Oct 2016 23:20:42 +0200
Message-ID: <CABVQWN1LwXepZrbnCTzbRbtUN+Z+fYw=eGvueq-W4rcGu9K7AA__44000.2913623632$1477949815$gmane$org@mail.gmail.com>
References: <CABVQWN0JnR+K9BN11vYX051Q_ZspWHbVnUdUbREb+LgB1pMR8A@mail.gmail.com>
 <CAB4xu_0FBn00woj==OqKyiQ67cNNsKBNcKHKoevP8ki=oOFHTg@mail.gmail.com>
 <CABVQWN1USj+gH_horiYtB3V0q0nCOQ+NWdknA2AdVwdyMoGtHg@mail.gmail.com>
 <CAB4xu_1Q8QekRhmAEUNf7ML+9zRXOEj5Afiw-3EeuB_pmHC4kA@mail.gmail.com>
 <CABVQWN2z5v77Y=EDvW5MFWVhB46Wn7+QyfxH8mwUSSip7UwyqA@mail.gmail.com>
 <a9955420-8b89-fa48-7ee1-4d271af3bb41@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5756493199771229154=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com
 [IPv6:2a00:1450:400c:c09::22a])
 by lists.lttng.org (Postfix) with ESMTPS id CDBC61570A
 for <lttng-dev@lists.lttng.org>; Mon, 31 Oct 2016 21:21:36 +0000 (UTC)
Received: by mail-wm0-x22a.google.com with SMTP id n67so253187405wme.1
 for <lttng-dev@lists.lttng.org>; Mon, 31 Oct 2016 14:21:04 -0700 (PDT)
In-Reply-To: <a9955420-8b89-fa48-7ee1-4d271af3bb41@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============5756493199771229154==
Content-Type: multipart/alternative; boundary=001a114b4378fed29e05402fc859

--001a114b4378fed29e05402fc859
Content-Type: text/plain; charset=UTF-8

Hi Michael,

That's where I got python33 from eventually :-)
What I called out-of-the-box is actually EPEL.
I could just run "yum install python34" on my RHEL 7.2 (while the same
wouldn't work for python33), so for me it was the natural version to use.
Software Collections, though, required additional googling. Also, they
don't work out-of-the-box afterwards either, as you have to enable the scl
every time before using python33.




On Mon, Oct 31, 2016 at 10:54 PM, Michael Jeanson <mjeanson@efficios.com>
wrote:

> On 2016-10-31 16:44, Jean Spector wrote:
> > It's a matter of rpm dependencies.
> > Once installed, it might work fine with python 3.4 - but yum just
> > refuses to install it on RHEL 7.2
>
> RHEL 7 doesn't ship with python 3 out of the box, you'll need to get it
> from a software collection, have a look at :
>
>   https://www.softwarecollections.org/en/scls/rhscl/python33/
>
> Cheers,
>
> Michael
>
>

--001a114b4378fed29e05402fc859
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Michael,</div><div><br></div>That&#39;s where I go=
t python33 from eventually :-)<div>What I called out-of-the-box is actually=
 EPEL.</div><div>I could just run &quot;yum install python34&quot; on my RH=
EL 7.2 (while the same wouldn&#39;t work for python33), so for me it was th=
e natural version to use.</div><div>Software Collections, though, required =
additional googling. Also, they don&#39;t work out-of-the-box afterwards ei=
ther, as you have to enable the scl every time before using python33.</div>=
<div><br></div><div><br></div><div><br></div></div><div class=3D"gmail_extr=
a"><br><div class=3D"gmail_quote">On Mon, Oct 31, 2016 at 10:54 PM, Michael=
 Jeanson <span dir=3D"ltr">&lt;<a href=3D"mailto:mjeanson@efficios.com" tar=
get=3D"_blank">mjeanson@efficios.com</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><span class=3D"">On 2016-10-31 16:44, Jean Spector wrote:=
<br>
&gt; It&#39;s a matter of rpm dependencies.<br>
&gt; Once installed, it might work fine with python 3.4 - but yum just<br>
&gt; refuses to install it on RHEL 7.2<br>
<br>
</span>RHEL 7 doesn&#39;t ship with python 3 out of the box, you&#39;ll nee=
d to get it<br>
from a software collection, have a look at :<br>
<br>
=C2=A0 <a href=3D"https://www.softwarecollections.org/en/scls/rhscl/python3=
3/" rel=3D"noreferrer" target=3D"_blank">https://www.<wbr>softwarecollectio=
ns.org/en/<wbr>scls/rhscl/python33/</a><br>
<br>
Cheers,<br>
<br>
Michael<br>
<br>
</blockquote></div><br></div>

--001a114b4378fed29e05402fc859--

--===============5756493199771229154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5756493199771229154==--
