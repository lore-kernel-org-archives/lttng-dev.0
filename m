From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: RCU Question
Date: Mon, 2 May 2016 20:53:00 +0000 (UTC)
Message-ID: <1208862117.75733.1462222380579.JavaMail.zimbra__47084.4950447374$1462222409$gmane$org@efficios.com>
References: <CAJw6sH0=pZX__YaeMwozF673u3Dyn7Jzp3g9q2FuYurThO6paw@mail.gmail.com>
 <CAJw6sH0kFFVvmWm2vRQ+KNTgJaKVXS47OCATY2zHTA0AiSipiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7263382474976954180=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id AEED7A0117
 for <lttng-dev@lists.lttng.org>; Mon,  2 May 2016 20:53:06 +0000 (UTC)
In-Reply-To: <CAJw6sH0kFFVvmWm2vRQ+KNTgJaKVXS47OCATY2zHTA0AiSipiQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: siddharth teotia <siddharthteotia@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============7263382474976954180==
Content-Type: multipart/alternative;
	boundary="----=_Part_75732_1632041831.1462222380578"

------=_Part_75732_1632041831.1462222380578
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Apr 29, 2016, at 3:10 PM, siddharth teotia <siddharthteotia@gmail.com> wrote: 

> The mail was accidentally sent. Here is more info:

> My question really is that when writing a user space application that leverages
> RCU, how do I ensure that I am using the proper flavor/implementation of RCU ?
> I don't think so I can go ahead with non-preemptive RCU. And the user space
> paper does not really tell or distinguish clearly as to which of the following
> -- QSBR, MB, BP, signal can be used for preemptive environments and do not
> restrict the reader to not block or not sleep ?

Hi, 

You appear to be confused between concepts that apply to the Linux kernel 
RCU implementation (preemptible vs non-preemptive RCU read-side critical 
sections) and those that apply to the Userspace RCU library (flavors: mb, signal, 
qsbr, bp). 

All Userspace RCU flavors read-side critical sections are preemptible, 
because we cannot disable preemption when running in user-space. 
Therefore, you may block or sleep within liburcu read-side critical 
sections. However, if you do so, you need to be careful not to place 
calls to synchronize_rcu() within code that have a transitive blocking 
dependency on a RCU read-side, which would cause a deadlock. 

For instance, using the same mutex within a read-side critical section, 
_and_ holding this mutex while calling synchronize_rcu() in another thread, 
can trigger a deadlock. 

The main differences between liburcu flavors is detailed here: 
https://lwn.net/Articles/573424/#URCU%20Flavors 

Thanks, 

Mathieu 

> Thanks,
> Siddharth

> On Fri, Apr 29, 2016 at 12:07 PM, siddharth teotia < siddharthteotia@gmail.com >
> wrote:

>> Hi Guys,

>> I recently started exploring RCU to build a lock free hash table. I have read
>> quite a bit of literature from LWN on RCU, its usage, API etc. I have the
>> following question for which I have had mixed answers online:

>> Does the user space implementation of RCU liburcu take care of preemptive v/s
>> non-preemptive flavors of RCU. From what I understand RCU can be broadly
>> divided into:

>> 1. Classic RCU - High Performance but suitable for non-preemptive environments.
>> 2. Preemptible RCU - Permits the reader to block on a resource or the read side
>> critical sections to be preempted. But still does not allow any kind of
>> sleep(). Moreover there seems to be some sort of limitation on the nature of
>> blocking that can happen within RCU read side critical section.
>> 3. Sleepable RCU - Seems to me an augmentation of preemptible RCU.

>> The paper that describes the user space implementation of RCU suggests 4
>> different flavors -- QSBR, Memory Barrier based, Bullet Proof, and Signal
>> based.

>> I don't think so in my application I can afford to not have the readers block or
>> even sleep. If the reader wants to take some orthogonal lock/latch on an
>> entirely different resource, it might end waiting for it.

>> And because

> --
> Best Regards,
> SIDDHARTH TEOTIA
> 2008C6PS540G
> BITS PILANI- GOA CAMPUS
> +91 87911 75932

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_75732_1632041831.1462222380578
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><span id=3D"zwchr" data-mark=
er=3D"__DIVIDER__">----- On Apr 29, 2016, at 3:10 PM, siddharth teotia &lt;=
siddharthteotia@gmail.com&gt; wrote:<br></span></div><div data-marker=3D"__=
QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><=
div dir=3D"ltr"><div><div><div>The mail was accidentally sent. Here is more=
 info:<br><br></div>My question really is that when writing a user space ap=
