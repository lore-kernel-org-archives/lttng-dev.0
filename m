From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: urcu: Where does HAS_INCOHERENT_CACHES come from?
Date: Fri, 16 Oct 2015 20:36:01 +0000 (UTC)
Message-ID: <1677274442.63472.1445027761873.JavaMail.zimbra__16169.1328896724$1445027835$gmane$org@efficios.com>
References: <CALcGr8weFzyHE3jdieQzWtXe9-G75c-JrqtWonhr3iHWPR_mzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0285634076=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZnBjd-0004zu-EG
 for lttng-dev@lists.lttng.org; Fri, 16 Oct 2015 16:36:20 -0400
In-Reply-To: <CALcGr8weFzyHE3jdieQzWtXe9-G75c-JrqtWonhr3iHWPR_mzw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ted Cooper <theod@pdx.edu>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0285634076==
Content-Type: multipart/alternative;
	boundary="----=_Part_63471_116726065.1445027761872"

------=_Part_63471_116726065.1445027761872
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Oct 16, 2015, at 6:17 AM, Ted Cooper <theod@pdx.edu> wrote: 

> This seems like a macro that is unique to the userspace-rcu codebase, but I
> can't anything that mentions it besides some #ifndefs.

In the early days of URCU, we planned to support architectures with incoherent caches 
like the Blackfin. We never ended up implementing support for that kind of architecture 
though. 

Thanks, 

Mathieu 

> Thanks,
> Ted

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_63471_116726065.1445027761872
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Oct 16, 2015, at 6:17 AM, Ted Cooper &lt;theod@pdx.edu&gt; wro=
te:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=
=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#0=
00;font-weight:normal;font-style:normal;text-decoration:none;font-family:He=
lvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">This seems like =
a macro that is unique to the userspace-rcu codebase, but I can't anything =
that mentions it besides some #ifndefs.</div></blockquote><div>In the early=
 days of URCU, we planned to support architectures with incoherent caches<b=
r></div><div>like the Blackfin. We never ended up implementing support for =
that kind of architecture</div><div>though.<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"=
></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left=
:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt;"><div dir=3D"ltr"><br><div>Thanks,</div><div>Ted<=
/div></div><br>_______________________________________________<br>lttng-dev=
 mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bi=
n/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div data=
-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS In=
c.<br>http://www.efficios.com</div></div></body></html>
------=_Part_63471_116726065.1445027761872--


--===============0285634076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0285634076==--
