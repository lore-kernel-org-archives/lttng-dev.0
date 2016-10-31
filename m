From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Do updaters of a cds_lfht need to be synchronized?
Date: Mon, 31 Oct 2016 15:50:45 +0000 (UTC)
Message-ID: <1821874660.10064.1477929045393.JavaMail.zimbra__30793.5803932653$1477929055$gmane$org@efficios.com>
References: <MWHPR11MB17756EC0046E84C041DF022398AD0@MWHPR11MB1775.namprd11.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4072299348703081662=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 49725A17B7
 for <lttng-dev@lists.lttng.org>; Mon, 31 Oct 2016 15:50:51 +0000 (UTC)
In-Reply-To: <MWHPR11MB17756EC0046E84C041DF022398AD0@MWHPR11MB1775.namprd11.prod.outlook.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Charles Jacobsen <charles.jacobsen@primarydata.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============4072299348703081662==
Content-Type: multipart/alternative;
	boundary="=_cef910bb-c9fb-4239-8b2d-bff39bab616d"

--=_cef910bb-c9fb-4239-8b2d-bff39bab616d
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Oct 28, 2016, at 11:40 AM, Charles Jacobsen <charles.jacobsen@primarydata.com> wrote: 

> The documentation for the lock-free hash table does not mention anything about
> synchronizing updaters (e.g., with a lock):

> [ https://lwn.net/Articles/573431/ | https://lwn.net/Articles/573431/ ]

> [ https://lwn.net/Articles/573432/ | https://lwn.net/Articles/573432/ ]

> The source for rculfhash (== cds_lfht?) also mentions in the comments that add
> and remove are lock free:

> [ https://github.com/urcu/userspace-rcu/blob/master/src/rculfhash.c |
> https://github.com/urcu/userspace-rcu/blob/master/src/rculfhash.c ]

> Is it safe to assume that cds_lfht_add, cds_lfht_add_unique, and so on, *only*
> require a surrounding rcu read lock/unlock?

> "lock free" is part of the name, so I would assume the answer is "yes".

Yes, this assumption is correct. 

Thanks, 

Mathieu 

> Thank you.

> Disclaimer

> The information contained in this communication from the sender is confidential.
> It is intended solely for use by the recipient and others authorized to receive
> it. If you are not the recipient, you are hereby notified that any disclosure,
> copying, distribution or taking action in relation of the contents of this
> information is strictly prohibited and may be unlawful.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_cef910bb-c9fb-4239-8b2d-bff39bab616d
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><span id=3D"zwchr" data-mark=
er=3D"__DIVIDER__">----- On Oct 28, 2016, at 11:40 AM, Charles Jacobsen &lt=
;charles.jacobsen@primarydata.com&gt; wrote:<br></span></div><div data-mark=
er=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;m=
argin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:no=
rmal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:=
12pt;"><div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#0000=
00;font-family:Calibri,Arial,Helvetica,sans-serif;"><p>The documentation fo=
r the lock-free hash table does not mention anything about synchronizing up=
daters (e.g., with a lock):</p><p><br></p><p><a href=3D"https://lwn.net/Art=
icles/573431/" class=3D"OWAAutoLink" id=3D"LPlnk860374" target=3D"_blank">h=
ttps://lwn.net/Articles/573431/</a><br data-mce-bogus=3D"1"></p><p><a href=
=3D"https://lwn.net/Articles/573432/" class=3D"OWAAutoLink" id=3D"LPlnk4178=
50" target=3D"_blank">https://lwn.net/Articles/573432/</a><br></p><p><br></=
p><p>The source for rculfhash (=3D=3D cds_lfht?) also mentions in the comme=
nts that add and remove are lock free:<br></p><p><br></p><p><a href=3D"http=
s://github.com/urcu/userspace-rcu/blob/master/src/rculfhash.c" class=3D"OWA=
AutoLink" id=3D"LPlnk562362" target=3D"_blank">https://github.com/urcu/user=
space-rcu/blob/master/src/rculfhash.c</a><br></p><p><br></p><p>Is it safe t=
o assume that cds_lfht_add, cds_lfht_add_unique, and so on, *only* require =
a surrounding rcu read lock/unlock?</p><p><br></p><p>"lock free" is part of=
 the name, so I would assume the answer is "yes".</p></div></blockquote><di=
v>Yes, this assumption is correct.<br></div><div><br data-mce-bogus=3D"1"><=
/div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"=
1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"borde=
r-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt;"><div id=3D"divtagdefaultwrapper" style=3D"=
font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif=
;"><p><br></p><p><br></p><p>Thank you.<br></p></div><br><br><p style=3D"fon=
t-family: Verdana; font-size:10pt; color:#666666;"><b>Disclaimer</b></p><p =
style=3D"font-family: Verdana; font-size:8pt; color:#666666;">The informati=
on contained in this communication from the sender is confidential. It is i=
ntended solely for use by the recipient and others authorized to receive it=
. If you are not the recipient, you are hereby notified that any disclosure=
, copying, distribution or taking action in relation of the contents of thi=
s information is strictly prohibited and may be unlawful.<br></p><br>______=
_________________________________________<br>lttng-dev mailing list<br>lttn=
g-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/l=
ttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POS=
T__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.eff=
icios.com</div></div></body></html>
--=_cef910bb-c9fb-4239-8b2d-bff39bab616d--

--===============4072299348703081662==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============4072299348703081662==--