plication that leverages RCU, how do I ensure that I am using the proper fl=
avor/implementation of RCU ? I don't think so I can go ahead with non-preem=
ptive RCU. And the user space paper does not really tell or distinguish cle=
arly as to which of the following -- QSBR, MB, BP, signal can be used for p=
reemptive environments and do not restrict the reader to not block or not s=
leep ?<br></div></div></div></blockquote><div><div>Hi,</div><div><br></div>=
<div>You appear to be confused between concepts that apply to the Linux ker=
nel</div><div>RCU implementation (preemptible vs non-preemptive RCU read-si=
de critical</div><div>sections) and those that apply to the Userspace RCU l=
ibrary (flavors: mb, signal,</div><div>qsbr, bp).<br data-mce-bogus=3D"1"><=
/div><div><br data-mce-bogus=3D"1"></div><div>All Userspace RCU flavors rea=
d-side critical sections are preemptible,<br data-mce-bogus=3D"1"></div><di=
v>because we cannot disable preemption when running in user-space.<br data-=
mce-bogus=3D"1"></div><div>Therefore, you may block or sleep within liburcu=
 read-side critical<br data-mce-bogus=3D"1"></div><div>sections. However, i=
f you do so, you need to be careful not to place<br data-mce-bogus=3D"1"></=
div><div>calls to synchronize_rcu() within code that have a transitive bloc=
king</div><div>dependency on a RCU read-side, which would cause a deadlock.=
<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>For=
 instance, using the same mutex within a read-side critical section,<br dat=
a-mce-bogus=3D"1"></div><div>_and_ holding this mutex while calling synchro=
nize_rcu() in another thread,<br data-mce-bogus=3D"1"></div><div>can trigge=
r a deadlock.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"><=
/div><div>The main differences between liburcu flavors is detailed here:<br=
 data-mce-bogus=3D"1"></div><div>https://lwn.net/Articles/573424/#URCU%20Fl=
avors</div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bog=
us=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu</div></div>=
<div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><bl=
ockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-lef=
t:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;=
font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><d=
iv>Thanks,<br></div>Siddharth <br></div><div class=3D"gmail_extra"><br><div=
 class=3D"gmail_quote">On Fri, Apr 29, 2016 at 12:07 PM, siddharth teotia <=
span dir=3D"ltr">&lt;<a href=3D"mailto:siddharthteotia@gmail.com" target=3D=
"_blank">siddharthteotia@gmail.com</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div dir=3D"ltr"><div><div><div><div><div><div><div><div>Hi=
 Guys,<br><br></div>I recently started exploring RCU to build a lock free h=
ash table. I have read quite a bit of literature from LWN on RCU, its usage=
, API etc. I have the following question for which I have had mixed answers=
 online:<br><br></div>Does the user space implementation of RCU liburcu tak=
e care of preemptive v/s non-preemptive flavors of RCU. From what I underst=
and RCU can be broadly divided into:<br><br></div>1. Classic RCU - High Per=
formance but suitable for non-preemptive environments.<br></div>2. Preempti=
ble RCU - Permits the reader to block on a resource or the read side critic=
al sections to be preempted. But still does not allow any kind of sleep(). =
Moreover there seems to be some sort of limitation on the nature of blockin=
g that can happen within RCU read side critical section.<br></div>3. Sleepa=
ble RCU - Seems to me an augmentation of preemptible RCU.<br><br></div>The =
paper that describes the user space implementation of RCU suggests 4 differ=
ent flavors -- QSBR, Memory Barrier based, Bullet Proof, and Signal based. =
<br><br></div>I don't think so in my application I can afford to not have t=
he readers block or even sleep. If the reader wants to take some orthogonal=
 lock/latch on an entirely different resource, it might end waiting for it.=
<br><br></div>And because <br><div><div><div><div><div><div><div><div><div>=
<br><br clear=3D"all"></div></div></div></div></div></div></div></div></div=
></div></blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gm=
ail_signature"><div><strong><span style=3D"color: #000066;" data-mce-style=
=3D"color: #000066;" color=3D"#000066">Best Regards,</span></strong></div><=
div><strong><span style=3D"color: #000066;" data-mce-style=3D"color: #00006=
6;" color=3D"#000066">SIDDHARTH TEOTIA</span></strong></div><div><strong><s=
pan style=3D"color: #000066;" data-mce-style=3D"color: #000066;" color=3D"#=
000066">2008C6PS540G</span></strong></div><div><strong><span style=3D"color=
: #000066;" data-mce-style=3D"color: #000066;" color=3D"#000066">BITS PILAN=
I- GOA CAMPUS</span></strong></div><div><strong><span style=3D"color: #0000=
66;" data-mce-style=3D"color: #000066;" color=3D"#000066">+91 87911 75932</=
span></strong></div></div></div><br>_______________________________________=
________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https://=
lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><d=
iv><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu De=
snoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></htm=
l>
------=_Part_75732_1632041831.1462222380578--

--===============7263382474976954180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7263382474976954180==--
