From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-ust deadlock.
Date: Thu, 23 Jun 2016 12:18:50 +0000 (UTC)
Message-ID: <1742525993.46330.1466684330147.JavaMail.zimbra__3471.53133848241$1466684356$gmane$org@efficios.com>
References: <CACd+_b4LSkLDT97SKLYJ=B59O6oaeJsgTYriAzazjKnOU-ymWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4870429095089061728=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 59E62A36AB
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jun 2016 12:18:56 +0000 (UTC)
In-Reply-To: <CACd+_b4LSkLDT97SKLYJ=B59O6oaeJsgTYriAzazjKnOU-ymWg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Aravind HT <aravind.ht@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4870429095089061728==
Content-Type: multipart/alternative;
	boundary="----=_Part_46329_334074917.1466684330146"

------=_Part_46329_334074917.1466684330146
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

LTTng-UST 2.6 is end of life. Please upgrade to a new version. 

Thanks, 

Mathieu 

----- On Jun 23, 2016, at 2:03 AM, Aravind HT <aravind.ht@gmail.com> wrote: 

> Hi,
> I am facing a deadlock in lttng-ust. Though my version is 2.6 I can see that
> this is applicable to the the latest UST version also.

> Deadlocks happening due to these two flows
> 1. lttng_fix_pending_events () -> ustcomm_register_event () -> calloc() ->
> __GI___dl_iterate_phdr()
> Note that Im not using the libc wrapper, but using a proprietary version for
> malloc() family which can call __GI___dl_iterate_phdr() .
> This flow takes up UST_LOCK() before calling __GI___dl_iterate_phdr(), and
> __GI___dl_iterate_phdr() has its own mutex( lets say DL_MUTEX).
> 2. lttng_ust_baddr_statedump() calls __GI___dl_iterate_phdr() which first takes
> up DL_MUTEX and then takes the UST_LOCK() in the call back function as
> extract_soinfo_events()->trace_baddr()->UST_LOCK() .

> Since the order is reversed, it can lead to deadlock. To fix this, do you think
> taking UST_LOCK in lttng_ust_baddr_statedump() ( surrounding
> __GI___dl_iterate_phdr() call ) instead of the call back function is proper ?

> In the latest version of UST, I see some changes/refactoring and that the
> UST_LOCK has been removed from trace_baddr() and moved one call up, but still
> is being called in the call back function after __GI___dl_iterate_phdr() is
> called.

> Regards,
> Aravind.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_46329_334074917.1466684330146
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,<br></div><div><br data-mce-bogus=3D"1">=
</div><div>LTTng-UST 2.6 is end of life. Please upgrade to a new version.<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thank=
s,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>M=
athieu<br data-mce-bogus=3D"1"></div><div><br></div><span id=3D"zwchr" data=
-marker=3D"__DIVIDER__">----- On Jun 23, 2016, at 2:03 AM, Aravind HT &lt;a=
ravind.ht@gmail.com&gt; wrote:<br></span><div data-marker=3D"__QUOTED_TEXT_=
_"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;paddi=
ng-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration=
:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"l=
tr">Hi,<br><div>I am facing a deadlock in lttng-ust. Though my version is 2=
.6 I can see that this is applicable to the the latest UST version also.</d=
iv><br><div>Deadlocks happening due to these two flows</div><div>1.&nbsp;<s=
pan style=3D"font-size:10.5pt;font-family:Calibri,sans-serif;color:black">l=
ttng_fix_pending_events () -&gt;<b>&nbsp;</b></span><span style=3D"color:bl=
ack;font-family:Calibri,sans-serif;font-size:10.5pt">ustcomm_register_event=
 () -&gt; calloc() -&gt;&nbsp;</span><span style=3D"color:black;font-family=
