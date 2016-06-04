From: siddharth teotia <siddharthteotia@gmail.com>
Subject: Re: RCU Question
Date: Fri, 3 Jun 2016 17:21:59 -0700
Message-ID: <CAJw6sH35nkcrOonTQVNM+La3H2_vHVDcgxKRmv1EE20_+69WOw__14620.0886033059$1465233220$gmane$org@mail.gmail.com>
References: <CAJw6sH0=pZX__YaeMwozF673u3Dyn7Jzp3g9q2FuYurThO6paw@mail.gmail.com>
 <CAJw6sH0kFFVvmWm2vRQ+KNTgJaKVXS47OCATY2zHTA0AiSipiQ@mail.gmail.com>
 <1208862117.75733.1462222380579.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7121267850229785995=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id ACADEA3735
 for <lttng-dev@lists.lttng.org>; Sat,  4 Jun 2016 00:22:00 +0000 (UTC)
Received: by mail-io0-f196.google.com with SMTP id p194so12932313iod.0
 for <lttng-dev@lists.lttng.org>; Fri, 03 Jun 2016 17:22:00 -0700 (PDT)
In-Reply-To: <1208862117.75733.1462222380579.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============7121267850229785995==
Content-Type: multipart/alternative; boundary=94eb2c05be56dfa39a053468d39e

--94eb2c05be56dfa39a053468d39e
Content-Type: text/plain; charset=UTF-8

Hi Mathieu,

Thanks for your reply. I somehow missed this email of yours, and saw it
today while I was clearing my inbox.

I appreciate your prompt response.

Thanks,
Siddharth

On Mon, May 2, 2016 at 1:53 PM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

>
> ----- On Apr 29, 2016, at 3:10 PM, siddharth teotia <
> siddharthteotia@gmail.com> wrote:
>
> The mail was accidentally sent. Here is more info:
>
> My question really is that when writing a user space application that
> leverages RCU, how do I ensure that I am using the proper
> flavor/implementation of RCU ? I don't think so I can go ahead with
> non-preemptive RCU. And the user space paper does not really tell or
> distinguish clearly as to which of the following -- QSBR, MB, BP, signal
> can be used for preemptive environments and do not restrict the reader to
> not block or not sleep ?
>
> Hi,
>
> You appear to be confused between concepts that apply to the Linux kernel
> RCU implementation (preemptible vs non-preemptive RCU read-side critical
> sections) and those that apply to the Userspace RCU library (flavors: mb,
> signal,
> qsbr, bp).
>
> All Userspace RCU flavors read-side critical sections are preemptible,
> because we cannot disable preemption when running in user-space.
> Therefore, you may block or sleep within liburcu read-side critical
> sections. However, if you do so, you need to be careful not to place
> calls to synchronize_rcu() within code that have a transitive blocking
> dependency on a RCU read-side, which would cause a deadlock.
>
> For instance, using the same mutex within a read-side critical section,
> _and_ holding this mutex while calling synchronize_rcu() in another thread,
> can trigger a deadlock.
>
> The main differences between liburcu flavors is detailed here:
> https://lwn.net/Articles/573424/#URCU%20Flavors
>
> Thanks,
>
> Mathieu
>
>
> Thanks,
> Siddharth
>
> On Fri, Apr 29, 2016 at 12:07 PM, siddharth teotia <
> siddharthteotia@gmail.com> wrote:
>
>> Hi Guys,
>>
>> I recently started exploring RCU to build a lock free hash table. I have
>> read quite a bit of literature from LWN on RCU, its usage, API etc. I have
>> the following question for which I have had mixed answers online:
>>
>> Does the user space implementation of RCU liburcu take care of preemptive
>> v/s non-preemptive flavors of RCU. From what I understand RCU can be
>> broadly divided into:
>>
>> 1. Classic RCU - High Performance but suitable for non-preemptive
>> environments.
>> 2. Preemptible RCU - Permits the reader to block on a resource or the
>> read side critical sections to be preempted. But still does not allow any
>> kind of sleep(). Moreover there seems to be some sort of limitation on the
>> nature of blocking that can happen within RCU read side critical section.
>> 3. Sleepable RCU - Seems to me an augmentation of preemptible RCU.
>>
>> The paper that describes the user space implementation of RCU suggests 4
>> different flavors -- QSBR, Memory Barrier based, Bullet Proof, and Signal
>> based.
>>
>> I don't think so in my application I can afford to not have the readers
>> block or even sleep. If the reader wants to take some orthogonal lock/latch
>> on an entirely different resource, it might end waiting for it.
>>
>> And because
>>
>>
>>
>
>
> --
> *Best Regards,*
> *SIDDHARTH TEOTIA*
> *2008C6PS540G*
> *BITS PILANI- GOA CAMPUS*
> *+91 87911 75932 <%2B91%2087911%2075932>*
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>



-- 
*Best Regards,*
*SIDDHARTH TEOTIA*
*2008C6PS540G*
*BITS PILANI- GOA CAMPUS*

*+91 87911 75932*

