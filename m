From: Charles Jacobsen <charles.jacobsen@primarydata.com>
Subject: Do updaters of a cds_lfht need to be synchronized?
Date: Fri, 28 Oct 2016 15:40:28 +0000
Message-ID: <MWHPR11MB17756EC0046E84C041DF022398AD0__38103.2303128906$1477926674$gmane$org@MWHPR11MB1775.namprd11.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3133972688505254687=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from us-smtp-delivery-194.mimecast.com
 (us-smtp-delivery-194.mimecast.com [63.128.21.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTP id C63E1A0DFF
 for <lttng-dev@lists.lttng.org>; Fri, 28 Oct 2016 15:47:22 +0000 (UTC)
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
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============3133972688505254687==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR11MB17756EC0046E84C041DF022398AD0MWHPR11MB1775namp_"

--_000_MWHPR11MB17756EC0046E84C041DF022398AD0MWHPR11MB1775namp_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The documentation for the lock-free hash table does not mention anything ab=
out synchronizing updaters (e.g., with a lock):


https://lwn.net/Articles/573431/

<https://lwn.net/Articles/573431/>https://lwn.net/Articles/573432/


The source for rculfhash (=3D=3D cds_lfht?) also mentions in the comments t=
hat add and remove are lock free:


https://github.com/urcu/userspace-rcu/blob/master/src/rculfhash.c


Is it safe to assume that cds_lfht_add, cds_lfht_add_unique, and so on, *on=
ly* require a surrounding rcu read lock/unlock?


"lock free" is part of the name, so I would assume the answer is "yes".


Thank you.

Disclaimer

The information contained in this communication from the sender is confiden=
tial. It is intended solely for use by the recipient and others authorized =
to receive it. If you are not the recipient, you are hereby notified that a=
ny disclosure, copying, distribution or taking action in relation of the co=
ntents of this information is strictly prohibited and may be unlawful.

--_000_MWHPR11MB17756EC0046E84C041DF022398AD0MWHPR11MB1775namp_
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
<p>The documentation for the lock-free hash table does not mention anything=
 about synchronizing updaters (e.g., with a lock):</p>
<p><br>
</p>
<p><a href=3D"https://lwn.net/Articles/573431/" class=3D"OWAAutoLink" id=3D=
"LPlnk860374" previewremoved=3D"true">https://lwn.net/Articles/573431/</a><=
/p>
<p><a href=3D"https://lwn.net/Articles/573431/" class=3D"OWAAutoLink" id=3D=
"LPlnk860374" previewremoved=3D"true"></a><a href=3D"https://lwn.net/Articl=
es/573432/" class=3D"OWAAutoLink" id=3D"LPlnk417850" previewremoved=3D"true=
">https://lwn.net/Articles/573432/</a><br>
</p>
<p><br>
</p>
<p>The source for rculfhash (=3D=3D cds_lfht?) also mentions in the comment=
s that add and remove are lock free:<br>
</p>
<p><br>
</p>
<p><a href=3D"https://github.com/urcu/userspace-rcu/blob/master/src/rculfha=
sh.c" class=3D"OWAAutoLink" id=3D"LPlnk562362" previewremoved=3D"true">http=
s://github.com/urcu/userspace-rcu/blob/master/src/rculfhash.c</a><br>
</p>
<p><br>
</p>
<p>Is it safe to assume that cds_lfht_add, cds_lfht_add_unique, and so on, =
*only* require a surrounding rcu read lock/unlock?</p>
<p><br>
</p>
<p>&quot;lock free&quot; is part of the name, so I would assume the answer =
is &quot;yes&quot;.<br>
</p>
<p><br>
</p>
<p>Thank you.<br>
</p>
</div>

<br /><br /><p style=3D"font-family: Verdana; font-size:10pt; color:#666666=
;"><b>Disclaimer</b></p><p style=3D"font-family: Verdana; font-size:8pt; co=
lor:#666666;">The information contained in this communication from the send=
er is confidential. It is intended solely for use by the recipient and othe=
rs authorized to receive it. If you are not the recipient, you are hereby n=
otified that any disclosure, copying, distribution or taking action in rela=
tion of the contents of this information is strictly prohibited and may be =
unlawful.<br /></p></body></html>

--_000_MWHPR11MB17756EC0046E84C041DF022398AD0MWHPR11MB1775namp_--


--===============3133972688505254687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3133972688505254687==--
