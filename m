From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Deadlock in call_rcu_thread when destroy rculfhash
 node with nested rculfhash
Date: Wed, 7 Jun 2017 22:05:53 +0000 (UTC)
Message-ID: <1589581211.8300.1496873153210.JavaMail.zimbra__15158.9863388383$1496873082$gmane$org@efficios.com>
References: <CAO6Ho0ea+Mhdoea4b3EL-J4z2wifHPWohq1ps74LQBU+b0-OOQ@mail.gmail.com>
 <CAO6Ho0e27-JTmUPrTRZfr95Lm=ri+mOSRNr7Av5Ma0t1ucuH6g@mail.gmail.com>
 <85898265.59079.1476889412542.JavaMail.zimbra@efficios.com>
 <CAO6Ho0d+LkJi_2ebomx13D42CApEG-bakyTbtzvz+Jvxc4wy9A@mail.gmail.com>
 <5908376.2670.1496322081960.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5930685385863240019=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 by lists.lttng.org (Postfix) with ESMTPS id 3wjjLN4gV4z117s
 for <lttng-dev@lists.lttng.org>; Wed,  7 Jun 2017 22:06:04 +0000 (UTC)
In-Reply-To: <5908376.2670.1496322081960.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Evgeniy Ivanov <i@eivanov.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============5930685385863240019==
Content-Type: multipart/alternative;
	boundary="=_2254f379-9bf6-448a-84da-c0ba23017dda"

--=_2254f379-9bf6-448a-84da-c0ba23017dda
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Jun 1, 2017, at 9:01 AM, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote: 

> ----- On Oct 21, 2016, at 4:19 AM, Evgeniy Ivanov <i@eivanov.com> wrote:

>> On Wed, Oct 19, 2016 at 6:03 PM, Mathieu Desnoyers < [
>> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
>> wrote:

>>> This is because we use call_rcu internally to trigger the hash table
>>> resize.

>>> In cds_lfht_destroy, we start by waiting for "in-flight" resize to complete.
>>> Unfortunately, this requires that call_rcu worker thread progresses. If
>>> cds_lfht_destroy is called from the call_rcu worker thread, it will wait
>>> forever.

>>> One alternative would be to implement our own worker thread scheme
>>> for the rcu HT resize rather than use the call_rcu worker thread. This
>>> would simplify cds_lfht_destroy requirements a lot.

>>> Ideally I'd like to re-use all the call_rcu work dispatch/worker handling
>>> scheme, just as a separate work queue.

>>> Thoughts ?

>> Thank you for explaining. Sounds like a plan: in our prod there is no issue with
>> having extra thread for table resizes. And nested tables is important feature.

> I finally managed to find some time to implement a solution, feedback
> would be welcome!

> Here are the RFC patches:

> https://lists.lttng.org/pipermail/lttng-dev/2017-May/027183.html
> https://lists.lttng.org/pipermail/lttng-dev/2017-May/027184.html

Just merged commits derived from those patches into liburcu master branch. 

Thanks, 

Mathieu 

> Thanks,

> Mathieu

>>> Thanks,

>>> Mathieu

>>> ----- On Oct 19, 2016, at 6:03 AM, Evgeniy Ivanov < [ mailto:i@eivanov.com |
>>> i@eivanov.com ] > wrote:

>>>> Sorry, found partial answer in docs which state that cds_lfht_destroy should not
>>>> be called from a call_rcu thread context. Why does this limitation exists?

>>>> On Wed, Oct 19, 2016 at 12:56 PM, Evgeniy Ivanov < [ mailto:i@eivanov.com |
>>>> i@eivanov.com ] > wrote:

>>>>> Hi,

>>>>> Each node of top level rculfhash has nested rculfhash. Some thread clears the
>>>>> top level map and then uses rcu_barrier() to wait until everything is destroyed
>>>>> (it is done to check leaks). Recently it started to dead lock sometimes with
>>>>> following stacks:

>>>>> Thread1:

>>>>> __poll
>>>>> cds_lfht_destroy <---- nested map
>>>>> ...
>>>>> free_Node(rcu_head*) <----- node of top level map
>>>>> call_rcu_thread

>>>>> Thread2:

>>>>> syscall
>>>>> rcu_barrier_qsbr
>>>>> destroy_all
>>>>> main

>>>>> Did call_rcu_thread dead lock with barrier thread? Or is it some kind of
>>>>> internal deadlock because of nested maps?

>>>>> --
>>>>> Cheers,
>>>>> Evgeniy

>>>> --
>>>> Cheers,
>>>> Evgeniy

>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> [ http://www.efficios.com/ | http://www.efficios.com ]

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> --
>> Cheers,
>> Evgeniy

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_2254f379-9bf6-448a-84da-c0ba23017dda
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Jun 1, 2017, at 9:01 AM, Mathieu Desn=
oyers &lt;mathieu.desnoyers@efficios.com&gt; wrote:<br></span><div data-mar=
ker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;=
margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:n=
ormal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size=
:12pt;"><div style=3D"font-family: arial, helvetica, sans-serif; font-size:=
 12pt; color: #000000"><div><span id=3D"zwchr">----- On Oct 21, 2016, at 4:=
19 AM, Evgeniy Ivanov &lt;i@eivanov.com&gt; wrote:<br></span></div><div><bl=
ockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-lef=
t:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;=
font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><d=
iv class=3D"gmail_extra"><div class=3D"gmail_quote">On Wed, Oct 19, 2016 at=
 6:03 PM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu=
.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12pt;col=
or:rgb(0,0,0)"><div>This is because we use call_rcu internally to trigger t=
he hash table<br></div><div>resize.<br></div><br><div>In cds_lfht_destroy, =
we start by waiting for "in-flight" resize to complete.<br></div><div>Unfor=
tunately, this requires that call_rcu worker thread progresses. If<br></div=
><div>cds_lfht_destroy is called from the call_rcu worker thread, it will w=
ait<br></div><div>forever.<br></div><br><div>One alternative would be to im=
plement our own worker thread scheme<br></div><div>for the rcu HT resize ra=
ther than use the call_rcu worker thread. This</div><div>would simplify cds=
_lfht_destroy requirements a lot.<br></div><br><div>Ideally I'd like to re-=
use all the call_rcu work dispatch/worker handling<br></div><div>scheme, ju=
st as a separate work queue.<br></div><br><div>Thoughts ?<br></div></div></=
div></blockquote><br><div>Thank you for explaining. Sounds like a plan: in =
our prod there is no issue with having extra thread for table resizes. And =
nested tables is important feature.<br></div></div></div></div></blockquote=
><div>I finally managed to find some time to implement a solution, feedback=
<br></div><div>would be welcome!<br></div><br><div>Here are the RFC patches=
:<br></div><br><div>https://lists.lttng.org/pipermail/lttng-dev/2017-May/02=
7183.html<br></div><div>https://lists.lttng.org/pipermail/lttng-dev/2017-Ma=
y/027184.html</div></div></div></blockquote><div><br></div><div>Just merged=
 commits derived from those patches into liburcu master branch.<br data-mce=
-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Thanks,<br data=
-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br =
data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote =
style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;col=
or:#000;font-weight:normal;font-style:normal;text-decoration:none;font-fami=
ly:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"font-family: a=
rial, helvetica, sans-serif; font-size: 12pt; color: #000000"><div><div><br=
></div><br><div>Thanks,<br></div><br><div>Mathieu<br></div><br><br><br><blo=
ckquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left=
:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;f=
ont-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><br><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div><div style=3D"font-family:arial,helvetic=
a,sans-serif;font-size:12pt;color:rgb(0,0,0)"><div><span style=3D"font-fami=
ly:arial,sans-serif;font-size:small;color:rgb(34,34,34)">&nbsp;</span><br><=
/div></div></div></blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-size:12=
pt;color:rgb(0,0,0)"><div>Thanks,<br></div><br><div>Mathieu<br></div><div><=
div class=3D"gmail-h5"><br><span id=3D"gmail-m_1548600653268589583zwchr">--=
--- On Oct 19, 2016, at 6:03 AM, Evgeniy Ivanov &lt;<a href=3D"mailto:i@eiv=
anov.com" target=3D"_blank">i@eivanov.com</a>&gt; wrote:<br></span></div></=
div><div><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-l=
eft:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:nor=
mal;text-decoration:none;font-family:helvetica,arial,sans-serif;font-size:1=
2pt"><div><div class=3D"gmail-h5"><div dir=3D"ltr">Sorry, found partial ans=
wer in docs which state that&nbsp;cds_lfht_destroy should not be called&nbs=
p;from a call_rcu thread context. Why does this limitation exists?</div><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Oct 19, 2016=
 at 12:56 PM, Evgeniy Ivanov <span dir=3D"ltr">&lt;<a href=3D"mailto:i@eiva=
nov.com" target=3D"_blank">i@eivanov.com</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi,<br><br>Each n=
ode of top level rculfhash has nested rculfhash. Some thread clears the top=
 level map and then uses rcu_barrier() to wait until everything is destroye=
d (it is done to check leaks). Recently it started to dead lock sometimes w=
ith following stacks:<br><br>Thread1:<br><span style=3D"font-family:monospa=
ce,monospace"><br></span><div><span style=3D"font-family:monospace,monospac=
e">__poll<br>cds_lfht_destroy &nbsp; &nbsp;&lt;---- nested map<br>...<br>fr=
ee_Node(rcu_head*) &nbsp;&lt;----- node of top level map<br>call_rcu_thread=
<br></span><br>Thread2:<div><br><span style=3D"font-family:monospace,monosp=
ace">syscall <br>rcu_barrier_qsbr <br>destroy_all<br>main<br></span><br><br=
>Did&nbsp;call_rcu_thread dead lock with barrier thread? Or is it some kind=
 of internal deadlock because of nested maps?<span class=3D"gmail-m_1548600=
653268589583HOEnZb"><span style=3D"color:rgb(136,136,136)"><br><br><br>-- <=
br>Cheers,<br>Evgeniy</span></span></div></div></div></blockquote></div><br=
><br clear=3D"all"><br>-- <br><div class=3D"gmail-m_1548600653268589583gmai=
l_signature">Cheers,<br>Evgeniy</div></div><br></div></div>________________=
_______________________________<br>lttng-dev mailing list<br><a href=3D"mai=
lto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org<=
/a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-de=
v" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng=
-dev</a><span class=3D"gmail-HOEnZb"><span style=3D"color: #888888;"><br></=
span></span></blockquote></div><span class=3D"gmail-HOEnZb"><span style=3D"=
color: #888888;"><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS I=
nc.<br><a href=3D"http://www.efficios.com" target=3D"_blank">http://www.eff=
icios.com</a><br></div></span></span></div></div><br>______________________=
_________________________<br>
lttng-dev mailing list<br><a href=3D"mailto:lttng-dev@lists.lttng.org" targ=
et=3D"_blank">lttng-dev@lists.lttng.org</a><br><a href=3D"https://lists.ltt=
ng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_bl=
ank">https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br><br>=
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature">Cheers,<br>Evgeniy</div></div></div><br>___________________________=
____________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org=
<br>https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockqu=
ote></div><br><div>-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>=
http://www.efficios.com</div></div><br>____________________________________=
___________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>https=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div=
><br><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<=
br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_2254f379-9bf6-448a-84da-c0ba23017dda--

--===============5930685385863240019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============5930685385863240019==--