--94eb2c05be56dfa39a053468d39e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi Mathieu,<br><br></div>Thanks for yo=
ur reply. I somehow missed this email of yours, and saw it today while I wa=
s clearing my inbox.<br><br></div>I appreciate your prompt response.<br><br=
></div>Thanks,<br></div>Siddharth<br><div><div><div><div><div><div class=3D=
"gmail_extra"><br><div class=3D"gmail_quote">On Mon, May 2, 2016 at 1:53 PM=
, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.desnoye=
rs@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"font-fami=
ly:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><span class=3D"=
"><div><br></div><div><span>----- On Apr 29, 2016, at 3:10 PM, siddharth te=
otia &lt;<a href=3D"mailto:siddharthteotia@gmail.com" target=3D"_blank">sid=
dharthteotia@gmail.com</a>&gt; wrote:<br></span></div></span><div><span cla=
ss=3D""><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;=
padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decor=
ation:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=
=3D"ltr"><div><div><div>The mail was accidentally sent. Here is more info:<=
br><br></div>My question really is that when writing a user space applicati=
on that leverages RCU, how do I ensure that I am using the proper flavor/im=
plementation of RCU ? I don&#39;t think so I can go ahead with non-preempti=
ve RCU. And the user space paper does not really tell or distinguish clearl=
y as to which of the following -- QSBR, MB, BP, signal can be used for pree=
mptive environments and do not restrict the reader to not block or not slee=
p ?<br></div></div></div></blockquote></span><div><div>Hi,</div><div><br></=
div><div>You appear to be confused between concepts that apply to the Linux=
 kernel</div><div>RCU implementation (preemptible vs non-preemptive RCU rea=
d-side critical</div><div>sections) and those that apply to the Userspace R=
CU library (flavors: mb, signal,</div><div>qsbr, bp).<br></div><div><br></d=
iv><div>All Userspace RCU flavors read-side critical sections are preemptib=
le,<br></div><div>because we cannot disable preemption when running in user=
-space.<br></div><div>Therefore, you may block or sleep within liburcu read=
-side critical<br></div><div>sections. However, if you do so, you need to b=
e careful not to place<br></div><div>calls to synchronize_rcu() within code=
 that have a transitive blocking</div><div>dependency on a RCU read-side, w=
hich would cause a deadlock.<br></div><div><br></div><div>For instance, usi=
ng the same mutex within a read-side critical section,<br></div><div>_and_ =
holding this mutex while calling synchronize_rcu() in another thread,<br></=
div><div>can trigger a deadlock.<br></div><div><br></div><div>The main diff=
erences between liburcu flavors is detailed here:<br></div><div><a href=3D"=
https://lwn.net/Articles/573424/#URCU%20Flavors" target=3D"_blank">https://=
lwn.net/Articles/573424/#URCU%20Flavors</a></div><div><br></div><div>Thanks=
,<br></div><div><br></div><div>Mathieu</div></div><div><br></div><div><br><=
/div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><span class=
=3D""><div dir=3D"ltr"><div>Thanks,<br></div>Siddharth <br></div><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Apr 29, 2016 at 12:=
07 PM, siddharth teotia <span dir=3D"ltr">&lt;<a href=3D"mailto:siddharthte=
otia@gmail.com" target=3D"_blank">siddharthteotia@gmail.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><d=
iv><div><div><div><div>Hi Guys,<br><br></div>I recently started exploring R=
CU to build a lock free hash table. I have read quite a bit of literature f=
rom LWN on RCU, its usage, API etc. I have the following question for which=
 I have had mixed answers online:<br><br></div>Does the user space implemen=
tation of RCU liburcu take care of preemptive v/s non-preemptive flavors of=
 RCU. From what I understand RCU can be broadly divided into:<br><br></div>=
1. Classic RCU - High Performance but suitable for non-preemptive environme=
nts.<br></div>2. Preemptible RCU - Permits the reader to block on a resourc=
e or the read side critical sections to be preempted. But still does not al=
low any kind of sleep(). Moreover there seems to be some sort of limitation=
 on the nature of blocking that can happen within RCU read side critical se=
ction.<br></div>3. Sleepable RCU - Seems to me an augmentation of preemptib=
le RCU.<br><br></div>The paper that describes the user space implementation=
 of RCU suggests 4 different flavors -- QSBR, Memory Barrier based, Bullet =
Proof, and Signal based. <br><br></div>I don&#39;t think so in my applicati=
on I can afford to not have the readers block or even sleep. If the reader =
wants to take some orthogonal lock/latch on an entirely different resource,=
 it might end waiting for it.<br><br></div>And because <br><div><div><div><=
div><div><div><div><div><div><br><br clear=3D"all"></div></div></div></div>=
</div></div></div></div></div></div></blockquote></div><br><br clear=3D"all=
"><br>-- <br><div><div><b><span style=3D"color:#000066" color=3D"#000066">B=
est Regards,</span></b></div><div><b><span style=3D"color:#000066" color=3D=
"#000066">SIDDHARTH TEOTIA</span></b></div><div><b><span style=3D"color:#00=
0066" color=3D"#000066">2008C6PS540G</span></b></div><div><b><span style=3D=
"color:#000066" color=3D"#000066">BITS PILANI- GOA CAMPUS</span></b></div><=
div><b><span style=3D"color:#000066" color=3D"#000066"><a href=3D"tel:%2B91=
%2087911%2075932" value=3D"+918791175932" target=3D"_blank">+91 87911 75932=
</a></span></b></div></div></div><br></span>_______________________________=
________________<br>lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@l=
ists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=
=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" target=3D"_=
blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><span =
class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquote></d=
iv><span class=3D"HOEnZb"><font color=3D"#888888"><div><br></div><div>-- <b=
r></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.ef=
ficios.com" target=3D"_blank">http://www.efficios.com</a></div></font></spa=
n></div></div></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div><b><font colo=
r=3D"#000066">Best Regards,</font></b></div>
<div><b><font color=3D"#000066">SIDDHARTH TEOTIA</font></b></div>
<div><b><font color=3D"#000066">2008C6PS540G</font></b></div>
<div><b><font color=3D"#000066">BITS PILANI- GOA CAMPUS</font></b></div>
<div><b><font color=3D"#000066"></font></b>=C2=A0</div>
<div><b><font color=3D"#000066">+91 87911 75932</font></b></div></div>
</div></div></div></div></div></div></div>

--94eb2c05be56dfa39a053468d39e--

--===============7121267850229785995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7121267850229785995==--
