From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Crash on first run of target using
 liblttng-ust-cyg-profile.so, but subsequent runs succeed
Date: Fri, 12 Feb 2016 20:47:10 +0000 (UTC)
Message-ID: <98246560.18416.1455310030702.JavaMail.zimbra__30236.9121149697$1455310094$gmane$org@efficios.com>
References: <CAL90rL8u1_3ifDL2QzrqrQMp3+68PhOsMfgdsYhceoLX__MAJw@mail.gmail.com>
 <1762935886.18108.1455296549954.JavaMail.zimbra@efficios.com>
 <609823872.18327.1455308463772.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0607031941=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aUKca-0003hQ-7Y
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 15:47:21 -0500
In-Reply-To: <609823872.18327.1455308463772.JavaMail.zimbra@efficios.com>
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

--===============0607031941==
Content-Type: multipart/alternative;
	boundary="----=_Part_18415_1900598399.1455310030701"

------=_Part_18415_1900598399.1455310030701
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Feb 12, 2016, at 3:21 PM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote: 

> ----- On Feb 12, 2016, at 12:02 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:

>> ---- On Feb 11, 2016, at 9:01 AM, Sean Heelan <seanheelan@gmail.com> wrote:

>>> Hi all,
>>> I am running a target within a Docker instance, and tracing function execution
>>> using the latest LTTng release (2.7). The commands I am issuing look as
>>> follows:

>>> ----
>>> lttng create cc_session -o bla
>>> lttng enable-event --userspace lttng_ust_cyg_profile:func_entry
>>> lttng start

>>> LD_PRELOAD=liblttng-ust-cyg-profile.so target

>>> lttng stop
>>> lttng destroy
>>> ----

>>> When the target is executed it aborts with the following error:

