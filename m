From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Shared memory support?
Date: Tue, 22 Sep 2015 17:54:50 +0000 (UTC)
Message-ID: <1102123337.200.1442944490176.JavaMail.zimbra__45606.6912193366$1442944587$gmane$org@efficios.com>
References: <D2262439.5A98%glelliott@teslamotors.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1981526824=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZeRmU-000160-8s
 for lttng-dev@lists.lttng.org; Tue, 22 Sep 2015 13:55:15 -0400
In-Reply-To: <D2262439.5A98%glelliott@teslamotors.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Glenn Elliott <glelliott@teslamotors.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1981526824==
Content-Type: multipart/alternative;
	boundary="----=_Part_199_742789346.1442944490175"

------=_Part_199_742789346.1442944490175
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Sep 22, 2015, at 12:16 AM, Glenn Elliott <glelliott@teslamotors.com> wrote: 

> Hello urcu devs,

> I am interested in using urcu for a project where interprocess communication
> occurs through shared memory. Can I use urcu to synchronize access access to
> data structures stored in shared memory? Has the situation changed since this
> question was asked several years ago (
> http://lists.lttng.org/pipermail/lttng-dev/2013-September/021415.html )? If
> shared memory is now supported, would there be issues if readers map the shared
> memory regions that contain shared data structures as read-only?

Hi Glenn, 

Currently, none of the urcu flavors support shared-memory between 
processes. 

Even though there appears to be interest for this feature, it has not 
materialized in any funding to support this implementation effort. Let 
us know if this is something you would be interested to sponsor. 

Thanks for your interest in urcu! 

Mathieu 

> Thanks,
> Glenn

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_199_742789346.1442944490175
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Sep 22, 2015, at 12:16 AM, Glenn Elliott &lt;glelliott@teslamo=
tors.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><b=
lockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-le=
ft:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none=
;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div>Hello urcu de=
vs,</div><div><br></div><div>I am interested in using urcu for a project wh=
ere interprocess communication occurs through shared memory. &nbsp;Can I us=
e urcu to synchronize access access to data structures stored in shared mem=
ory? &nbsp;Has the situation changed since this question was asked
 several years ago (<a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2=
013-September/021415.html" target=3D"_blank">http://lists.lttng.org/piperma=
il/lttng-dev/2013-September/021415.html</a>)? &nbsp;If shared memory is now=
 supported, would there be issues if readers map the shared
 memory regions that contain shared data structures as read-only?</div></bl=
ockquote><div><br></div><div>Hi Glenn,<br data-mce-bogus=3D"1"></div><br da=
ta-mce-bogus=3D"1"><div>Currently, none of the urcu flavors support shared-=
memory between</div><div>processes.<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><div>Even though there appears to be interest fo=
r this feature, it has not<br data-mce-bogus=3D"1"></div><div>materialized =
in any funding to support this implementation effort. Let<br></div><div>us =
know if this is something you would be interested to sponsor.<br data-mce-b=
ogus=3D"1"></div><div><div><br></div><div>Thanks for your interest in urcu!=
</div><div><br></div><div>Mathieu<br data-mce-bogus=3D"1"></div></div><div>=
<br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #=
1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-=
style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fo=
nt-size:12pt;"><div><br></div><div>Thanks,</div><div>Glenn</div><br><br>___=
____________________________________________<br>lttng-dev mailing list<br>l=
ttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo=
/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__SIG_P=
OST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.e=
fficios.com</div></div></body></html>
------=_Part_199_742789346.1442944490175--


--===============1981526824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1981526824==--
