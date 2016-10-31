From: Charles Jacobsen <charles.jacobsen@primarydata.com>
Subject: Re: Do updaters of a cds_lfht need to be synchronized?
Date: Mon, 31 Oct 2016 16:01:17 +0000
Message-ID: <MWHPR11MB1775BD81A5886CA4CC1F8BA598AE0__40892.6229495139$1477930068$gmane$org@MWHPR11MB1775.namprd11.prod.outlook.com>
References: <MWHPR11MB17756EC0046E84C041DF022398AD0@MWHPR11MB1775.namprd11.prod.outlook.com>,
 <1821874660.10064.1477929045393.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4947915086272390368=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from us-smtp-delivery-194.mimecast.com
 (us-smtp-delivery-194.mimecast.com [63.128.21.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id A51A9A17B7
 for <lttng-dev@lists.lttng.org>; Mon, 31 Oct 2016 16:01:49 +0000 (UTC)
In-Reply-To: <1821874660.10064.1477929045393.JavaMail.zimbra@efficios.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Trond Myklebust <trondmy@primarydata.com>, Weston Andros Adamson <dros@primarydata.com>, Thomas Haynes <loghyr@primarydata.com>, Evan Orme <eorme@primarydata.com>, Richard Sharpe <richard.sharpe@primarydata.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4947915086272390368==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR11MB1775BD81A5886CA4CC1F8BA598AE0MWHPR11MB1775namp_"

--_000_MWHPR11MB1775BD81A5886CA4CC1F8BA598AE0MWHPR11MB1775namp_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

fyi, see below.


I hope I posed the question correctly.


________________________________
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Sent: Monday, October 31, 2016 9:50 AM
To: Charles Jacobsen
Cc: lttng-dev
Subject: Re: [lttng-dev] Do updaters of a cds_lfht need to be synchronized?


----- On Oct 28, 2016, at 11:40 AM, Charles Jacobsen <charles.jacobsen@prim=
arydata.com> wrote:

The documentation for the lock-free hash table does not mention anything ab=
out synchronizing updaters (e.g., with a lock):


https://lwn.net/Articles/573431/

https://lwn.net/Articles/573432/


The source for rculfhash (=3D=3D cds_lfht?) also mentions in the comments t=
hat add and remove are lock free:


https://github.com/urcu/userspace-rcu/blob/master/src/rculfhash.c


Is it safe to assume that cds_lfht_add, cds_lfht_add_unique, and so on, *on=
ly* require a surrounding rcu read lock/unlock?


"lock free" is part of the name, so I would assume the answer is "yes".

Yes, this assumption is correct.

Thanks,

Mathieu





Thank you.



Disclaimer

The information contained in this communication from the sender is confiden=
tial. It is intended solely for use by the recipient and others authorized =
to receive it. If you are not the recipient, you are hereby notified that a=
ny disclosure, copying, distribution or taking action in relation of the co=
ntents of this information is strictly prohibited and may be unlawful.

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

Disclaimer

The information contained in this communication from the sender is confiden=
tial. It is intended solely for use by the recipient and others authorized =
to receive it. If you are not the recipient, you are hereby notified that a=
ny disclosure, copying, distribution or taking action in relation of the co=
ntents of this information is strictly prohibited and may be unlawful.

--_000_MWHPR11MB1775BD81A5886CA4CC1F8BA598AE0MWHPR11MB1775namp_
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<style type=3D"text/css">.style1 {font-family: "Times New Roman";}</style><=
/head><body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>fyi, see below.</p>
<p><br>
</p>
<p>I hope I posed the question correctly.<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Mathieu Desnoyers &=
lt;mathieu.desnoyers@efficios.com&gt;<br>
<b>Sent:</b> Monday, October 31, 2016 9:50 AM<br>
<b>To:</b> Charles Jacobsen<br>
<b>Cc:</b> lttng-dev<br>
<b>Subject:</b> Re: [lttng-dev] Do updaters of a cds_lfht need to be synchr=
onized?</font>
<div>&nbsp;</div>
</div>
<div>
<div style=3D"font-family:arial,helvetica,sans-serif; font-size:12pt; color=
:#000000">
<div><br>
</div>
<div><span id=3D"zwchr">----- On Oct 28, 2016, at 11:40 AM, Charles Jacobse=
n &lt;charles.jacobsen@primarydata.com&gt; wrote:<br>
</span></div>
<div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; fo=
nt-family:Calibri,Arial,Helvetica,sans-serif">
<p>The documentation for the lock-free hash table does not mention anything=
 about synchronizing updaters (e.g., with a lock):</p>
<p><br>
</p>
<p><a href=3D"https://lwn.net/Articles/573431/" class=3D"OWAAutoLink" id=3D=
"LPlnk860374" target=3D"_blank" previewremoved=3D"true">https://lwn.net/Art=
icles/573431/</a><br>
</p>
<p><a href=3D"https://lwn.net/Articles/573432/" class=3D"OWAAutoLink" id=3D=
"LPlnk417850" target=3D"_blank" previewremoved=3D"true">https://lwn.net/Art=
icles/573432/</a><br>
</p>
<p><br>
</p>
<p>The source for rculfhash (=3D=3D cds_lfht?) also mentions in the comment=
s that add and remove are lock free:<br>
</p>
<p><br>
</p>
<p><a href=3D"https://github.com/urcu/userspace-rcu/blob/master/src/rculfha=
sh.c" class=3D"OWAAutoLink" id=3D"LPlnk562362" target=3D"_blank" previewrem=
oved=3D"true">https://github.com/urcu/userspace-rcu/blob/master/src/rculfha=
sh.c</a><br>
</p>
<p><br>
</p>
<p>Is it safe to assume that cds_lfht_add, cds_lfht_add_unique, and so on, =
*only* require a surrounding rcu read lock/unlock?</p>
<p><br>
</p>
<p>&quot;lock free&quot; is part of the name, so I would assume the answer =
is &quot;yes&quot;.</p>
</div>
</blockquote>
<div>Yes, this assumption is correct.<br>
</div>
<div><br>
</div>
<div>Thanks,<br>
</div>
<div><br>
</div>
<div>Mathieu<br>
</div>
<div><br>
</div>
<div><br>
</div>
<blockquote style=3D"border-left:2px solid #1010FF; margin-left:5px; paddin=
g-left:5px; color:#000; font-weight:normal; font-style:normal; text-decorat=
ion:none; font-family:Helvetica,Arial,sans-serif; font-size:12pt">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; fo=
nt-family:Calibri,Arial,Helvetica,sans-serif">
<p><br>
</p>
<p><br>
</p>
<p>Thank you.<br>
</p>
</div>
<br>
<br>
<p style=3D"font-family:Verdana; font-size:10pt; color:#666666"><b>Disclaim=
er</b></p>
<p style=3D"font-family:Verdana; font-size:8pt; color:#666666">The informat=
ion contained in this communication from the sender is confidential. It is =
intended solely for use by the recipient and others authorized to receive i=
t. If you are not the recipient, you
 are hereby notified that any disclosure, copying, distribution or taking a=
ction in relation of the contents of this information is strictly prohibite=
d and may be unlawful.<br>
</p>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>
</blockquote>
</div>
<div><br>
</div>
<div>-- <br>
</div>
<div>Mathieu Desnoyers<br>
EfficiOS Inc.<br>
http://www.efficios.com</div>
</div>
</div>
</div>
</div>

<br /><br /><p style=3D"font-family: Verdana; font-size:10pt; color:#666666=
;"><b>Disclaimer</b></p><p style=3D"font-family: Verdana; font-size:8pt; co=
lor:#666666;">The information contained in this communication from the send=
er is confidential. It is intended solely for use by the recipient and othe=
rs authorized to receive it. If you are not the recipient, you are hereby n=
otified that any disclosure, copying, distribution or taking action in rela=
tion of the contents of this information is strictly prohibited and may be =
unlawful.<br /></p></body></html>

--_000_MWHPR11MB1775BD81A5886CA4CC1F8BA598AE0MWHPR11MB1775namp_--


--===============4947915086272390368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4947915086272390368==--
