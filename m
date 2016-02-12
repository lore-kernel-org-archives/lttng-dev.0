From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Crash on first run of target using
 liblttng-ust-cyg-profile.so, but subsequent runs succeed
Date: Fri, 12 Feb 2016 17:02:29 +0000 (UTC)
Message-ID: <1762935886.18108.1455296549954.JavaMail.zimbra__48364.8315108896$1455296621$gmane$org@efficios.com>
References: <CAL90rL8u1_3ifDL2QzrqrQMp3+68PhOsMfgdsYhceoLX__MAJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1344978351=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aUH7B-0002Bh-3U
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 12:02:43 -0500
In-Reply-To: <CAL90rL8u1_3ifDL2QzrqrQMp3+68PhOsMfgdsYhceoLX__MAJw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sean Heelan <seanheelan@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1344978351==
Content-Type: multipart/alternative;
	boundary="----=_Part_18107_1793406252.1455296549953"

------=_Part_18107_1793406252.1455296549953
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

---- On Feb 11, 2016, at 9:01 AM, Sean Heelan <seanheelan@gmail.com> wrote: 

> Hi all,
> I am running a target within a Docker instance, and tracing function execution
> using the latest LTTng release (2.7). The commands I am issuing look as
> follows:

> ----
> lttng create cc_session -o bla
> lttng enable-event --userspace lttng_ust_cyg_profile:func_entry
> lttng start

> LD_PRELOAD=liblttng-ust-cyg-profile.so target

> lttng stop
> lttng destroy
> ----

> When the target is executed it aborts with the following error:

> ----
> php: lttng-ust-comm.c:1582: lttng_ust_init: Assertion `!ret' failed.
> ----

> If I rerun the command it then works fine. In fact, simply doing the following
> within the Docker container demonstrates the issue:

> ----
> LD_PRELOAD=liblttng-ust-cyg-profile.so ls
> LD_PRELOAD=liblttng-ust-cyg-profile.so ls
> ----

> The first 'ls' will fail at the same point mentioned above, while the second
> will succeed. Off the top of my head I'm struggling to come up with an
> explanation as to what impact the first execution using LD_PRELOAD would have
> on the second. Does it impact a shared lib cache in some way, which I'm unaware
> of?

> Any assistance would be appreciated!

It appears that sem_timedwait() returns an unexpected error. 

Can you add a ERROR("sem_timedwait"); just before the assert at line 1582 in your liblttng-ust/lttng-ust-comm.c 
and show us the output ? 

Also, what is the value of your LTTNG_UST_REGISTER_TIMEOUT env. var. ? 

Thanks, 

Mathieu 

> Sean

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_18107_1793406252.1455296549953
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">---- On Feb 11, 2016, at 9:01 AM, Sean Heelan &lt;seanheelan@gmail.com&=
gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote=
 style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;co=
lor:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fam=
ily:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi all,<br=
><div>I am running a target within a Docker instance, and tracing function =
execution using the latest LTTng release (2.7). The commands I am issuing l=
ook as follows:</div><br><div>----<br></div><div><div>lttng create cc_sessi=
on -o bla</div><div>lttng enable-event --userspace lttng_ust_cyg_profile:fu=
nc_entry</div><div>lttng start</div><br><div>LD_PRELOAD=3Dliblttng-ust-cyg-=
profile.so target</div><br><div>lttng stop</div><div>lttng destroy</div><di=
v>----</div></div><br><div>When the target is executed it aborts with the f=
ollowing error:</div><br><div>----</div><div>php: lttng-ust-comm.c:1582: lt=
tng_ust_init: Assertion `!ret' failed.<br></div><div>----</div><br><div>If =
I rerun the command it then works fine. In fact, simply doing the following=
 within the Docker container demonstrates the issue:</div><br><div>----</di=
v><div><div>LD_PRELOAD=3Dliblttng-ust-cyg-profile.so ls</div><div>LD_PRELOA=
D=3Dliblttng-ust-cyg-profile.so ls</div></div><div>----</div><br><div>The f=
irst 'ls' will fail at the same point mentioned above, while the second wil=
l succeed. Off the top of my head I'm struggling to come up with an explana=
tion as to what impact the first execution using LD_PRELOAD would have on t=
he second. Does it impact a shared lib cache in some way, which I'm unaware=
 of?</div><br><div>Any assistance would be appreciated!</div></div></blockq=
uote><div>It appears that sem_timedwait() returns an unexpected error.<br><=
/div><div><br data-mce-bogus=3D"1"></div><div>Can you add a ERROR("sem_time=
dwait"); just before the assert at line 1582 in your liblttng-ust/lttng-ust=
-comm.c<br></div><div>and show us the output ?<br data-mce-bogus=3D"1"></di=
v><div><br data-mce-bogus=3D"1"></div><div>Also, what is the value of your =
LTTNG_UST_REGISTER_TIMEOUT env. var. ?<br data-mce-bogus=3D"1"></div><div><=
br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></di=
v><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px =
solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:norma=
l;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-s=
erif;font-size:12pt;"><div dir=3D"ltr"><div><br>Sean</div><br><br></div><br=
>_______________________________________________<br>lttng-dev mailing list<=
br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D"__S=
IG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://w=
ww.efficios.com</div></div></body></html>
------=_Part_18107_1793406252.1455296549953--


--===============1344978351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1344978351==--
