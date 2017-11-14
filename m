From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Is it safe to use multiple lfht instances?
Date: Tue, 14 Nov 2017 00:16:19 +0000 (UTC)
Message-ID: <1436564315.14333.1510618579591.JavaMail.zimbra__44442.2909211882$1510618546$gmane$org@efficios.com>
References: <CAML2tiS_JpMKH1fJ6EnJ_+OpzeGuEGibfNaDdqd_AoBN=hdK7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2876575465742597273=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3ybShW0x95z165y
 for <lttng-dev@lists.lttng.org>; Tue, 14 Nov 2017 00:15:38 +0000 (UTC)
In-Reply-To: <CAML2tiS_JpMKH1fJ6EnJ_+OpzeGuEGibfNaDdqd_AoBN=hdK7w@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yu Yang <yyangplus@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2876575465742597273==
Content-Type: multipart/alternative;
	boundary="=_2f2958a0-c3c8-49c9-9226-9ea20ef377e5"

--=_2f2958a0-c3c8-49c9-9226-9ea20ef377e5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Nov 13, 2017, at 5:44 AM, Yu Yang <yyangplus@gmail.com> wrote: 

> hello
> I want to implement a multi-tree using lfht in urcu, every node in the tree
> needs a lfht instance to track the children, I'm not sure if it is safe to use
> tree like this in multiple threads environments. thanks in advance.

Yes, the RCU lock-free hash table is multi-thread safe. 

It is also safe to have multiple RCU lfht instances within a given process. An example 
of a program doing that is lttng-tools session daemon. 

Best regards, 

Mathieu 

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_2f2958a0-c3c8-49c9-9226-9ea20ef377e5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><div><span id=3D"z=
wchr" data-marker=3D"__DIVIDER__">----- On Nov 13, 2017, at 5:44 AM, Yu Yan=
g &lt;yyangplus@gmail.com&gt; wrote:<br></span></div><div data-marker=3D"__=
QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><=
div dir=3D"ltr"><div>hello</div>I want to implement a multi-tree using lfht=
 in urcu, every node in the tree needs a lfht instance to track the childre=
n, I'm not sure if it is safe to use tree like this in multiple threads env=
ironments. thanks in advance.</div></blockquote><div>Yes, the RCU lock-free=
 hash table is multi-thread safe.<br></div><div><br data-mce-bogus=3D"1"></=
div><div>It is also safe to have multiple RCU lfht instances within a given=
 process. An example</div><div>of a program doing that is lttng-tools sessi=
on daemon.</div><div><br data-mce-bogus=3D"1"></div><div>Best regards,<br d=
ata-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<=
br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010=
FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt;"><br>_______________________________________________<br>lttng-dev=
 mailing list<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-b=
in/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div dat=
a-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS I=
nc.<br>http://www.efficios.com</div></div></body></html>
--=_2f2958a0-c3c8-49c9-9226-9ea20ef377e5--

--===============2876575465742597273==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============2876575465742597273==--