:Calibri,sans-serif;font-size:10.5pt">__GI___dl_iterate_phdr()</span></div>=
<div><span style=3D"color:black;font-family:Calibri,sans-serif;font-size:10=
.5pt">&nbsp; &nbsp; &nbsp;Note that Im not using the libc wrapper, but usin=
g a proprietary version for malloc() family which can call&nbsp;</span><spa=
n style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:14px">=
__GI___dl_iterate_phdr()</span><span style=3D"color:black;font-family:Calib=
ri,sans-serif;font-size:10.5pt">&nbsp;.</span></div><div><span style=3D"col=
or:black;font-family:Calibri,sans-serif;font-size:10.5pt">&nbsp; &nbsp; &nb=
sp;This flow takes up UST_LOCK() before calling&nbsp;</span><span style=3D"=
color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:14px">__GI___dl_i=
terate_phdr(), and&nbsp;</span><span style=3D"color:rgb(0,0,0);font-family:=
Calibri,sans-serif;font-size:14px">__GI___dl_iterate_phdr() has its own mut=
ex( lets say DL_MUTEX).</span></div><div><span style=3D"color: #000000; fon=
t-family: Calibri,sans-serif;" data-mce-style=3D"color: #000000; font-famil=
y: Calibri,sans-serif;" color=3D"#000000" face=3D"Calibri, sans-serif"><spa=
n style=3D"font-size:14px">2.&nbsp;lttng_ust_baddr_statedump() calls&nbsp;<=
/span></span><span style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif=
;font-size:14px">&nbsp;</span><span style=3D"color:rgb(0,0,0);font-family:C=
alibri,sans-serif;font-size:14px">__GI___dl_iterate_phdr() which first take=
s up DL_MUTEX and then takes the UST_LOCK() in the call back function as&nb=
sp;</span><span style=3D"color: #000000; font-family: Calibri,sans-serif;" =
data-mce-style=3D"color: #000000; font-family: Calibri,sans-serif;" color=
=3D"#000000" face=3D"Calibri, sans-serif"><span style=3D"font-size:14px">ex=
tract_soinfo_events()-&gt;trace_baddr()-&gt;UST_LOCK()</span></span><span s=
tyle=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:14px">.</=
span></div><div><span style=3D"color:rgb(0,0,0);font-family:Calibri,sans-se=
rif;font-size:14px"><br></span></div><div><span style=3D"color:rgb(0,0,0);f=
ont-family:Calibri,sans-serif;font-size:14px">Since the order is reversed, =
it can lead to deadlock. To fix this, do you think taking UST_LOCK in&nbsp;=
</span><span style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-=
size:14px">&nbsp;lttng_ust_baddr_statedump() ( surrounding&nbsp;</span><spa=
n style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:14px">=
__GI___dl_iterate_phdr() call ) instead of the call back function is proper=
 ?</span></div><div><span style=3D"color:rgb(0,0,0);font-family:Calibri,san=
s-serif;font-size:14px"><br></span></div><div><span style=3D"color:rgb(0,0,=
0);font-family:Calibri,sans-serif;font-size:14px">In the latest version of =
UST, I see some changes/refactoring and that the UST_LOCK has been removed =
from trace_baddr() and moved one call up, but still is being called in the =
call back function after&nbsp;</span><span style=3D"color:rgb(0,0,0);font-f=
amily:Calibri,sans-serif;font-size:14px">__GI___dl_iterate_phdr() is called=
.</span></div><div><span style=3D"color:rgb(0,0,0);font-family:Calibri,sans=
-serif;font-size:14px"><br></span></div><div><span style=3D"color:rgb(0,0,0=
);font-family:Calibri,sans-serif;font-size:14px"><br></span></div><div><spa=
n style=3D"color:rgb(0,0,0);font-family:Calibri,sans-serif;font-size:14px">=
Regards,</span></div><div><span style=3D"color:rgb(0,0,0);font-family:Calib=
ri,sans-serif;font-size:14px">Aravind.</span></div></div>
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><br><div data-marker=3D"__SIG_POST=
__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.effi=
cios.com</div></div></body></html>
------=_Part_46329_334074917.1466684330146--

--===============4870429095089061728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4870429095089061728==--