>>> ----
>>> php: lttng-ust-comm.c:1582: lttng_ust_init: Assertion `!ret' failed.
>>> ----

>>> If I rerun the command it then works fine. In fact, simply doing the following
>>> within the Docker container demonstrates the issue:

>>> ----
>>> LD_PRELOAD=liblttng-ust-cyg-profile.so ls
>>> LD_PRELOAD=liblttng-ust-cyg-profile.so ls
>>> ----

>>> The first 'ls' will fail at the same point mentioned above, while the second
>>> will succeed. Off the top of my head I'm struggling to come up with an
>>> explanation as to what impact the first execution using LD_PRELOAD would have
>>> on the second. Does it impact a shared lib cache in some way, which I'm unaware
>>> of?

>>> Any assistance would be appreciated!

>> It appears that sem_timedwait() returns an unexpected error.

>> Can you add a ERROR("sem_timedwait"); just before the assert at line 1582 in
>> your liblttng-ust/lttng-ust-comm.c
>> and show us the output ?

>> Also, what is the value of your LTTNG_UST_REGISTER_TIMEOUT env. var. ?

> Also, what architecture, Linux distribution, and kernel
> version are you using ?

I pushed the following fix in lttng-ust: 

commit 5cf81d53e305c81517e48e0dc91620a916cdc0cc 
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 
Date: Fri Feb 12 15:44:10 2016 -0500 

Fix: handle negative range for LTTNG_UST_REGISTER_TIMEOUT 

We should not consider values below -1 as valid timeout values, this is 
is unexpected and could lead to EINVAL errors returned by sem_timedwait. 

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com> 

Let me know if it helps, 

Thanks, 

Mathieu 

> Thanks,

> Mathieu

>> Thanks,

>> Mathieu

>>> Sean

>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_18415_1900598399.1455310030701
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Feb 12, 2016, at 3:21 PM, Mathieu Des=
noyers &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br></span><div data-ma=
rker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF=
;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:=
normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-siz=
e:12pt;"><div style=3D"font-family: arial, helvetica, sans-serif; font-size=
: 12pt; color: #000000"><div><span id=3D"zwchr">----- On Feb 12, 2016, at 1=
2:02 PM, Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br=
></span></div><div><blockquote style=3D"border-left:2px solid #1010FF;margi=
n-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal=
;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt=
;"><div style=3D"font-family: arial, helvetica, sans-serif; font-size: 12pt=
; color: #000000"><div><span id=3D"zwchr">---- On Feb 11, 2016, at 9:01 AM,=
 Sean Heelan &lt;seanheelan@gmail.com&gt; wrote:<br></span></div><div><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr">Hi a=
ll,<br><div>I am running a target within a Docker instance, and tracing fun=
ction execution using the latest LTTng release (2.7). The commands I am iss=
uing look as follows:</div><br><div>----<br></div><div><div>lttng create cc=
_session -o bla</div><div>lttng enable-event --userspace lttng_ust_cyg_prof=
ile:func_entry</div><div>lttng start</div><br><div>LD_PRELOAD=3Dliblttng-us=
t-cyg-profile.so target</div><br><div>lttng stop</div><div>lttng destroy</d=
iv><div>----</div></div><br><div>When the target is executed it aborts with=
 the following error:</div><br><div>----</div><div>php: lttng-ust-comm.c:15=
82: lttng_ust_init: Assertion `!ret' failed.<br></div><div>----</div><br><d=
iv>If I rerun the command it then works fine. In fact, simply doing the fol=
lowing within the Docker container demonstrates the issue:</div><br><div>--=
--</div><div><div>LD_PRELOAD=3Dliblttng-ust-cyg-profile.so ls</div><div>LD_=
PRELOAD=3Dliblttng-ust-cyg-profile.so ls</div></div><div>----</div><br><div=
>The first 'ls' will fail at the same point mentioned above, while the seco=
nd will succeed. Off the top of my head I'm struggling to come up with an e=
xplanation as to what impact the first execution using LD_PRELOAD would hav=
e on the second. Does it impact a shared lib cache in some way, which I'm u=
naware of?</div><br><div>Any assistance would be appreciated!</div></div></=
blockquote><div>It appears that sem_timedwait() returns an unexpected error=
.<br></div><br><div>Can you add a ERROR("sem_timedwait"); just before the a=
ssert at line 1582 in your liblttng-ust/lttng-ust-comm.c<br></div><div>and =
show us the output ?<br></div><br><div>Also, what is the value of your LTTN=
G_UST_REGISTER_TIMEOUT env. var. ?</div></div></div></blockquote><br><div>A=
lso, what architecture, Linux distribution, and kernel<br></div><div>versio=
n are you using ?</div></div></div></blockquote><div><br></div><div>I pushe=
d the following fix in lttng-ust:<br data-mce-bogus=3D"1"></div><div><br da=
ta-mce-bogus=3D"1"></div><div>commit 5cf81d53e305c81517e48e0dc91620a916cdc0=
cc<br>Author: Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;<br>D=
ate:&nbsp;&nbsp; Fri Feb 12 15:44:10 2016 -0500<br><br>&nbsp;&nbsp;&nbsp; F=
ix: handle negative range for LTTNG_UST_REGISTER_TIMEOUT<br>&nbsp;&nbsp; &n=
bsp;<br>&nbsp;&nbsp;&nbsp; We should not consider values below -1 as valid =
timeout values, this is<br>&nbsp;&nbsp;&nbsp; is unexpected and could lead =
to EINVAL errors returned by sem_timedwait.<br>&nbsp;&nbsp; &nbsp;<br>&nbsp=
;&nbsp;&nbsp; Signed-off-by: Mathieu Desnoyers &lt;mathieu.desnoyers@effici=
os.com&gt;<br></div><div><br data-mce-bogus=3D"1"></div><div>Let me know if=
 it helps,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></di=
v><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D=
"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-l=
eft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weig=
ht:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Aria=
l,sans-serif;font-size:12pt;"><div style=3D"font-family: arial, helvetica, =
sans-serif; font-size: 12pt; color: #000000"><div><div><br></div><br><div>T=
hanks,<br></div><br><div>Mathieu<br></div><br><blockquote style=3D"border-l=
eft:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weig=
ht:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Aria=
l,sans-serif;font-size:12pt;"><div style=3D"font-family: arial, helvetica, =
sans-serif; font-size: 12pt; color: #000000"><div><br><br><div>Thanks,<br><=
/div><br><div>Mathieu<br></div><br><blockquote style=3D"border-left:2px sol=
id #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;f=
ont-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-seri=
f;font-size:12pt;"><div dir=3D"ltr"><div><br>Sean</div><br><br></div><br>__=
_____________________________________________<br>lttng-dev mailing list<br>=
lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev<br></blockquote></div><br><div>-- <br></div><div>Mathieu Desnoy=
ers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div><br>____________=
___________________________________<br>lttng-dev mailing list<br>lttng-dev@=
lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v<br></blockquote></div><br><div>-- <br></div><div>Mathieu Desnoyers<br>Eff=
iciOS Inc.<br>http://www.efficios.com</div></div><br>______________________=
_________________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttn=
g.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blo=
ckquote></div><br><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathi=
eu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body>=
</html>
------=_Part_18415_1900598399.1455310030701--


--===============0607031941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0607031941==--
