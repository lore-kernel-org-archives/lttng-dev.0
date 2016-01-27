From: Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org>
Subject: Re: Bogus openembedded gcc patch
Date: Wed, 27 Jan 2016 11:59:38 +0000 (UTC)
Message-ID: <883932458.5623.1453895978760.JavaMail.zimbra@efficios.com>
References: <1037243108.4336.1453770172960.JavaMail.zimbra@efficios.com>
	<51287CFC-6F3C-43B1-9190-84F3B20C192E@gmail.com>
	<433937130.5072.1453838389504.JavaMail.zimbra@efficios.com>
	<CAMKF1sofnyADcNkAc+YrXjPED=ALxf60oPEsuQiJTAY87oB31Q@mail.gmail.com>
	<CAJTo0LZazTzkp94ASdACaBOuC4JpNWCpnf46kAucjY5B+wX2vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2042106396=="
Return-path: <openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
In-Reply-To: <CAJTo0LZazTzkp94ASdACaBOuC4JpNWCpnf46kAucjY5B+wX2vQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/openembedded-core/>
List-Post: <mailto:openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Help: <mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/openembedded-core>,
	<mailto:openembedded-core-request-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org?subject=subscribe>
Sender: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
Errors-To: openembedded-core-bounces-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
To: "Burton, Ross" <ross.burton-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: lttng-dev <lttng-dev-bnB2LGs2QVJ+nrgayQ7rhA@public.gmane.org>, openembedded-core <openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org>
List-Id: lttng-dev@lists.lttng.org

--===============2042106396==
Content-Type: multipart/alternative;
	boundary="----=_Part_5622_1195741865.1453895978758"

------=_Part_5622_1195741865.1453895978758
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jan 27, 2016, at 6:31 AM, Burton, Ross <ross.burton-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote: 

> On 26 January 2016 at 23:14, Khem Raj < raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org > wrote:

>> > Yes, we have narrowed down our problem to this specific patch by
>> > removing the patch from the OE gcc patches, rebuilding gcc, and
>> > then building our test program with that gcc. The problem goes
>> > away when we do so, which points directly to that patch as a
>> > culprit.

>> > Test program is attached.

>> Ok I think we can remove this from master and jethro release

> Mathieu, as you found this do you want the glory by submitting a the removal
> patch?

Thanks for asking, but for me a 

Reported-by: Mathieu Desnoyers <mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org> 

in the patch commit messge is good enough. 
You'll probably want to have a link to this discussion thread 
also in the commit message. 

Thanks, 

Mathieu 

> Cheerss,
> Ross

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_5622_1195741865.1453895978758
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Jan 27, 2016, at 6:31 AM, Burton, Ross &lt;ross.burton@intel.c=
om&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockqu=
ote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px=
;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-=
family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On 26 January 2016 at 23=
:14, Khem Raj <span dir=3D"ltr">&lt;<a href=3D"mailto:raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" t=
arget=3D"_blank">raj.khem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"><div id=3D":aj" class=3D"a3s" style=3D"overflow:hidden">&g=
t; Yes, we have narrowed down our problem to this specific patch by<br>
&gt; removing the patch from the OE gcc patches, rebuilding gcc, and<br>
&gt; then building our test program with that gcc. The problem goes<br>
&gt; away when we do so, which points directly to that patch as a<br>
&gt; culprit.<br>
&gt;<br>
&gt; Test program is attached.<p dir=3D"ltr">Ok I think we can remove this =
from master and jethro release<br></p></div></blockquote></div><br>Mathieu,=
 as you found this do you want the glory by submitting a the removal patch?=
</div></div></blockquote><div><br></div><div>Thanks for asking, but for me =
a<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Re=
ported-by: Mathieu Desnoyers &lt;mathieu.desnoyers-vg+e7yoeK/dWk0Htik3J/w@public.gmane.org&gt;<br data=
-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>in the patc=
h commit messge is good enough.<br data-mce-bogus=3D"1"></div><div>You'll p=
robably want to have a link to this discussion thread<br data-mce-bogus=3D"=
1"></div><div>also in the commit message.<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div=
><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"><=
/div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2=
px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:no=
rmal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,san=
s-serif;font-size:12pt;"><div dir=3D"ltr"><div class=3D"gmail_extra"><br></=
div><div class=3D"gmail_extra">Cheerss,</div><div class=3D"gmail_extra">Ros=
s</div></div><br></blockquote></div><div><br></div><div data-marker=3D"__SI=
G_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://ww=
w.efficios.com</div></div></body></html>
------=_Part_5622_1195741865.1453895978758--

--===============2042106396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
_______________________________________________
Openembedded-core mailing list
Openembedded-core-ZwoEplunGu3dfDuKDZ/zN51Ccm5ICvs9@public.gmane.org
http://lists.openembedded.org/mailman/listinfo/openembedded-core

--===============2042106396==--
